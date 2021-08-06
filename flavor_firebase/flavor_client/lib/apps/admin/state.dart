import 'package:flavor/apps/admin/repository.dart';
import 'package:flavor/apps/admin/routes.dart';
import 'package:flavor/components/route.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// class FlavorAdminStateConsumer extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     // final adminState = watch(myNotifierProvider);
//     return FlavorAdminAppView();
//   }
// }

// ignore: top_level_function_literal_block
final flavorAdminStateProvider = ChangeNotifierProvider((_) {
  return FlavorAdminState();
});

// final fasp = Provider((_) => FlavorAdminState());

class FlavorAdminState extends ChangeNotifier {
  List<FlavorRouteWidget> get routes => adminRoutes;

  Map<String, FlavorRouteWidget> get routesMap {
    Map<String, FlavorRouteWidget> map = {};
    for (var route in routes) {
      map.putIfAbsent(route.path, () => route);
    }
    return map;
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  var primaryColor = Colors.deepPurple;
// var accentColor = Colors.deepOrange;
  var textColor = Colors.deepOrange;

// var iconColor = ThemeData.light().scaffoldBackgroundColor.;

  final TextTheme textTheme = GoogleFonts.bangersTextTheme();

  FlavorSearchService? service;
  FlavorAdminState() {
    service = FlavorSearchService(FlavorUser(email: 'skii'));
  }

  List? items;

  bool _useDark = false;
  bool get useDark => _useDark;
  set useDark(value) {
    print('toggle dark mode');
    print('$value');
    _useDark = value;
    notifyListeners();
  }

  bool _useColor = false;
  bool get useColor => _useColor;
  set useColor(value) {
    _useColor = value;
    notifyListeners();
  }
}
