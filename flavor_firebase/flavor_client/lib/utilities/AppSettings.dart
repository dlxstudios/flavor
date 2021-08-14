import 'dart:async';
import 'dart:convert';

import 'package:flavor_client/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flavor_http/http.dart';

class AppSettingsModel with ChangeNotifier {
  // utils
  bool isLoading = true;
  bool init = false;
  final BuildContext context;
  Logger log = Logger();
  Box? _box;

  Object? nav;

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

  bool? device = true;

  initAppJson() async {
    /// Flavor.json - READ
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/flavor.json");
    appJson = json.decode(
      data,
    );

    /// Flavor.json - META
    appJson.containsKey('title') ? title = appJson['title'] : title = '';
    appJson.containsKey('author') ? author = appJson['author'] : author = '';
    appJson.containsKey('website')
        ? website = appJson['website']
        : website = '';
    appJson.containsKey('requireLogin')
        ? requireLogin = appJson['requireLogin']
        : requireLogin = false;

    /// Flavor.json - API/REST "baseUrl": "api.dlxstudios.com"
    appJson.containsKey('api')
        ? apiBaseUrl = appJson['api']['baseUrl']
        : apiBaseUrl = null;

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

  String apiLogin = "signInWithEmail";
  String apiSignUp = "signUpWithEmail";

  // User
  String? email;
  String? localId;
  String? token;
  bool? isLoggedIn;

  bool _darkTheme = false;

  bool get darkTheme {
    return _darkTheme;
  }

  void setDarkTheme(bool newVal) {
    _darkTheme = newVal;
    _box?.put('darkTheme', this._darkTheme);
    notifyListeners();
    // log.i(_darkTheme);
  }

  void pushTo(String path, {DataItem? data, required BuildContext context}) {
    Size size = MediaQuery.of(context).size;
    if (size.width > 950) {
      setCurrentPage(path);
    } else {
      Navigator.of(this.context).pushNamed(path, arguments: data);
    }
  }

  void pushToReplace(String path,
      {DataItem? data, required BuildContext context}) {
    Size size = MediaQuery.of(context).size;
    if (size.width > 950) {
      setCurrentPage(path);
    } else {
      Navigator.of(this.context).pushReplacementNamed(path, arguments: data);
    }
  }

  setCurrentPage(String path) {
    // currentPage = pagesMap.containsKey(path) ? path : '/error';
    print(pagesMap);
    currentPage = path;
    notifyListeners();
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<Map<String, dynamic>> login(String email, String password) async {
    // print('Login.Model.login - $email - $password');

    return await postJson(
            '$apiBaseUrl$apiLogin', {"email": email, "password": password})
        .then((userJson) {
      // Got json back
      // print(userJson);
      // see if there are any errors
      if (userJson.containsKey('error')) {
        return userJson['error'];
      }
      // save user info
      saveUserFromJson(userJson);
      // reutrn something
      return {"code": 200};
    });
  }

  void signup(String email, String password, String repassword) async {
    // print('Login.Model.signup - $email - $password - $repassword');
    await postJson('$apiBaseUrl$apiSignUp', {
      "email": email,
      "password": password,
      "repassword": repassword
    }).then((userJson) {
      // Got json back
      // print(userJson);
      // see if there are any errors
      if (userJson.containsKey('error')) {
        return userJson['error'];
      }
      // save user info
      saveUserFromJson(userJson);
      // reutrn something
      return {"code": 200};
    });
  }

  Future hiveInit({bool device = false}) async {
    // log.e('THE HIVE!');

    if (device) {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      // log.e('Directory : ${dir.path}');
    } else {
      Hive.init('');
    }

    return Hive.openBox('saucetv').then((snap) {
      // set the box for future use
      _box = snap;
      // check the length ( degug )
      // print('snap.length - ${snap.length}');
      // log.e('Box Open! : ${snap}');
      // Load all loginSettings
      loadUserFromHive();
      // log.e('user setting loaded!');

      // ApplyTheming
      loadDarkMode();
      // log.e('darkmode setting loaded!');
      // finished setting sata

      Timer(Duration(seconds: 0), () {
        isLoading = false;
        // notifyListeners();
      });
    });
  }

  void loadDarkMode() {
    this._darkTheme =
        _box?.get('darkTheme') != null ? _box?.get('darkTheme') : false;
  }

  void saveUserFromJson(Map<String, dynamic> userJson) {
    // print(userJson['idToken']);
    // print(userJson['email']);
    // print(userJson['localId']);
    this.token = userJson['idToken'];
    _box?.put('token', this.token);
    this.email = userJson['email'];
    _box?.put('email', this.email);
    this.localId = userJson['localId'];
    _box?.put('localId', this.localId);
    this.token != null ? this.isLoggedIn = true : this.isLoggedIn = false;
    notifyListeners();
  }

  void loadUserFromHive() {
    this.token = token = _box?.get('token');
    this.email = _box?.get('email');
    this.localId = _box?.get('localId');
    // print('Not logged in...');
    this.token != null ? this.isLoggedIn = true : this.isLoggedIn = false;
    // notifyListeners();
  }

  Future<bool> signout() async {
    _box?.deleteAll([
      'token',
      'email',
      'localId',
    ]);
    this.token = null;
    this.email = null;
    this.localId = null;

    // print(this.token);
    // print(_box.get('token'));

    Timer(Duration(seconds: 0), () {
      isLoading = false;
      notifyListeners();
    });

    return true;
  }

  final Map<String, WidgetBuilder>? routes;

  AppSettingsModel(this.context, {this.device, this.routes}) {
    print(this.routes);

    initAppJson();
    hiveInit(device: device ?? false);
    init = true;
    // notifyListeners();
    Timer(Duration(seconds: 2), notifyListeners);
  }
}
