import 'microsoft_clarity_plugin_platform_interface.dart';

class MicrosoftClarityPlugin {
  MicrosoftClarityPlugin._();

  static Future<bool> initializeMicrosoftClarity() {
    return MicrosoftClarityPluginPlatform.instance.initializeMicrosoftClarity();
  }

  static Future<bool> setCustomUserId(String customUserId,) {
    return MicrosoftClarityPluginPlatform.instance.setCustomUserId(customUserId,);
  }

  static Future<String?> getCurrentSessionId() {
    return MicrosoftClarityPluginPlatform.instance.getCurrentSessionId();
  }
}
