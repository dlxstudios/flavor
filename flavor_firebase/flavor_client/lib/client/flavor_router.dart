import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flavor_client/client/flavor_state.dart';
import 'package:flavor_client/components/page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SharedAxisTransitionPageWrapper extends Page {
  const SharedAxisTransitionPageWrapper(
      {required this.screen, required this.transitionKey})
      : super(key: transitionKey);

  final Widget screen;
  final ValueKey transitionKey;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
        settings: this,
        fullscreenDialog: true,
        transitionDuration: Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            fillColor: Theme.of(context).cardColor,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        });
  }
}

class FlavorInfoParser extends RouteInformationParser<Uri> {
  @override
  Future<Uri> parseRouteInformation(RouteInformation routeInformation) async {
    // print(
    //     'FlavorInfoParser::parseRouteInformation - routeInformation : $routeInformation');

    return Uri.parse(routeInformation.location.toString());
  }

  @override
  RouteInformation restoreRouteInformation(Uri configuration) {
    // print(
    //     'FlavorInfoParser::restoreRouteInformation - configuration : $configuration');
    return RouteInformation(
        location: Uri.decodeComponent(configuration.toString()));
  }
}

class FlavorRouterDelegate extends RouterDelegate<Uri>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Uri> {
  static FlavorRouterDelegate of(BuildContext context) {
    return (Router.of(context).routerDelegate as FlavorRouterDelegate);
  }

  GlobalKey<NavigatorState> get navigatorKey => app.navigatorKey;
  FlavorClientState app;

  FlavorRouterDelegate(this.app) {
    // this.app.addListener(notifyListeners);
  }

  @override
  void dispose() {
    // app.removeListener(notifyListeners);
    super.dispose();
  }

  // void pushPage(String page) {
  //   app.currentPages.add(page);
  //   notifyListeners();
  // }

  // @override
  // void addListener(VoidCallback listener) {}

  final List<Uri> _pages = [Uri(path: '/')];

  /// Getter for a list that cannot be changed
  List<Page> get pages => List.unmodifiable(_pages).map((e) {
        Widget? _page;

        if (app.routesMap.containsKey(e.path)) {
          _page = app.routesMap[e.path]!.child;
        } else {
          _page = PageError(
            errorCode: 404.toString(),
            msg: 'Page "${e.path}" doesnt exist',
          );
        }
        // print('app.routesMap.length.toString()::${app.routesMap}');
        // print('app._page.title::${_page!.title}');
        // print('_pages.length::${_pages.length}');
        // if (_page == null)
        //   return SharedAxisTransitionPageWrapper(
        //       screen: PageError(
        //         errorCode: 404.toString(),
        //         msg: 'Page "${e.path}" doesnt exist',
        //       ),
        //       transitionKey: ValueKey<String>(_page.hashCode.toString()));
        Widget _screen = _page;
        // print('_pages.length::${_pages.length}');
        if (_pages.length > 1) {
          _screen = Scaffold(
            body: _page,
            appBar: AppBar(),
          );
        }
        return SharedAxisTransitionPageWrapper(
            screen: _screen,
            transitionKey: ValueKey<String>(_page.hashCode.toString()));
      }).toList();

  /// Number of pages function
  int numPages() => _pages.length;

  @override
  Uri get currentConfiguration => _pages.last;

