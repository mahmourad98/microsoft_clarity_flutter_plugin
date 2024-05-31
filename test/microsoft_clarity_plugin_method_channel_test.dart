import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microsoft_clarity_plugin/microsoft_clarity_plugin.dart';
import 'package:microsoft_clarity_plugin/microsoft_clarity_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMicrosoftClarityPlugin platform = MethodChannelMicrosoftClarityPlugin();
  const MethodChannel channel = MethodChannel('microsoft_clarity_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('initializeMicrosoftClarity', () async {
    expect(await MicrosoftClarityPlugin.initializeMicrosoftClarity(), true);
  });
}
