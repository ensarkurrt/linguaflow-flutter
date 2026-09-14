import CryptoKit
import DeviceCheck
import Flutter
import Foundation

public final class LinguaflowPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "dev.linguaflow/app_attest",
      binaryMessenger: registrar.messenger()
    )
    registrar.addMethodCallDelegate(LinguaflowPlugin(), channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "appVersion" {
      let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
      let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
      result(["name": name ?? "", "code": build ?? ""])
      return
    }
    guard #available(iOS 14.0, *) else {
      if call.method == "isSupported" {
        result(false)
      } else {
        result(error("unavailable", "App Attest requires iOS 14 or newer"))
      }
      return
    }
    switch call.method {
    case "isSupported":
      result(DCAppAttestService.shared.isSupported)
    case "bundleIdentifier":
      guard let bundleId = Bundle.main.bundleIdentifier else {
        result(error("invalid_bundle", "Bundle identifier is unavailable"))
        return
      }
      result(bundleId)
    case "storedKeyId":
      guard let environment = argument("environment", from: call) else {
        result(invalidArguments())
        return
      }
      result(UserDefaults.standard.string(forKey: storageKey(environment)))
    case "storeKey":
      guard
        let environment = argument("environment", from: call),
        let keyId = argument("keyId", from: call)
      else {
        result(invalidArguments())
        return
      }
      UserDefaults.standard.set(keyId, forKey: storageKey(environment))
      result(nil)
    case "clearKey":
      guard let environment = argument("environment", from: call) else {
        result(invalidArguments())
        return
      }
      UserDefaults.standard.removeObject(forKey: storageKey(environment))
      result(nil)
    case "generateKey":
      DCAppAttestService.shared.generateKey { keyId, generationError in
        self.complete(result, value: keyId, failure: generationError)
      }
    case "attest", "assertion":
      proof(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  @available(iOS 14.0, *)
  private func proof(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard
      let keyId = argument("keyId", from: call),
      let challenge = argument("challenge", from: call),
      let challengeData = challenge.data(using: .utf8)
    else {
      result(invalidArguments())
      return
    }
    let clientDataHash = Data(SHA256.hash(data: challengeData))
    let completion: (Data?, Error?) -> Void = { proof, proofError in
      self.complete(result, value: proof?.base64EncodedString(), failure: proofError)
    }
    if call.method == "attest" {
      DCAppAttestService.shared.attestKey(
        keyId,
        clientDataHash: clientDataHash,
        completionHandler: completion
      )
    } else {
      DCAppAttestService.shared.generateAssertion(
        keyId,
        clientDataHash: clientDataHash,
        completionHandler: completion
      )
    }
  }

  private func argument(_ name: String, from call: FlutterMethodCall) -> String? {
    (call.arguments as? [String: Any])?[name] as? String
  }

  private func storageKey(_ environment: String) -> String {
    "linguaflow:\(Bundle.main.bundleIdentifier ?? "unknown"):\(environment):app-attest-key"
  }

  private func complete(
    _ result: @escaping FlutterResult,
    value: String?,
    failure: Error?
  ) {
    DispatchQueue.main.async {
      if let failure {
        result(self.error("app_attest_failed", failure.localizedDescription))
      } else if let value {
        result(value)
      } else {
        result(self.error("app_attest_failed", "App Attest returned no value"))
      }
    }
  }

  private func invalidArguments() -> FlutterError {
    error("invalid_arguments", "Required App Attest arguments are missing")
  }

  private func error(_ code: String, _ message: String) -> FlutterError {
    FlutterError(code: code, message: message, details: nil)
  }
}
