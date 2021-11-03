import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  DartVLC.initialize();
  runApp(const MyApp());
}
