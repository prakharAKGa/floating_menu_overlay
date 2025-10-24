import 'package:flutter_test/flutter_test.dart';
import 'package:floating_menu_overlay/floating_menu_overlay.dart';
import 'package:floating_menu_overlay/floating_menu_overlay_platform_interface.dart';
import 'package:floating_menu_overlay/floating_menu_overlay_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFloatingMenuOverlayPlatform
    with MockPlatformInterfaceMixin
    implements FloatingMenuOverlayPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FloatingMenuOverlayPlatform initialPlatform = FloatingMenuOverlayPlatform.instance;

  test('$MethodChannelFloatingMenuOverlay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFloatingMenuOverlay>());
  });

  test('getPlatformVersion', () async {
    FloatingMenuOverlay floatingMenuOverlayPlugin = FloatingMenuOverlay();
    MockFloatingMenuOverlayPlatform fakePlatform = MockFloatingMenuOverlayPlatform();
    FloatingMenuOverlayPlatform.instance = fakePlatform;

    expect(await floatingMenuOverlayPlugin.getPlatformVersion(), '42');
  });
}
