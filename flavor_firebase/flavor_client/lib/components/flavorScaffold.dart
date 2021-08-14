import 'package:flavor_client/layout/FlavorResponsiveView.dart';
import 'package:flavor_client/components/page.dart';
import 'package:flavor_client/layout/adaptive.dart';
import 'package:flutter/material.dart';

class FlavorScaffold extends StatelessWidget {
  final Widget? endDrawer;

  final Widget? body;

  final Widget? drawer;

  final PreferredSizeWidget? appBar;

  final Color? statusbarColor;
  final Color? backgroundColor;

  final Map<String, Widget>? routes;

  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  final double? drawerWidth;
  final double? endDrawerWidth;

  final DisplayType? endDrawerBreakpoint;
  final DisplayType? drawerBreakpoint;

  final double? bodyWidth;

  /// FlavorAppScaffoldAdaptive
  const FlavorScaffold({
    Key? key,
    this.endDrawer,
    this.body,
    this.drawer,
    this.statusbarColor,
    this.appBar,
    this.routes,
    this.navigatorKey,
    this.scaffoldKey,
    this.drawerWidth = 300,
    this.endDrawerWidth = 300,
    this.bodyWidth,
    this.drawerBreakpoint = DisplayType.m,
    this.endDrawerBreakpoint = DisplayType.m,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log.wtf(displayType (context)== DisplayType.m);
    Widget _body = body ??
        FlavorNavigatorOutlet(navigatorKey: navigatorKey!, routes: routes!);

    // log.wtf(drawerBreakpoint);

    // double width = MediaQuery.of(context).size.width;
    bool showDrawer = fMediaQueryFromDisplayType(
        fDisplayMediaQuery(context), drawerBreakpoint!);
    bool showEndDrawer = fMediaQueryFromDisplayType(
        fDisplayMediaQuery(context), endDrawerBreakpoint!);
    print('showDrawer  |  $showDrawer');

    Widget _drawer = drawer != null
        ? Container(
            width: drawerWidth,
            child: drawer,
          )
        : Container();
    // log.i(drawer);

    Widget _endDrawer = endDrawer != null
        ? Container(
            width: endDrawerWidth,
            child: endDrawer,
          )
        : Container();
    // log.i(showDrawer);
    // log.i(showEndDrawer);

    return PageShell(
      statusbarColor: statusbarColor,
      safeArea: true,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor,
        appBar: appBar,
        drawer: showDrawer ? drawer : null,
        endDrawer: showEndDrawer ? endDrawer : null,
        body: FlavorResponsiveView(
          global: false,
          breakpoints: {
            DisplayType.s: _body,
            DisplayType.m: _body,
            DisplayType.l: Row(children: [
              !showDrawer ? _drawer : Container(),
              Flexible(flex: 1, child: _body),
              !showEndDrawer ? _endDrawer : Container(),
            ]),
            DisplayType.xl: Row(children: [
              !showDrawer ? _drawer : Container(),
              Flexible(flex: 1, child: _body),
              !showEndDrawer ? _endDrawer : Container(),
            ]),
          },
        ),
      ),
    );
  }

  Widget buildBody(context) => WillPopScope(
        child: Scaffold(
          drawer: fDisplayMediaQuery(context) == DisplayType.m
              ? null
              : Container(width: drawerWidth, child: drawer),
          endDrawer: fDisplayMediaQuery(context) == DisplayType.m
              ? null
              : Container(width: endDrawerWidth, child: endDrawer),
          body: Container(
            width: bodyWidth,
            child: FlavorNavigatorOutlet(
              navigatorKey: navigatorKey!,
              routes: routes!,
            ),
          ),
        ),
        onWillPop: () {
          // log.wtf(state.navigatorKey.currentState.canPop());
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
            return Future<bool>.value(true);
          }
          return Future<bool>.value(false);
        },
      );
}

extension FlavorNavigatorStateExtention on NavigatorState {
  FlavorNavigator get flavor => FlavorNavigator(this);
}

class FlavorNavigator {
  final NavigatorState navigatorState;
  FlavorNavigator(this.navigatorState);

  pushNamed(String routeName, {dynamic arguments}) {
    navigatorState.pushNamed(routeName, arguments: arguments);
  }

  pushNamedAndRemoveUntil(String routeName, {dynamic arguments}) {
    navigatorState.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}

class FlavorNavigatorOutlet extends StatelessWidget {
  const FlavorNavigatorOutlet({
    Key? key,
    required this.navigatorKey,
    required this.routes,
    this.onGenerateRoute,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final Map<String, Widget> routes;

  final Route<dynamic> Function(RouteSettings)? onGenerateRoute;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // log.wtf(state.navigatorKey.currentState.canPop());

        if (navigatorKey.currentState!.canPop()) {
          // navigatorKey.currentState.pop();
          return Future<bool>.value(true);
        } else if (Navigator.of(context).canPop()) {
          // Navigator.of(context).pop();
          return Future<bool>.value(true);
        }
        return Future<bool>.value(false);
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute == null
            ? (RouteSettings? routeSettings) {
                // log.wtf(routes[routeSettings.name]);

                // if (onGenerateRoute != null) {
                //   // print(onGenerateRoute);
                //   onGenerateRoute(routeSettings);}

                if (routes[routeSettings?.name] != null) {
                  return MaterialPageRoute(
                    builder: (context) => routes[routeSettings!.name] as Widget,
                    settings: routeSettings,
                    maintainState: true,
                  );
                } else {
                  return MaterialPageRoute(
                    builder: (context) => PageError(
                      errorCode: 404.toString(),
                      msg:
                          'Route Not Found - ${routeSettings!.name} ${routeSettings.arguments != null ? "\n Arguments : ${routeSettings.arguments}" : ""}',
                    ),
                    settings: routeSettings,
                  );
                }
              }
            : onGenerateRoute,
      ),
    );
  }
}
