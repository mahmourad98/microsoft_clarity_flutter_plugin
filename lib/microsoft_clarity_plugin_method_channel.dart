// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'microsoft_clarity_plugin_platform_interface.dart';

/// An implementation of [MicrosoftClarityPluginPlatform] that uses method channels.
class MethodChannelMicrosoftClarityPlugin extends MicrosoftClarityPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting final methodChannel = const MethodChannel('microsoft_clarity_plugin');

  @override Future<bool> initializeMicrosoftClarity() async {
    bool? result;
    try {
      await methodChannel.invokeMethod('initializeMicrosoftClarity').then((_,) {
        result = true;
        print("Clarity initialized successfully.");
      });
    } on PlatformException catch (e) {
      result = false;
      print("Failed to initialize Clarity: '${e.message}'.");
    }
    return result ?? false;
  }
}
