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
    guard let args = call.arguments as? [String : Any] else {
      args = [:]
      continue
    }
    switch call.method {
      case "initializeMicrosoftClarity":
        if let projectId = Bundle.main.object(forInfoDictionaryKey: "microsoft_clarity_project_id") as? String {
          initializeMicrosoftClarity(projectId: projectId)
          result("Clarity Initialized")
        } else {
          result("Project ID not found")
        }
      case "setCustomUserId":
        if let id = args["customUserId"] as? String {
          ClaritySDK.setCustomUserId(id: id)
          result.success("custom user ID set successfully")
        } else {
          result("custom user ID is required")
        }
      case "getCurrentSessionId":
        result(ClaritySDK.getCurrentSessionId())
      default: result(FlutterMethodNotImplemented)
    }
  }

  private func initializeMicrosoftClarity(projectId: String) {
    let clarityConfig = ClarityConfig(
        projectId: projectId,
        logLevel: LogLevel.verbose,
        applicationFramework: ApplicationFramework.native,
        userId: null, // Default user id
        allowMeteredNetworkUsage: true, // Disallow metered network usage
        enableWebViewCapture: true, // Enable web view capturing
        allowedDomains: ["*"], // Allowed domains
        allowedActivities: [], // Allowed activities
        disallowedActivities = [], // Disallowed activities (ignore activities)
        disableOnLowEndDevices: false, // Disallow Low End Devices
        maximumDailyNetworkUsageInMB: null // Disable on low-end devices
    )
    ClaritySDK.initialize(config: clarityConfig)
  }
}
