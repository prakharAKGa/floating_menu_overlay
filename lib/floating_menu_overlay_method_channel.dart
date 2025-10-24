import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'floating_menu_overlay_platform_interface.dart';

/// An implementation of [FloatingMenuOverlayPlatform] that uses method channels.
class MethodChannelFloatingMenuOverlay extends FloatingMenuOverlayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('floating_menu_overlay');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
