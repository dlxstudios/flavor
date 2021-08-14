import 'dart:async';

import 'package:flavor_client/client/firebase_bootstrap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:url_strategy/url_strategy.dart';

Future runClient(Widget entry, [Future? beforeAppStart]) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    setPathUrlStrategy();
  }

  Hive.init('.');
  await Hive.openBox('flavor_client');

  // if (fIsMobile) {
  // } // await FlavorStore.initFuture('flavor-studio-v0');
  if (beforeAppStart != null) {
    await beforeAppStart;
  }
  runZonedGuarded<Future<void>>(() async {
    runApp(
      ProviderScope(child: FirebaseBootstrap(child: entry)),
    );
  }, (Object error, StackTrace stackTrace) {
    return;
  });
}
