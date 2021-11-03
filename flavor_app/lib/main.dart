import 'dart:async';

import 'package:flavor_app/cup_app.dart';
import 'package:flavor_app/features/client/client_bootstrap.dart';
import 'package:flavor_app/store_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:url_strategy/url_strategy.dart';

import 'material_app.dart';

void startClient() async {
  return runZonedGuarded<Future<void>>(() async {
    runApp(const FlavorClientBootStrap());
  }, (Object error, StackTrace stackTrace) {
    throw (() {
      // ignore: avoid_print
      print('Flavor :: ERROR');
      // ignore: avoid_print
      print(' $error  \n $stackTrace');
    });
  });
}

void startMaterialClient() async {
  return runZonedGuarded<Future<void>>(() async {
    runApp(const FlavorMaterialApp());
  }, (Object error, StackTrace stackTrace) {
    throw (() {
      // ignore: avoid_print
      print('Flavor :: ERROR');
      // ignore: avoid_print
      print(' $error  \n $stackTrace');
    });
  });
}

void startCupClient() {
  runApp(const CupApp());
}

void main() {
  // List<String>
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    setPathUrlStrategy();
  }

  print('Starting App');
  // print('args::$args');

  // startCupClient();
  // startMaterialClient();
  // startClient();
  runApp(const StoreTestApp());
}
