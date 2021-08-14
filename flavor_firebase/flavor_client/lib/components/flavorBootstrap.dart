// import 'dart:convert';

// import 'package:flavor_client/components/flavorMenu.dart';
// import 'package:flavor_client/components/flavorScaffold.dart';
// import 'package:flavor_client/layout/adaptive.dart';
// import 'package:flavor_client/models/app.dart';
// import 'package:flavor_client/utilities/FlavorAppState.dart';
// // import 'package:flavor_client/utilities/FlavorAuth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:flavor_auth/src/models/user.dart';


// ThemeData defaultTheme = ThemeData.dark().copyWith(
//   primaryColor: Colors.white,
//   accentColor: Colors.deepPurpleAccent,
// );

// class FlavorAppBootstrap extends StatefulWidget {
//   final Map<String, Widget> routes;

//   /// SingleChildClonableWidget
//   final List<dynamic> providers;
//   final Widget appBar;
//   final ThemeData theme;
//   final Widget drawer;
//   final double drawerWidth;
//   final DisplayType drawerBreakpoint;
//   final Widget endDrawer;
//   final double endDrawerWidth;
//   final DisplayType endDrawerBreakpoint;

//   final Color statusbarColor;

//   final String jsonFile;

//   final FlavorAppModel appModel;

//   const FlavorAppBootstrap({
//     Key? key,
//     this.routes,
//     this.providers = const [],
//     this.drawer,
//     this.endDrawer,
//     this.appBar,
//     this.theme,
//     this.drawerWidth,
//     this.drawerBreakpoint,
//     this.endDrawerWidth,
//     this.endDrawerBreakpoint,
//     this.statusbarColor,
//     this.jsonFile = 'assets/flavor.json',
//     this.appModel,
//   }) : super(key: key);
//   @override
//   _FlavorAppBootstrapState createState() => _FlavorAppBootstrapState();
// }

// class _FlavorAppBootstrapState extends State<FlavorAppBootstrap> {
//   FlavorAppModel _appModel;

//   Future<String> loadFlavorJson() async {
//     return await rootBundle.loadString(widget.jsonFile);
//   }

