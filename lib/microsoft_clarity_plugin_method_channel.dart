import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'microsoft_clarity_plugin_platform_interface.dart';

/// An implementation of [MicrosoftClarityPluginPlatform] that uses method channels.
class MethodChannelMicrosoftClarityPlugin extends MicrosoftClarityPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting final methodChannel = const MethodChannel('microsoft_clarity_plugin');

  @override Future<bool> initializeMicrosoftClarity() async{
    bool? result;
    try {
      await methodChannel.invokeMethod('initializeMicrosoftClarity').then((_,) {
        result = true;
       log("MS Clarity initialized successfully.", name: "MicrosoftClarityPlugin",);
      });
    } on PlatformException catch (e) {
      result = false;
      log("Failed to initialize MS Clarity: '${e.message}'.", name: "MicrosoftClarityPlugin",);
    }
    return result ?? false;
  }

  @override Future<bool> setCustomUserId(String customUserId,) async{
    final args = <String, dynamic>{"customUserId": customUserId,};
    bool? result;
    try {
      await methodChannel.invokeMethod<bool>('setCustomUserId', args,).then((_,) {
        result = true;
        log("Custom User ID set successfully.", name: "MicrosoftClarityPlugin",);
      });
    } on PlatformException catch (e) {
      result = false;
      log("Failed to set Custom User ID: '${e.message}'.", name: "MicrosoftClarityPlugin",);
    }
    return result ?? false;
  }

  @override Future<String?> getCurrentSessionId() async{
    String? result;
    try {
      await methodChannel.invokeMethod<String?>('getCurrentSessionId',).then((String? value,) {
        result = value;
        log("Current session ID was fetched Successfully.", name: "MicrosoftClarityPlugin",);
      });
    } on PlatformException catch (e) {
      log("Failed to fetch Current session ID: '${e.message}'.", name: "MicrosoftClarityPlugin",);
    }
    return result;
  }
}
