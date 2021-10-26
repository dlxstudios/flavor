import 'dart:ui';

import 'package:flavor_app/features/storage/storage.dart';
import 'package:flavor_app/features/theme/theme_data.dart';
import 'package:flavor_app/features/theme/theme_defaults.dart';
import 'package:flutter/scheduler.dart';

class ThemeService {
  final FlavorStore? store;
  ThemeService([this.store]);

  Brightness get systemMode =>
      SchedulerBinding.instance!.window.platformBrightness;

  Future<FlavorThemeMode?> get themeMode async {
    if (store == null) {
      return Future.value(null);
    }
    return Future.value(FlavorThemeMode.system);
  }

  Future<bool> updateThemeMode(FlavorThemeMode themeMode) async {
    return Future.value(true);
  }
}
