import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'floating_menu_overlay_method_channel.dart';

abstract class FloatingMenuOverlayPlatform extends PlatformInterface {
  /// Constructs a FloatingMenuOverlayPlatform.
  FloatingMenuOverlayPlatform() : super(token: _token);

  static final Object _token = Object();

  static FloatingMenuOverlayPlatform _instance = MethodChannelFloatingMenuOverlay();

  /// The default instance of [FloatingMenuOverlayPlatform] to use.
  ///
  /// Defaults to [MethodChannelFloatingMenuOverlay].
  static FloatingMenuOverlayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FloatingMenuOverlayPlatform] when
  /// they register themselves.
  static set instance(FloatingMenuOverlayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
