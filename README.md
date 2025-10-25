# floating_menu_overlay

[![Pub](https://img.shields.io/pub/v/floating_menu_overlay)](https://pub.dev/packages/floating_menu_overlay)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A highly customizable floating menu overlay for Android in Flutter apps. It provides a draggable center icon (defaults to your app's launcher icon) that expands into 0-6 customizable menu buttons on tap. Supports gradients, shapes (circular/rectangular), sizes, borders, and on-click callbacks to Flutter. Inspired by bubble notifications like in Rapido, but fully customizable.

**Note:** Android-only (uses `SYSTEM_ALERT_WINDOW` for overlays). iOS support would require platform channels for native overlays.

## Features
- **Draggable & Clickable**: Drag the center icon anywhere; tap to toggle menu.
- **Customizable Menu**: 0-6 icons with labels and Flutter callbacks.
- **Icons**: Center uses app launcher (`ic_launcher`); menu icons via drawable names or Flutter `IconData` strings (map to vectors).
- **Styling**: Solid colors, gradients, circular/rect shapes, adjustable sizes, borders, corner radius.
- **Animations**: Smooth scale/fade on open/close.
- **Permissions**: Auto-requests overlay permission; add to manifest.

## Installation
Add this to your app's `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  floating_menu_overlay: ^1.0.0  # Use latest version from pub.dev
```

Then run:

```bash
flutter pub get
```

### Android Manifest Requirements
Add these permissions and service declaration to your app's `android/app/src/main/AndroidManifest.xml` (inside `<manifest>` and `<application>` tags, respectively). The plugin handles runtime permission requests, but these are required for overlays.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Required for overlay windows -->
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
    <!-- Optional: For foreground service (if you want persistent notification) -->
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />

    <application
        android:label="your_app_name"
        android:icon="@mipmap/ic_launcher">
        
        <!-- Plugin service (auto-starts on initialize/start) -->
        <service
            android:name="com.example.floating_menu_overlay.FloatingMenuOverlayService"
            android:enabled="true"
            android:exported="false" />

        <!-- Your existing activities -->
    </application>
</manifest>
```

**Pro Tip:** For custom icons, add your drawable XML/PNGs to `android/app/src/main/res/drawable/` (overrides plugin defaults).

## Usage

### Step 1: Set Up Callbacks
In your app's `main.dart` or a widget's `initState`, set up the MethodChannel handler for menu click callbacks.

```dart
import 'package:flutter/material.dart';
import 'package:floating_menu_overlay/floating_menu_overlay.dart';

void main() {
  // Handle menu clicks (e.g., map IDs to actions)
  FloatingMenuOverlay._setupCallbacks();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Menu Demo',
      home: MyHomePage(),
    );
  }
}
```

In `_setupCallbacks()` (already in the plugin's Dart file, but customize the handler):

```dart
// Example handler inside _setupCallbacks
void _handleMenuClick(String id) {
  print('Menu clicked: $id');
  switch (id) {
    case 'pause':
      // Your logic, e.g., pause timer
      break;
    case 'play':
      // Resume action
      break;
    default:
      // Handle others
  }
}
```

### Step 2: Initialize and Start the Overlay
Create a config and start from a button or on app load. Example in a widget:

```dart
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Floating Menu Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: _startFloatingMenu,
          child: const Text('Start Floating Menu'),
        ),
      ),
    );
  }

  Future<void> _startFloatingMenu() async {
    // Define 3 menu items (up to 6)
    final menuItems = [
      FloatingMenuItem(
        icon: 'ic_pause_circle',  // Drawable name (add to your res/drawable)
        label: 'Pause',
        onClickId: 'pause',  // Maps to your handler
      ),
      FloatingMenuItem(
        icon: Icons.play_arrow.toString(),  // Flutter IconData (requires mapping to drawable in native)
        label: 'Play',
        onClickId: 'play',
      ),
      FloatingMenuItem(
        icon: 'ic_stop_circle',
        label: 'Stop',
        onClickId: 'stop',
      ),
    ];

    final config = FloatingMenuOverlayConfig(
      centerIcon: 'ic_launcher',  // Your app's launcher icon (default)
      menuItems: menuItems,
      backgroundColor: Colors.blue[100],  // Solid color for buttons
      gradientStart: Colors.red,  // Optional: Gradient start
      gradientEnd: Colors.orange,  // Optional: Gradient end (overrides solid)
      isCircular: true,  // Circular shape (false for rect)
      centerSize: 80.0,  // Center button size in dp
      borderColor: Colors.black,
      borderWidth: 3.0,  // Border thickness in dp
      cornerRadius: 10.0,  // For non-circular
      initialX: 20.0,  // Initial position x in dp
      initialY: 100.0,  // Initial y in dp
    );

    await FloatingMenuOverlay.initialize(config);
    await FloatingMenuOverlay.start();
  }
}
```

### Step 3: Stop the Overlay
Call this when done (e.g., on app close or button press):

```dart
await FloatingMenuOverlay.stop();
```

## Customization Examples
- **No Menu (Just Draggable Center)**: Set `menuItems: []`.
- **Rectangular with Borders**: `isCircular: false, cornerRadius: 8.0, borderWidth: 2.0`.
- **Full Gradient Menu**: Omit `backgroundColor`; use `gradientStart` and `gradientEnd`.
- **Flutter Icons**: Pass `Icons.settings.toString()` as `icon`. In your app, add a vector drawable (e.g., via Android Studio > Vector Asset) named `ic_settings` in `res/drawable/`.
- **More Icons**: Add up to 6 `FloatingMenuItem`s. Plugin spreads them in a fan (angles auto-adjust).

## Testing
Run the included example app:

```bash
cd example
flutter run
```

- Grant "Draw over other apps" permission in Settings > Apps > Special app access.
- Drag/tap the floating icon; check console for click logs.