//   /// BootLoader
//   @override
//   void initState() {
//     super.initState();
//     widget.appModel == null
//         ? loadFlavorJson()
//             .then((String jsonTxt) => json.decode(jsonTxt))
//             .then((json) =>
//                 FlavorAppModel.fromJson(json)) //as Map<String, dynamic>))
//             .then((appModel) => setState(() => _appModel = appModel))
//         : setState(() => _appModel = widget.appModel);
//     // Settings from file or web
//     // DefaultAssetBundle.of(context).loadString("assets/flavor.json").then((value) => null);
//     // Storage
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_appModel != null) {
//       // log.wtf(widget.routes.containsKey('/'));
//     }
//     return _appModel == null
//         ? MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: widget.theme ?? defaultTheme,
//             home: Scaffold(
//                 // backgroundColor: Colors.red,
//                 body: Center(
//               child: Container(
//                 // padding: const EdgeInsets.all(64.0),
//                 child: RefreshProgressIndicator(),
//               ),
//             )),
//           )
//         // : ChangeNotifierProvider<FlavorAppState>(
//         //     create: (context) => FlavorAppState(context, appModel :_appModel, addedRoutes:widget.routes),
//         //     child: Consumer<FlavorAppState>(
//         //       builder: (BuildContext context, state, Widget child) {
//         //         return MaterialApp(
//         //           key: Key(_appModel.title),
//         //           debugShowCheckedModeBanner: false,
//         //           darkTheme: ThemeData.dark(),
//         //           home: FlavorScaffold(
//         //             scaffoldKey: state.scaffoldKey,
//         //             navigatorKey: state.navigatorKey,
//         //             routes: state.routes,
//         //               // drawer: FlavorAppMenu(),
//         //               // endDrawer: FlavorAppMenu(),
//         //               ),
//         //           // routes: widget.routes,
//         //           // home: state.routes ?? PageShell(
//         //           //   statusbarColor: Colors.transparent,
//         //           //   child: _routeHome,
//         //           // ),
//         //         );
//         //       },
//         //     ),
//         //   );

//         : ChangeNotifierProvider<FlavorAppState>(
//             create: (context) => FlavorAppState(context,
//                 appModel: _appModel, addedRoutes: widget.routes),
//             child: Consumer<FlavorAppState>(
//               builder: (BuildContext context, state, Widget child) {
//                 // return MaterialApp(home: Scaffold(body: Material(),));
//                 return MultiProvider(
//                   providers: widget.providers,

//                   /// appModel.plugings
//                   child: MaterialApp(
//                     // key: Key(_appModel.title),
//                     debugShowCheckedModeBanner: false,
//                     theme: widget.theme ?? defaultTheme,
//                     home: FlavorScaffold(
//                       appBar: widget.appBar,
//                       scaffoldKey: state.scaffoldKey,
//                       navigatorKey: state.navigatorKey,
//                       routes: state.routes,
//                       drawer: widget.drawer,
//                       drawerWidth: widget.drawerWidth,
//                       drawerBreakpoint: widget.drawerBreakpoint,
//                       endDrawer: widget.endDrawer,
//                       endDrawerWidth: widget.endDrawerWidth,
//                       endDrawerBreakpoint: widget.endDrawerBreakpoint,
//                       statusbarColor: widget.statusbarColor,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//   }
// }

// class FlavorApp extends StatefulWidget {
//   final FlavorAppModel appModel;

//   const FlavorApp({Key key, this.appModel}) : super(key: key);
//   @override
//   _FlavorAppState createState() => _FlavorAppState();
// }

// class _FlavorAppState extends State<FlavorApp> {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<FlavorAppState>(
//       create: (context) => FlavorAppState(context, appModel: widget.appModel),
//       child: Consumer<FlavorAppState>(
//         builder: (BuildContext context, state, Widget child) {
//           return MaterialApp(
//             key: Key('saucetv_app'),
//             debugShowCheckedModeBanner: false,
//             darkTheme: ThemeData.dark(),
//             home: FlavorScaffold(
//                 // drawer: FlavorAppMenu(),
//                 // endDrawer: FlavorAppMenu(),
//                 routes: state.routes),
//             // routes: widget.routes,
//             // home: state.routes ?? PageShell(
//             //   statusbarColor: Colors.transparent,
//             //   child: _routeHome,
//             // ),
//           );
//         },
//       ),
//     );
//   }
// }

// class FlavorAppAdmin extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // FlavorStore store = FlavorStore();

//     // Plugings
//     return ChangeNotifierProvider<FlavorAppState>(
//       create: (BuildContext context) {
//         return FlavorAppState(context);
//       },
//       child: Consumer<FlavorAppState>(
//         builder: (BuildContext context, state, Widget child) {
//           Color _appColor = Color(0xFF745AA0);
//           // print(state.navigatorKey);
//           return MaterialApp(
//             /// debug
//             debugShowCheckedModeBanner: false,
//             title: 'Flavor',

//             /// Navigation
//             // navigatorKey: state.navigatorKey,

//             /// Theme
//             theme: ThemeData(
//               brightness: Brightness.dark,
//               primarySwatch: Colors.deepPurple,
//               accentColor: _appColor,
//               visualDensity: VisualDensity.adaptivePlatformDensity,
//               cardColor: Colors.deepPurple,
//             ),
//             // darkTheme: ThemeData(
//             //   primaryColorDark: _appColor,
//             //   // primarySwatch: Colors.deepPurple,
//             //   accentColor: _appColor,
//             //   visualDensity: VisualDensity.adaptivePlatformDensity,
//             // ),

//             home: PageSplashLogin(),
//             // home: FlavorResponsiveView(
//             //   drawer: FlavorAppMenu(),
//             //   body: FlavorAppBody(),
//             // ),
//             // initialRoute: '/',
//             // onGenerateRoute: onGenerateRoute,
//           );
//         },
//       ),
//     );
//   }
// }

// class PageSplashLogin extends StatefulWidget {
//   const PageSplashLogin({
//     Key key,
//   }) : super(key: key);

//   @override
//   _PageSplashLoginState createState() => _PageSplashLoginState();
// }

// class _PageSplashLoginState extends State<PageSplashLogin> {
//   @override
//   Widget build(BuildContext context) {
//     return FlavorPageOnBoarding();
//     // return Consumer<FlavorAppBody>(builder: (context, _authState, _) {
//     //   bool isLoggedIn = _authState.loginStatus;
//     //   bool reqLogin = state.requireLogin && _authState.currentUser == null;
//     //   print(displayType (context)== DisplayType.m);
//     //   return reqLogin
//     //       ? FlavorPageOnBoarding()
//     //       : Scaffold(
//     //           body: !displayType (context)== DisplayType.m
//     //               ? FlavorAppBody()
//     //               : Row(
//     //                   children: [
//     //                     Flexible(
//     //                       flex: 0,
//     //                       child: Container(
//     //                         width: 320,
//     //                         child: FlavorAppMenu(),
//     //                       ),
//     //                     ),
//     //                     Expanded(
//     //                       flex: 1,
//     //                       child: FlavorAppBody(),
//     //                     ),

//     //                     // FlavorAppBody(),
//     //                   ],
//     //                 ),
//     //         );
//     // });
//     // return Stack(
//     //   children: [
//     //     Positioned.fill(
//     //       child: AnimatedOpacity(
//     //         opacity: isLoggedIn == null ? 1 : 0,
//     //         duration: Duration(milliseconds: 500),
//     //         child: Scaffold(
//     //             body: Center(
//     //           // child: Text(
//     //           //   'Flavor',
//     //           //   style: Theme.of(context)
//     //           //       .textTheme
//     //           //       .headline1
//     //           //       .copyWith(color: Theme.of(context).accentColor),
//     //           // ),
//     //           child: Image.asset(
//     //             'assets/images/Eff_Full.png',
//     //             // color: _appColor,
//     //           ),
//     //         )),
//     //       ),
//     //     ),
//     //     Positioned.fill(
//     //       child: AnimatedOpacity(
//     //         opacity: reqLogin ? 1 : 0,
//     //         duration: Duration(milliseconds: 500),
//     //         child: reqLogin ? FlavorPageOnBoarding() : Container(),
//     //       ),
//     //     ),
//     //     // Positioned.fill(
//     //     //   child: AnimatedOpacity(
//     //     //       opacity: reqLogin ? 0 : 1,
//     //     //       duration: Duration(milliseconds: 500),
//     //     //       child: state.currentUser != null ? _page : Container()),
//     //     // ),
//     //   ],
//     // );
//   }
// }

// class FlavorAppMenu extends StatefulWidget {
//   @override
//   _FlavorAppMenuState createState() => _FlavorAppMenuState();
// }

// class _FlavorAppMenuState extends State<FlavorAppMenu> {
//   @override
//   Widget build(BuildContext context) {
//     FlavorAppState state = Provider.of<FlavorAppState>(context);
//     // FlavorAuthStateOld _authState = Provider.of<FlavorAuthStateOld>(context);
//     FlavorUser user; //= _authState.currentUser;
//     // print('state.navigatorKey - ${state.navigatorKey.currentState}');

//     // log.i(user.email);

//     return FlavorMenu(
//       backgroundColor: Colors.transparent,
//       children: <Widget>[
//         AppBar(
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           backgroundColor: Colors.deepPurple,
//           title: Text('Flavor'),
//           actions: fDisplayMediaQuery(context) == DisplayType.m
//               ? null
//               : [
//                   IconButton(
//                       icon: Icon(Icons.close),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       })
//                 ],
//         ),
//         ListTile(
//           selected: true,
//           leading: Icon(Icons.ondemand_video),
//           title: Text('Dashboard'),
//           onTap: () =>
//               navigateToNameAndPopDrawer(context, '/', state.navigatorKey),
//         ),
//         ListTile(
//           leading: Icon(Icons.apps),
//           title: Text('Projects'),
//           onTap: () => navigateToNameAndPopDrawer(
//               context, 'projects', state.navigatorKey),
//         ),
//         ListTile(
//           leading: Icon(Icons.photo_library),
//           title: Text('Content'),
//           onTap: () => navigateToNameAndPopDrawer(
//               context, 'content', state.navigatorKey),
//         ),
//         ListTile(
//           leading: Icon(Icons.message),
//           title: Text('Messages'),
//           onTap: () => navigateToNameAndPopDrawer(
//               context, 'messages', state.navigatorKey),
//         ),
//         ListTile(
//           leading: Icon(Icons.settings),
//           title: Text('Settings'),
//           onTap: () => state.navigatorKey.currentState.pushNamed('settings'),
//         ),
//         ListTile(
//           leading: Icon(Icons.contact_phone),
//           title: Text('Support'),
//           onTap: () => navigateToNameAndPopDrawer(
//               context, 'support', state.navigatorKey),
//         ),

//         /// Menu Footer
//         Expanded(
//           child: Container(),
//         ),
//         ListTile(
//           leading: CircleAvatar(
//             backgroundImage: Image.network(
//               """https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif""",
//               fit: BoxFit.cover,
//             ).image,
//             backgroundColor: Theme.of(context).accentColor,
//             // child: Text(user.displayName.toUpperCase().substring(0, 2)),
//           ),
//           title: Text(user.displayName ?? user.email ?? '',
//               softWrap: false, overflow: TextOverflow.fade),
//           subtitle: Text(user.email ?? ''),
//           onTap: () => navigateToNameAndPopDrawer(
//               context, 'profile', state.navigatorKey),
//           trailing: IconButton(
//               icon: Icon(Icons.exit_to_app),
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (_) {
//                     return AlertDialog(
//                       title: Text('Signout ?'),
//                       content: Text('Are you sure you want to bang out?'),
//                       actions: [
//                         // Cancel
//                         TextButton(
//                             onPressed: () {
//                               Navigator.maybePop(context);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text('cancel'),
//                             )),
//                         // Signout
//                         ElevatedButton(
//                             onPressed: () {
//                               // _authState.signOut();
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text('bangout'),
//                             ))
//                       ],
//                     );
//                   },
//                 );
//               }),
//         ),

//         SizedBox(height: 20)
//       ],
//     );
//   }
// }

// navigateToNameAndPopDrawer(BuildContext context, String path,
//     [GlobalKey<NavigatorState> navigatorKey]) {
//   Navigator.maybePop(context);
//   if (navigatorKey != null) navigatorKey.currentState.pushNamed(path);
// }
