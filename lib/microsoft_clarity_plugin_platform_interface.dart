import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'microsoft_clarity_plugin_method_channel.dart';

abstract class MicrosoftClarityPluginPlatform extends PlatformInterface {
  /// Constructs a MicrosoftClarityPluginPlatform.
  MicrosoftClarityPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MicrosoftClarityPluginPlatform _instance = MethodChannelMicrosoftClarityPlugin();

  /// The default instance of [MicrosoftClarityPluginPlatform] to use.
  /// Defaults to [MethodChannelMicrosoftClarityPlugin].
  static MicrosoftClarityPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MicrosoftClarityPluginPlatform] when
  /// they register themselves.
  static set instance(MicrosoftClarityPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> initializeMicrosoftClarity();

  Future<bool> setCustomUserId(String customUserId,);

  Future<String?> getCurrentSessionId();
}