  @override
  Widget build(BuildContext context) {
    // print('build::currentConfiguration.path - ${currentConfiguration.path}');
    // print('build::pages.length - ${numPages()}');

    // if (app.routes) {}

    // if (app.routesMap.containsKey(currentConfiguration.path)) {
    //   print(
    //       'app.routesMap[currentConfiguration.path]!.requiresLogin::${app.routesMap[currentConfiguration.path]!.requiresLogin}');
    //   if (app.routesMap[currentConfiguration.path]!.requiresLogin) {
    //     if (app.user == null) {
    //       //  return app.routesMap['/login'];
    //       // _pages.add(Uri(path: '/login'));
    //       return Navigator(
    //         key: navigatorKey,
    //         pages: [
    //           SharedAxisTransitionPageWrapper(
    //             screen: app.routesMap['/login'] as Widget,
    //             transitionKey: ValueKey('login'),
    //           ),
    //         ],
    //       );
    //     }
    //   }
    // }

    return Navigator(
      key: navigatorKey,
      // onGenerateRoute: (settings) {
      //   print('Navigator::settings.name::${settings.name}');
      //   print(
      //       'Navigator::currentConfiguration.path::${currentConfiguration.path}');

      // },
      onPopPage: (route, result) => _handlePopPage(route, result),
      pages: pages,

      // [

      //   // if (currentConfiguration.path == '/')
      //   // SharedAxisTransitionPageWrapper(
      //   //   screen: FlavorResponsiveView(breakpoints: {
      //   //     // DisplayType.s: Scaffold(
      //   //     //   drawer: Scaffold(
      //   //     //     body: ListView(),
      //   //     //   ),
      //   //     //   // appBar: AppBar(),
      //   //     //   body: app.routesMap['/'],
      //   //     // ),
      //   //     DisplayType.s: FlavorAppMobileView(
      //   //       app: app,
      //   //       child: app.routesMap['/'] as Widget,
      //   //     ),
      //   //     // DisplayType.m: Scaffold(
      //   //     //   appBar: AppBar(),
      //   //     //   body: app.routesMap['/'],
      //   //     //   drawer: Scaffold(
      //   //     //     body: ListView(),
      //   //     //   ),
      //   //     // ),
      //   //   }),
      //   //   transitionKey: ValueKey('_flavorPageHome'),
      //   // ),
      //   // if (app.routesMap.containsKey(currentConfiguration.path) &&
      //   //     currentConfiguration.path != '/')
      //   //   SharedAxisTransitionPageWrapper(
      //   //     screen: Scaffold(
      //   //       appBar: AppBar(
      //   //         title: Text(app.routesMap[currentConfiguration.path]!.path
      //   //             .toString()),
      //   //       ),
      //   //       body: app.routesMap[currentConfiguration.path],
      //   //     ),
      //   //     transitionKey:
      //   //         ValueKey('_flavorPageRoute::${currentConfiguration.path}'),
      //   //   )
      // ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    final bool didPop = route.didPop(result);
    print('_handlePopPage::didPop - $didPop');
    if (_pages.length > 1) _pages.removeAt(_pages.length - 1);
    // print('_pages.length::${_pages.length}');
    // print('_handlePopPage::didPop::numPages - ${_pages[0].path}');
    // removeLastUri();
    return didPop;
  }

  @override
  Future<bool> popRoute() {
    print('popRoute::currentConfiguration - ${currentConfiguration.path}');
    return Future.value(false);
  }

  // @override
  // void removeListener(VoidCallback listener) {
  //   // TODOs: implement removeListener
  // }

  @override
  Future<Uri> setNewRoutePath(newConfiguration) {
    print('setNewRoutePath::newConfiguration -: ${newConfiguration.path}');
    // _pages.add(MaterialPage(child: configuration));

    // print(
    //     'currentConfiguration != newConfiguration::${currentConfiguration != newConfiguration}');
    if (currentConfiguration != newConfiguration) {
      // _pages.last.path ==
      _pages.add(newConfiguration);
      notifyListeners();
    }
    // navigatorKey.currentState!.pushNamed('/');
    return Future.value(newConfiguration);
  }

  /// Push an [Uri]
  Future<void> push(Uri uri) {
    if (currentConfiguration == uri) {
      return Future.value();
    }
    // return setNewRoutePath(uri);
    _pages.add(uri);
    notifyListeners();
    return Future.value(uri);
  }

  /// replace
  Future<void> replace(Uri uri) {
    _pages.removeLast();
    return push(uri);
  }

  /// pop
  void pop() {
    if (_pages.length > 1) {
      removeLastUri();
    } else {
      print('Cannot pop');
    }
  }

  /// clear the list of [pages] and then push an [Uri]
  Future<void> clearAndPush(Uri uri, {dynamic params}) {
    _pages.clear();
    return push(uri);
  }

  /// Push multiple [Uri] at once
  Future<void> pushAll(List<Uri> uris) async {
    for (final uri in uris) {
      await push(uri);
    }
  }

  /// clear the list of [pages] and then push multiple [Uri] at once
  Future<void> clearAndPushAll(List<Uri> uris) {
    _pages.clear();
    return pushAll(uris);
  }

  /// remove a specific [Uri] and the corresponding [Page]
  void removeUri(Uri uri) {
    final index = _pages.indexOf(uri);
    _pages.removeAt(index);
    notifyListeners();
  }

  /// remove the last [Uri] and the corresponding [Page]
  void removeLastUri() {
    _pages.removeLast();
    notifyListeners();
  }

  /// Simple method to use instead of `await Navigator.push(context, ...)`
  /// The result can be set either by [returnWith]
  Future<dynamic> waitAndPush(Uri uri, {dynamic params}) async {
    _boolResultCompleter = Completer<dynamic>();
    await push(uri);
    notifyListeners();
    return _boolResultCompleter.future;
  }

  /// This is custom method to pass returning value
  /// while popping the page. It can be considered as an example
  void returnAndPush(dynamic value) {
    _pages.removeLast();
    _boolResultCompleter.complete(value);
    notifyListeners();
  }

  /// remove the pages and go root page
  void popToRoot() {
    _pages.removeRange(1, _pages.length);
    notifyListeners();
  }

  late Completer<dynamic> _boolResultCompleter;
}

extension FlavorNavigator on BuildContext {
  push(Uri uri) {
    FlavorRouterDelegate.of(this).push(uri);
  }

  pushNamed(String path) {
    FlavorRouterDelegate.of(this).push(Uri(path: path));
  }
}
