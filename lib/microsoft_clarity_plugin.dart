import 'microsoft_clarity_plugin_platform_interface.dart';

class MicrosoftClarityPlugin {
  MicrosoftClarityPlugin._();
  static Future<bool> initializeMicrosoftClarity() {
    return MicrosoftClarityPluginPlatform.instance.initializeMicrosoftClarity();
  }
}
