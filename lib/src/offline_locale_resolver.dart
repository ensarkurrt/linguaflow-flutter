import 'linguaflow_models.dart';

LocaleResolution resolveOfflineLocale(
  LocaleManifest manifest, {
  String? selectedLocale,
  String? deviceLocale,
}) {
  LocaleResolution? resolve(
      String? candidate, LocaleResolutionReason directReason) {
    if (candidate == null) return null;
    final normalized = normalizeLocale(candidate);
    final exactRoute = _findRoute(manifest, normalized);
    final baseRoute = _findRoute(manifest, normalized.split('-').first);
    final route = exactRoute ?? baseRoute;
    if (route != null && manifest.translatedLocales.contains(route.value)) {
      return (
        requestedLocale: route.key,
        resolvedLocale: route.value,
        reason: LocaleResolutionReason.mapped,
      );
    }
    for (final locale in manifest.translatedLocales) {
      if (normalizeLocale(locale) == normalized) {
        return (
          requestedLocale: locale,
          resolvedLocale: locale,
          reason: directReason,
        );
      }
    }
    final language = normalized.split('-').first;
    for (final locale in manifest.translatedLocales) {
      if (normalizeLocale(locale).split('-').first == language) {
        return (
          requestedLocale: locale,
          resolvedLocale: locale,
          reason: directReason,
        );
      }
    }
    return null;
  }

  return (selectedLocale == null
          ? resolve(deviceLocale, LocaleResolutionReason.device)
          : resolve(selectedLocale, LocaleResolutionReason.selected)) ??
      (
        requestedLocale: manifest.fallbackLocale,
        resolvedLocale: manifest.fallbackLocale,
        reason: LocaleResolutionReason.fallback,
      );
}

MapEntry<String, String>? _findRoute(LocaleManifest manifest, String locale) {
  for (final entry in manifest.localeMappings.entries) {
    if (normalizeLocale(entry.key) == locale) return entry;
  }
  return null;
}
