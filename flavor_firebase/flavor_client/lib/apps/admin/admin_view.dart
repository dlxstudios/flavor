import 'package:flavor/apps/admin/state.dart';
import 'package:flavor/components/refactor_components.dart';
import 'package:flavor/components/route.dart';
import 'package:flavor/theme/clay/clay.dart';
import 'package:flavor/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlavorAdminAppView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final adminState = watch(flavorAdminStateProvider);

    Route onGenerateRoute(RouteSettings settings) {
      var path;
      FlavorRouteWidget route;
      path = settings.name;
      route = (adminState.routesMap.containsKey(path)
          ? adminState.routesMap[path]
          : null)!;

      // if (route.onRequired != null) {
      //   var requires =
      //       route.onRequired(settings: settings, appState: adminState);
      //   if (requires != null) return requires;
      // }

      return MaterialPageRoute(
        settings: settings,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(settings.toString()),
          ),
          body: route,
        ),
      );
    }

    return MaterialApp(
      navigatorKey: GlobalKey<NavigatorState>(),
      onUnknownRoute: routeErrorView,
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: _computeTheme(
        textTheme: adminState.textTheme,
        color: adminState.primaryColor,
        dark: adminState.useDark,
        useColor: adminState.useColor,
      ).copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // routes: {
      //   '/': (context) => adminState.routes != null
      //       ? Container(
      //           child: FlavorAppView(
      //             navigatorKey: adminState.navigatorKey,
      //             routes: adminState.routes,
      //           ),
      //         )
      //       : Scaffold(
      //           body: Container(
      //             child: Center(
      //               child: Text('App no work bro cuz!'),
      //             ),
      //           ),
      //         ),
      // },
    );
  }

  Route routeErrorView(settings) {
    return MaterialPageRoute(
      maintainState: true,
      builder: (BuildContext context) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                leading: ClayButton(
                  depth: 6,
                  child: Icon(Icons.close),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(
                height: 300,
              ),
              ClayText(
                'Error : 404',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(letterSpacing: 10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: FlavorText.headline3(context, 'Unable to find route  '),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: FlavorText.headline6(context, ' "$settings" '),
              )
            ],
          ),
        );
      },
    );
  }
}

ThemeData _computeTheme({
  Color? color,
  bool dark = false,
  bool useColor = false,
  TextTheme textTheme = const TextTheme(),
}) {
  var _color = color != null ? color : Colors.deepPurple;

  // return _theme;

  if (dark) {
    if (useColor) {
      return ThemeData.dark().copyWith(
        canvasColor: darken(_color, .03),
        scaffoldBackgroundColor: darken(_color, .03),
        primaryColor: Colors.white,
        accentColor: _color,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: darken(_color, 0),
          foregroundColor: Colors.white,
          elevation: 8,
          hoverElevation: 20,
        ),
        splashColor: darken(_color, .3),
        textTheme: textTheme.merge(ThemeData.dark().textTheme),
      );
    }
    return ThemeData.dark().copyWith(
      canvasColor: darken(ThemeData.dark().canvasColor, .01),
      primaryColor: darken(_color),
      accentColor: _color,
      splashColor: _color,
      buttonTheme: ButtonThemeData(
        buttonColor: ThemeData.dark().backgroundColor,
        textTheme: ButtonTextTheme.normal,
        splashColor: _color,
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: _color),
      textTheme: textTheme.merge(ThemeData.dark().textTheme),
    );
  }

  if (useColor) {
    return ThemeData.light().copyWith(
      canvasColor: lighten(_color, .3),
      scaffoldBackgroundColor: lighten(_color, .3),
      primaryColor: Colors.black,
      accentColor: _color,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lighten(_color, .3),
        // foregroundColor: Colors.white,
        elevation: 8,
        hoverElevation: 16,
      ),
      splashColor: _color,
      textTheme: textTheme.merge(ThemeData.light().textTheme),
    );
  }

  return ThemeData.light().copyWith(
    canvasColor: darken(ThemeData.light().canvasColor, .01),
    primaryColor: darken(_color, .5),
    accentColor: _color,
    splashColor: _color,
    buttonTheme: ButtonThemeData(
      buttonColor: ThemeData.light().backgroundColor,
      textTheme: ButtonTextTheme.normal,
      splashColor: _color,
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: _color),
    textTheme: textTheme.merge(ThemeData.light().textTheme),
  );
}
