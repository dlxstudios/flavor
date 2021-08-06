import 'dart:async';

import 'package:flavor/client/firebase_bootstrap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:url_strategy/url_strategy.dart';

Future runClient(Widget entry, [Future? beforeAppStart]) async {
  if (kIsWeb) {
    setPathUrlStrategy();
  }

  Hive.init('.');
  await Hive.openBox('dlxapp');

  // if (fIsMobile) {
  WidgetsFlutterBinding.ensureInitialized();
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
