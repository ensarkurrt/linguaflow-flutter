package dev.linguaflow.flutter;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import androidx.annotation.NonNull;
import com.google.android.play.core.integrity.IntegrityManagerFactory;
import com.google.android.play.core.integrity.StandardIntegrityManager;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import java.util.Map;
import java.util.HashMap;
import java.util.concurrent.ConcurrentHashMap;

/** Flutter bridge for Google Play Integrity standard requests. */
public final class LinguaflowPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {
  private static final String CHANNEL = "dev.linguaflow/play_integrity";

  private final Map<Long, StandardIntegrityManager.StandardIntegrityTokenProvider> providers =
      new ConcurrentHashMap<>();
  private Context applicationContext;
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    applicationContext = binding.getApplicationContext();
    channel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL);
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    providers.clear();
    channel = null;
    applicationContext = null;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
    switch (call.method) {
      case "packageName" -> result.success(applicationContext.getPackageName());
      case "appVersion" -> appVersion(result);
      case "requestToken" -> requestToken(call, result);
      default -> result.notImplemented();
    }
  }

  @SuppressWarnings("deprecation")
  private void appVersion(MethodChannel.Result result) {
    try {
      PackageInfo info =
          Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU
              ? applicationContext
                  .getPackageManager()
                  .getPackageInfo(
                      applicationContext.getPackageName(),
                      PackageManager.PackageInfoFlags.of(0))
              : applicationContext
                  .getPackageManager()
                  .getPackageInfo(applicationContext.getPackageName(), 0);
      long code =
          Build.VERSION.SDK_INT >= Build.VERSION_CODES.P
              ? info.getLongVersionCode()
              : info.versionCode;
      Map<String, String> version = new HashMap<>();
      version.put("name", info.versionName == null ? "" : info.versionName);
      version.put("code", Long.toString(code));
      result.success(version);
    } catch (PackageManager.NameNotFoundException error) {
      result.error("package_info_unavailable", error.getLocalizedMessage(), null);
    }
  }

  private void requestToken(MethodCall call, MethodChannel.Result result) {
    Number projectArgument = call.argument("cloudProjectNumber");
    String requestHash = call.argument("requestHash");
    if (projectArgument == null || projectArgument.longValue() <= 0 || isBlank(requestHash)) {
      result.error(
          "invalid_arguments", "cloudProjectNumber and requestHash are required", null);
      return;
    }

    long cloudProjectNumber = projectArgument.longValue();
    StandardIntegrityManager.StandardIntegrityTokenProvider cached =
        providers.get(cloudProjectNumber);
    if (cached != null) {
      request(cached, requestHash, result);
      return;
    }

    StandardIntegrityManager manager = IntegrityManagerFactory.createStandard(applicationContext);
    StandardIntegrityManager.PrepareIntegrityTokenRequest preparation =
        StandardIntegrityManager.PrepareIntegrityTokenRequest.builder()
            .setCloudProjectNumber(cloudProjectNumber)
            .build();
    manager
        .prepareIntegrityToken(preparation)
        .addOnSuccessListener(
            provider -> {
              providers.put(cloudProjectNumber, provider);
              request(provider, requestHash, result);
            })
        .addOnFailureListener(
            failure ->
                result.error(
                    "play_integrity_prepare_failed", failure.getLocalizedMessage(), null));
  }

  private void request(
      StandardIntegrityManager.StandardIntegrityTokenProvider provider,
      String requestHash,
      MethodChannel.Result result) {
    StandardIntegrityManager.StandardIntegrityTokenRequest request =
        StandardIntegrityManager.StandardIntegrityTokenRequest.builder()
            .setRequestHash(requestHash)
            .build();
    provider
        .request(request)
        .addOnSuccessListener(token -> result.success(token.token()))
        .addOnFailureListener(
            failure ->
                result.error(
                    "play_integrity_request_failed", failure.getLocalizedMessage(), null));
  }

  private boolean isBlank(String value) {
    return value == null || value.trim().isEmpty();
  }
}
