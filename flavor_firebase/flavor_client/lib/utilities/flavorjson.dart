import 'dart:convert';

import 'package:flavor/utilities/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class FlavorJson {
  BuildContext? _context;
  BuildContext? get context => _context;
  FlavorJson(this._context);

  // Flavor.json
  late Map<String, dynamic> appJson;

  // App Info
  String? title;
  String? author;
  String? website;

  // API structor related
  bool? requireLogin;
  // API related
  String? apiBaseUrl;
  // Theme related
  ThemeData? theme;
  String? themeMode;
  String? fontFamily;
  Color? primarySwatch;
  Color? primaryColor;
  // Pages

  Map<String, dynamic> pagesMap = {};

  String currentPage = '/';

  initAppJson() async {
    /// Flavor.json - READ
    String data =
        await DefaultAssetBundle.of(context!).loadString("assets/flavor.json");
    appJson = json.decode(data);

    /// Flavor.json - META
    appJson.containsKey('title') ? title = appJson['title'] : title = '';
    appJson.containsKey('author') ? author = appJson['author'] : author = '';
    // appJson!.containsKey('website')
    //     ?
    website = appJson['website'];
    // : website = '';
    // appJson!.containsKey('requireLogin')
    //     ?
    requireLogin = appJson['requireLogin'];
    // : requireLogin = false;

    /// Flavor.json - API/REST "baseUrl": "api.dlxstudios.com"
    // appJson.containsKey('api')
    //     ?
    apiBaseUrl = appJson['api']['baseUrl'];
    // : apiBaseUrl = null;

    /// Flavor.json - THEME
    theme = ThemeData(
      brightness: appJson.containsKey('theme')
          ? getThemeMode(appJson['theme']['themeMode'])
          : getThemeMode('light'),
      primaryColor: appJson.containsKey('theme')
          ? getColorConst(appJson['theme']['primaryColor'])
          : null,
      accentColor: appJson.containsKey('theme')
          ? getColorConst(appJson['theme']['accentColor'])
          : null,
      // primarySwatch: getColorConst(appJson['theme']['primarySwatch']),
      fontFamily: appJson['theme']['fontFamily'],
    );

    /// Flavor.json - PAGES

    var _pages = appJson.containsKey('pages') ? appJson['pages'] : [];

    for (var _page in _pages) {
      var path = _page['path'];
      pagesMap.putIfAbsent(path, () => _page);
    }

    // pagesMap.putIfAbsent('/', () => {"path": '/', "widget": DefaultHomePage()});

    // log.i(pagesMap.containsKey('/') ? pagesMap.toString() : 'false');

    // if (!pagesMap.containsKey('/')) {
    //   pagesMap.putIfAbsent(path, () => _page);

    // }

    // isLoading = false;
    // notifyListeners();
  }
}
