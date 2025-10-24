import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floating_menu_overlay/floating_menu_overlay_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFloatingMenuOverlay platform = MethodChannelFloatingMenuOverlay();
  const MethodChannel channel = MethodChannel('floating_menu_overlay');

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

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
