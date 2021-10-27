import 'package:flutter/widgets.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

//...
Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return rootBundle
      .loadString('assets/$assetsPath')
      .then((jsonStr) => jsonDecode(jsonStr));
}

class FlavorStoreNotifier extends ChangeNotifier {
  late FlavorStoreModel store;

  static init() {
    return FlavorStoreNotifier();
  }
}

class FlavorStoreModel {}

class FlavorStore {}
