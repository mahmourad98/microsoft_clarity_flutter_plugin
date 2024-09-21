import Flutter
import UIKit
import Clarity

public class MicrosoftClarityPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "microsoft_clarity_plugin", binaryMessenger: registrar.messenger())
    let instance = MicrosoftClarityPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any] else {
      let emptyArgs: [String: Any] = [:]
      return
    }
    switch call.method {
    case "initializeMicrosoftClarity":
      if let projectId = Bundle.main.object(forInfoDictionaryKey: "microsoft_clarity_project_id") as? String {
        initializeMicrosoftClarity(projectId: projectId)
        result("Clarity Initialized")
      } else {
        result(FlutterError(code: "NO_PROJECT_ID", message: "Project ID not found", details: nil))
      }
    case "setCustomUserId":
      if let id = args["customUserId"] as? String {
        ClaritySDK.setCustomUserId(id)
        result("custom user ID set successfully")
      } else {
        result(FlutterError(code: "MISSING_CUSTOM_USER_ID", message: "custom user ID is required", details: nil))
      }
    case "getCurrentSessionId":
      result(ClaritySDK.getCurrentSessionId())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func initializeMicrosoftClarity(projectId: String) {
    let clarityConfig = ClarityConfig(
      projectId: projectId,
      userId: nil, // Default user id
      logLevel: LogLevel.verbose,
      allowMeteredNetworkUsage: true, // Allow metered network usage
      enableWebViewCapture: true, // Enable web view capturing
      disableOnLowEndDevices: false, // Allow running on low-end devices
      applicationFramework: ApplicationFramework.native
    )
    ClaritySDK.initialize(config: clarityConfig)
  }
}
