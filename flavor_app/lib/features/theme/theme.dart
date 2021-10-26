import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flavor_app/features/storage/storage.dart';
import 'package:flavor_app/features/text/text_theme.dart';
import 'package:flavor_app/features/theme/theme_data.dart';
import 'package:flavor_app/features/theme/theme_defaults.dart';
import 'package:flavor_app/features/theme/theme_service.dart';

///////////////////////////////
///
///

class Theme extends ChangeNotifier {
  Theme({
    Key? key,
    FlavorStore? store,
    this.lightTheme,
    this.darkTheme,
  }) {
    if (store == null) {
      _themeService = ThemeService();
      lightTheme ??= defaultLightTheme;
      darkTheme ??= defaultDarkTheme;
      _themeService.themeMode.then((value) => _themeMode = value);
    }

    if (store != null) {
      _themeService = ThemeService(store);
      lightTheme = defaultLightTheme;
      darkTheme = defaultDarkTheme;
    }
  }

  static ThemeController of(BuildContext context) {
    // assert(context != null);
    final ThemeController? result =
        context.dependOnInheritedWidgetOfExactType<ThemeController>();
    assert(result != null, 'No Theme found in context');
    return result!;
  }

  //////////////////////////////////////////////////////
  ///
  ///

  fromStore(FlavorStore? store) async {
    _themeService = await ThemeService(store);
    // lightTheme = await _themeService.themeMode == FlavorThemeMode.light ? defaultLightTheme : defaultDarkTheme;
    // _themeMode = await _themeService.themeMode;
  }

  FlavorThemeMode? _themeMode = FlavorThemeMode.system;
  FlavorThemeMode? get themeMode => _themeMode;

  late ThemeService _themeService;

  void updateThemeMode(FlavorThemeMode? newThemeMode) async {
    // ignore: avoid_print
    // print('newThemeMode::$newThemeMode');
    if (newThemeMode == null) return;
    // if (newThemeMode == _selectedTheme) return;
    _themeMode = newThemeMode;
    // ignore: avoid_print
    // print('updateThemeMode::$_themeMode');
    notifyListeners();

    await _themeService.updateThemeMode(newThemeMode);
  }

  // Theme
  // late FlavorThemeData _selectedTheme;
  FlavorThemeData get theme =>
      themeMode == FlavorThemeMode.light ? lightTheme! : darkTheme!;
  late FlavorThemeData? lightTheme;
  late FlavorThemeData? darkTheme;
  // Text
  FlavorTextTheme? get textTheme => theme.textTheme;
}

class DefaultTheme extends StatelessWidget {
  final Widget child;
  DefaultTheme({Key? key, required this.child}) : super(key: key);

  final Theme themeController = Theme();

  @override
  Widget build(BuildContext context) {
    // themeController.addListener(() {
    //   print('themeController.hashCode::themeController.hashCode');
    // });
    // print('themeController.hashCode::${themeController.hashCode}');

    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        // print('rebuild::${themeController._themeMode}');
        return ThemeController(
          theme: themeController,
          child: child,
        );
      },
    );
  }
}

class ThemeController extends InheritedWidget {
  final Theme theme;
  // ignore: use_key_in_widget_constructors
  const ThemeController({
    Key? key,
    required Widget child,
    required this.theme,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant ThemeController oldWidget) {
    // print('updateShouldNotify');
    // return theme != oldWidget.theme;
    return true;
  }
}
