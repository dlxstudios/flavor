import 'dart:async';

import 'package:flavor_app/features/home/home_screen.dart';
import 'package:flavor_app/features/colors/colors.dart';
import 'package:flavor_app/features/client/client_model.dart';
import 'package:flavor_app/features/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:regex_router/regex_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final RegexRouter router = RegexRouter.create({
      // "/": (context, _) => ScreenPageTabs.fromPageTabData({
      //       'tabs': [
      //         {
      //           "type": 'flavor.page.tab',
      //           'text': 'Home',
      //           'icon': 'home',
      //           'page': {
      //             'title': 'Tab Page 1',
      //             'components': [],
      //             'type': 'flavor.page',
      //           },
      //         }
      //       ],
      //     }),
      "/": (context, _) => const ScreenHome(),
      // SettingsView.routeName: (context, args) => SampleItemListView(),
      // SampleItemDetailsView.routeName: (context, args) => SampleItemDetailsView(),
    });

    return Focus(
      canRequestFocus: false,
      onKey: (FocusNode node, RawKeyEvent event) {
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
          color: FlavorColor(FlavorColors.red).value,
          // color: _themeStateController.theme.primaryColor!,
          onGenerateRoute: router.generateRoute,
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
