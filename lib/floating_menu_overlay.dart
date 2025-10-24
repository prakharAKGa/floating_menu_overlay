
import 'floating_menu_overlay_platform_interface.dart';

class FloatingMenuOverlay {
  Future<String?> getPlatformVersion() {
    return FloatingMenuOverlayPlatform.instance.getPlatformVersion();
  }
}
