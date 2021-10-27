import 'dart:async';

import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:regex_router/regex_router.dart';

import 'package:flavor_app/features/client/client_model.dart';
import 'package:flavor_app/features/page/page.dart';
import 'package:flavor_app/features/page/page_error.dart';
import 'package:flavor_app/test_flavor_app_1.dart';

var testApp = testFlavorApp1;
var app = FlavorAppClientModel.fromMap(testApp);

class FlavorClientData {}

Future<FlavorAppClientModel> clientInit(BuildContext context) async {
  // String data =
  //     await DefaultAssetBundle.of(context).loadString("assets/flavor.json");
  // return jsonDecode(data); //

  // var data = testFlavorApp1;

  return FlavorAppClientModel();
}

class FlavorClient extends StatelessWidget {
  const FlavorClient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      canRequestFocus: false,
      onKey: (FocusNode node, RawKeyEvent event) {
        // print(event);
        if (event is! RawKeyDownEvent ||
            event.logicalKey != LogicalKeyboardKey.escape) {
          return KeyEventResult.ignored;
        }
        return KeyEventResult.handled;
        // return Tooltip.dismissAllToolTips()
        //     ? KeyEventResult.handled
        //     : KeyEventResult.ignored;
      },
      child: DefaultTheme(
        child: WidgetsApp(
          title: 'App',
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          color: FlavorColor(colorValue: FlavorColors.red).value,
          // color: _themeStateController.theme.primaryColor!,
          onGenerateRoute: computeRouter(app.pages),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
        ),
      ),
    );
  }
}

Route<dynamic>? Function(RouteSettings)? computeRouter(
    List<FlavorPageModel>? pages) {
  if (pages == null && pages!.isEmpty) {
    return RegexRouter.create({
      '/': (context, ds) => FlavorPageError(
            message: 'no pages for app ',
            code: 404.toString(),
          )
    }).generateRoute;
  }

  Map<String, Widget Function(BuildContext, RouteArgs)> routeMap = {};

  // print('object::$pages');

  pages.map((e) {
    // print('path::${e.path}');
    routeMap.addAll({e.path!: (context, ds) => FlavorPage(e)});
  }).toList();

  return RegexRouter.create(routeMap).generateRoute;
}
