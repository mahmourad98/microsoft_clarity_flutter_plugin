import 'package:flutter_test/flutter_test.dart';
import 'package:microsoft_clarity_plugin/microsoft_clarity_plugin.dart';
import 'package:microsoft_clarity_plugin/microsoft_clarity_plugin_platform_interface.dart';
import 'package:microsoft_clarity_plugin/microsoft_clarity_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMicrosoftClarityPluginPlatform
    with MockPlatformInterfaceMixin
    implements MicrosoftClarityPluginPlatform {
  @override
  Future<bool> initializeMicrosoftClarity() {
    return Future.value(true);
  }

}

void main() {
  final MicrosoftClarityPluginPlatform initialPlatform = MicrosoftClarityPluginPlatform.instance;

  test('$MethodChannelMicrosoftClarityPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMicrosoftClarityPlugin>());
  });

  test('getPlatformVersion', () async {
    MockMicrosoftClarityPluginPlatform fakePlatform = MockMicrosoftClarityPluginPlatform();
    MicrosoftClarityPluginPlatform.instance = fakePlatform;

    expect(await MicrosoftClarityPlugin.initializeMicrosoftClarity(), true);
  });
}
