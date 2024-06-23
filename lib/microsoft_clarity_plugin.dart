import 'dart:io';
import 'microsoft_clarity_plugin_platform_interface.dart';

class MicrosoftClarityPlugin {
  MicrosoftClarityPlugin._();

  static Future<bool> initializeMicrosoftClarity() {
    if (!Platform.isAndroid) return Future.value(false,);
    return MicrosoftClarityPluginPlatform.instance.initializeMicrosoftClarity();
  }

  static Future<bool> setCustomUserId(String customUserId,) {
    if (!Platform.isAndroid) return Future.value(false,);
    return MicrosoftClarityPluginPlatform.instance.setCustomUserId(customUserId,);
  }

  static Future<String?> getCurrentSessionId() {
    if (!Platform.isAndroid) return Future.value(null,);
    return MicrosoftClarityPluginPlatform.instance.getCurrentSessionId();
  }
}
