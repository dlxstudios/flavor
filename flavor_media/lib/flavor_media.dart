export 'package:flavor_media/flavor_media.dart';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/widgets.dart';

import 'src/flavor_video/flavor_video.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

Widget startFlavorMedia(Widget child) {
  DartVLC.initialize();
  final SettingsController settingsController =
      SettingsController(SettingsService());
  return FlavorVideoAdapter(
    controller: settingsController,
    child: AnimatedBuilder(
      animation: settingsController,
      child: child,
      builder: (BuildContext context, Widget? _child) {
        return _child!;
      },
    ),
  );
}
