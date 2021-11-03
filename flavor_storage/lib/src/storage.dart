import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

//...
Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return rootBundle
      .loadString('assets/$assetsPath')
      .then((jsonStr) => jsonDecode(jsonStr));
}

class FlavorStoreController {
  late FlavorStoreModel store;

  late GetStorage box;

  init() async {
    await GetStorage.init();
    box = GetStorage();
  }

  dynamic get(String key) {
    return box.read(key);
  }

  Future<void> save(String key, dynamic value) async {
    log(key);
    return await box.write(key, value);
  }
}

class FlavorStoreModel {}

class FlavorStore {}
