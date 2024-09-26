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
    switch call.method {
      case "initializeMicrosoftClarity":
        if let projectId = Bundle.main.object(forInfoDictionaryKey: "MICROSOFT_CLARITY_PROJECT_ID") as? String {
          initializeMicrosoftClarity(projectId: projectId)
          print("MICROSOFT_CLARITY_PROJECT initialized successfully.")
          result("clarity-project-initialization-success")
        } else {
          print("MICROSOFT_CLARITY_PROJECT_ID not found in Info.plist file.")
          result(FlutterError(code: "MISSING_MICROSOFT_CLARITY_PROJECT_ID", message: "project id is required", details: nil))
        }
      case "setCustomUserId":
        if let args = call.arguments as? Dictionary<String, Any>, let id = args["customUserId"] as? String {
          ClaritySDK.setCustomUserId(id)
          print("CUSTOM_USER_ID was not provided.")
          result("custom-user-id-setting-success")
        } else {
          print("CUSTOM_USER_ID not passed in arguments")
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