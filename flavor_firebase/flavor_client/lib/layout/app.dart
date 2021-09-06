import 'package:flavor_client/client/flavor_router.dart';
import 'package:flavor_client/client/flavor_state.dart';
import 'package:flavor_client/components/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlavorApp extends ConsumerWidget {
  final dynamic appState;

  FlavorApp(
    this.appState, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final FlavorClientState app = ref(this.appState);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: app.currentTheme,
      routeInformationParser: FlavorInfoParser(),
      routerDelegate: FlavorRouterDelegate(app),
      // color: Colors.red,
    );
    // return CupertinoApp(
    //   theme: CupertinoThemeData(
    //     scaffoldBackgroundColor: Colors.grey.shade900,
    //     brightness: Brightness.dark,
    //     barBackgroundColor: Colors.grey.shade900,
    //     primaryColor: Colors.amber,
    //     primaryContrastingColor: Colors.redAccent,
    //   ),
    //   key: ValueKey('eiwoe'),
    //   debugShowCheckedModeBanner: false,
    //   home: CupertinoTabScaffold(
    //     tabBar: CupertinoTabBar(
    //         items: _routesForTabs
    //             .map((e) => BottomNavigationBarItem(icon: Icon(Icons.ac_unit)))
    //             .toList()),
    //     tabBuilder: (BuildContext context, int index) {
    //       return CupertinoPageScaffold(
    //         navigationBar: CupertinoNavigationBar(
    //           backgroundColor: Colors.transparent,
    //           middle: Icon(Icons.search_outlined),
    //           leading: Container(
    //             // color: Colors.red,
    //             child: Icon(Icons.menu),
    //           ),
    //         ),
    //         child: Center(
    //           child: Text('data'),
    //         ),
    //       );
    //       // return _routesForTabs.elementAt(index)!.child;
    //     },
    //   ),
    // );

    // return MaterialApp(
    //   key: ValueKey('flavor_app'),
    //   debugShowCheckedModeBanner: false,
    //   theme: widget.app.currentTheme,
    //   home: FlavorResponsiveView(
    //     breakpoints: {
    //       DisplayType.s: FlavorAppMobileView(
    //         app: widget.app,
    //         child: MaterialApp.router(
    //           key: ValueKey('flavor_client'),
    //           // debugShowCheckedModeBanner: false,
    //           // theme: widget.app.currentTheme,
    //           routeInformationParser: FlavorInfoParser(),
    //           routerDelegate: FlavorRouterDelegate(widget.app),
    //         ),
    //       ),
    //     },
    //   ),
    // );
  }
}

class FlavorAppMobileView extends StatelessWidget {
  final Widget child;

  FlavorAppMobileView({
    Key? key,
    required this.app,
    required this.child,
  });

  final FlavorClientState app;

  List<Widget> get _tabs => List.unmodifiable(app.routesForDrawer.map((e) {
        return Tab(icon: Icon(e!.icon), text: '${e.title}');
      }));

  @override
  Widget build(BuildContext context) {
    Widget _widget = child;

    // if (_tabs == null && useDrawer == false || _tabs!.length < 2) {
    //   return child;
    // }

    print('_tabs.length::${_tabs.length}');

    if (_tabs.length >= 2) {
      _widget = DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          key: app.scaffoldKey,
          appBar: app.routesForDrawer.length > 0
              ? AppBar(
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      app.scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(Icons.menu),
                  ),
                  // backgroundColor: Colors.transparent,
                )
              : null,
          drawer: AspectRatio(
            aspectRatio: .4,
            child: Container(
              // color: Colors.amber,
              child: Material(
                child: ListView(
                  children: app.routesForDrawer
                      .map(
                        (e) => ListTile(
                          leading: Icon(e!.icon),
                          title: Text('${e.title}'),
                          onTap: () {
                            // Navigator.of(context).pop();
                            FlavorRouterDelegate.of(context)
                                .push(Uri(path: e.path));
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          bottomNavigationBar: TabBar(
            tabs: _tabs,
          ),
          body: TabBarView(
            children: app.routesForTabs.map((tab) => tab!.child).toList(),
          ),
        ),
      );
    }

    return _widget;
  }
}
