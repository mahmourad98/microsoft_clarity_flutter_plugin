import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:microsoft_clarity_plugin/microsoft_clarity_plugin.dart';
import 'package:microsoft_clarity_plugin/microsoft_clarity_plugin_platform_interface.dart';
import 'package:microsoft_clarity_plugin/microsoft_clarity_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMicrosoftClarityPluginPlatform with MockPlatformInterfaceMixin implements MicrosoftClarityPluginPlatform {
  @override Future<bool> initializeMicrosoftClarity() {
    return Future.value(true);
  }

  @override Future<String?> getCurrentSessionId() {
    return Future.value("1234567890");
  }

  @override Future<bool> setCustomUserId(String customUserId) {
    return Future.value(true);
  }

}

void main() {
  final MicrosoftClarityPluginPlatform initialPlatform = MicrosoftClarityPluginPlatform.instance;

  test('$MethodChannelMicrosoftClarityPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMicrosoftClarityPlugin>());
  });

  test('initializeMicrosoftClarity', () async {
    MockMicrosoftClarityPluginPlatform fakePlatform = MockMicrosoftClarityPluginPlatform();
    MicrosoftClarityPluginPlatform.instance = fakePlatform;

    expect(await MicrosoftClarityPlugin.initializeMicrosoftClarity(), true);
  });

  test('setCustomUserId', () async {
    MockMicrosoftClarityPluginPlatform fakePlatform = MockMicrosoftClarityPluginPlatform();
    MicrosoftClarityPluginPlatform.instance = fakePlatform;
    expect(await MicrosoftClarityPlugin.setCustomUserId(Random().nextInt(1000).toString()), true);
  });

  test('getCurrentSessionId', () async {
    MockMicrosoftClarityPluginPlatform fakePlatform = MockMicrosoftClarityPluginPlatform();
    MicrosoftClarityPluginPlatform.instance = fakePlatform;
    expect(await MicrosoftClarityPlugin.getCurrentSessionId(), "1234567890");
  });
}
