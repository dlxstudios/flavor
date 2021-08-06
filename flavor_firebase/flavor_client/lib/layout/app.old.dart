// import 'package:flavor/apps/admin/state.dart';
// import 'package:flavor/components/route.dart';
// import 'package:flavor/layout/adaptive_view.dart';
// import 'package:flavor/theme/clay/widget.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class FlavorAppView extends StatefulWidget {
//   final List<FlavorRouteWidget> routes;
//   final GlobalKey<NavigatorState> navigatorKey;

//   const FlavorAppView({
//     Key key,
//     this.routes,
//     this.navigatorKey,
//   }) : super(key: key);

//   @override
//   _FlavorAppViewState createState() => _FlavorAppViewState();
// }

// class _FlavorAppViewState extends State<FlavorAppView> {
//   int _destinationCount = 5;
//   bool _fabInRail = false;
//   bool _includeBaseDestinationsInMenu = true;

//   int selectedDestination = 0;

//   PageController _pageController;

//   GlobalKey<NavigatorState> _nav;

//   _body() {
//     FlavorAdminState _app = context.read(flavorAdminStateProvider);

//     var usePager = MediaQuery.of(context).size.width < 600;

//     if (usePager) {
//       _pageController = PageController(
//         keepPage: true,
//         initialPage: selectedDestination,
//       );
//       if (kIsWeb) {
//         return PageView(
//           controller: _pageController,
//           onPageChanged: (value) => updateNavigationFromPager(value),
//           clipBehavior: Clip.antiAlias,
//           physics: RangeMaintainingScrollPhysics(),
//           children: widget.routes.map((e) => e).toList(),
//         );
//       }
//     }

//     // return widget.routes[selectedDestination];

//     _nav = widget.navigatorKey;

//     return Navigator(
//       onPopPage: (route, result) {
//         print('Route : "${route.settings.name}" is tryna pop! ');
//         // return true;
//       },
//       key: _nav,
//       initialRoute: widget.routes[selectedDestination].path,
//       onGenerateRoute: (settings) {
//         var path;
//         var route;
//         // print(selectedDestination != null);
//         path = settings.name;
//         route = _app.routesMap.containsKey(path) ? _app.routesMap[path] : null;

//         // if (route == null) {
//         //   return MaterialPageRoute(
//         //     maintainState: true,
//         //     builder: (BuildContext context) {
//         //       return ClayText(
//         //         'Error : 404',
//         //         style: Theme.of(context)
//         //             .textTheme
//         //             .headline2
//         //             .copyWith(letterSpacing: 10),
//         //       );
//         //     },
//         //   );
//         // }

//         return route != null
//             ? MaterialPageRoute(
//                 settings: settings,
//                 builder: (context) => route,
//               )
//             : null;

//         return route != null
//             ? MaterialPageRoute(
//                 builder: (context) => Scaffold(
//                   appBar: path != '/'
//                       ? AppBar(
//                           backgroundColor: Theme.of(context).canvasColor,
//                           elevation: 0,
//                           title: Text(settings.toString()),
//                         )
//                       : null,
//                   body: route,
//                 ),
//               )
//             : null;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AdaptiveNavigationScaffold(
//       selectedIndex: selectedDestination,
//       destinations: widget.routes
//           .sublist(0, _destinationCount)
//           .map((e) => AdaptiveScaffoldDestination(title: e.title, icon: e.icon))
//           .toList(),
//       // appBar: AdaptiveAppBar(
//       //   elevation: 30,
//       //   title: const Text('Flavor Admin'),
//       // ),
//       appBar: ClayAppBar(),
//       body: _body(),
//       // floatingActionButton: FloatingActionButton(
//       //   child: Icon(Icons.add),
//       //   onPressed: () {},
//       // ),
//       navigationTypeResolver: (context) {
//         if (MediaQuery.of(context).size.width > 600) {
//           if (kIsWeb) {
//             return NavigationType.permanentDrawer;
//           }
//           return NavigationType.drawer;
//         } else {
//           if (!kIsWeb) {
//             // return NavigationType.drawer;
//           }
//           return NavigationType.bottom;
//         }
//       },
//       fabInRail: _fabInRail,
//       includeBaseDestinationsInMenu: _includeBaseDestinationsInMenu,
//       onDestinationSelected: (value) =>
//           updateNavigationFromDestination(context, value),
//     );
//   }

//   updateNavigationFromDestination(BuildContext context, int value) {
//     if (MediaQuery.of(context).size.width > 600) {
//       // if (kIsWeb) {
//       //   widget.navigatorKey.currentState.pushNamed(widget.routes[value].path);
//       //   // Scaffold.of(context).isDrawerOpen ? Navigator.of(context).pop() : null;
//       // }
//       // print(routes[value].path);
//       Navigator.of(context).pushNamed(widget.routes[value].path);
//     } else {
//       if (!kIsWeb) {
//         widget.navigatorKey.currentState.pushNamed(widget.routes[value].path);
//       } else {
//         _pageController.animateToPage(value,
//             duration: Duration(milliseconds: 180), curve: Curves.easeInOutExpo);
//       }
//     }
//     setState(() => selectedDestination = value);
//     print('selectedDestination $selectedDestination, was updated to $value ');
//   }

//   updateNavigationFromPager(int value) {
//     setState(() => selectedDestination = value);
//   }
// }
