import 'package:flavor_client/components/page.dart';
import 'package:flavor_client/models/app.dart';
import 'package:flavor_client/pages/dashboard.dart';
import 'package:flavor_client/pages/profile/profile.dart';
import 'package:flavor_client/utilities/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flavor_http/http.dart';

List<FlavorAppModel> apps = [
  FlavorAppModel(
    id: 'app#303',
    title: 'Admin',
    image: 'https://i.picsum.photos/id/866/200/200.jpg',
  ),
  FlavorAppModel(
    id: 'app#suace10',
    title: 'SauceTv',
    image: 'https://i.picsum.photos/id/867/200/200.jpg',
  ),
  FlavorAppModel(
    id: 'app#gotix4',
    title: 'GoTix',
    image: 'https://i.picsum.photos/id/868/200/200.jpg',
  ),
  FlavorAppModel(
    id: 'app#bookin1',
    title: 'Booking',
    image: 'https://i.picsum.photos/id/869/200/200.jpg',
  ),
  FlavorAppModel(
    id: 'app#303',
    title: 'Admin',
    image: 'https://i.picsum.photos/id/866/200/200.jpg',
  ),
];

class FlavorAppState extends ChangeNotifier {
  //
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, int> defaultBreakpoints = {
    'small': 480,
    'med': 720,
    'large': 1200
  };

  breakpoint(BuildContext context) {
    for (var point in defaultBreakpoints.keys) {
      log.i('point | $point');
    }
  }

  bool requireLogin = false;

  final BuildContext context;
  // FlavorAuthEmail auth;

  /// The state of the entire App
  ///
  ///
  // ignore: unused_field
  Map<String, StatefulWidget Function(dynamic)> _defaultRoutes = {
    '/': (context) => FlavorPageDashboard(),
    // '/onboarding': (context) => FlavorPageOnBoarding(),
    'profile': (context) => FlavorPageProfile(),
  };

  Map<String, Widget> routes = {};

  FlavorAppModel appModel;

  FlavorAppState(this.context,
      {required this.appModel, Map<String, Widget>? addedRoutes}) {
    if (appModel == null) {
      /// @ loadfrom web/domain name
      return;
    }
    appModel = appModel;
    routes = {...?addedRoutes};
    // List.generate(appModel.pages.keys.length, (page) {
    //   log.w(appModel.pages[page]);
    //   FlavorPageModel pageModel = FlavorPageModel.formJson(appModel.pages[page]);
    //   routes.putIfAbsent(pageModel.path, () => FlavorPage.fromFlavorPageModel(pageModel));
    // });

    appModel.pages!.keys.map((page) {
      log.w(appModel.pages![page]);
      // ignore: unused_local_variable
      FlavorPageModel pageModel =
          FlavorPageModel.formJson(appModel.pages![page]);
      // routes.putIfAbsent(
      //     pageModel.path, () => FlavorPageView.fromFlavorPageModel(pageModel));
    });
  }

  String apiApps = 'apps';
  String apiBase = 'https://api.flavor.dlxsudios.com/';

  //////////////////////////////////////
  ///
  List<FlavorAppModel> apps = [
    FlavorAppModel(
      id: 5315135.toString(),
      title: 'SauceTV',
    ),
  ];

  Future<List<FlavorAppModel>> getApps() async {
    var appsJson = await fetchJson(apiBase);
    List<FlavorAppModel> apps = [];

    if (appsJson.containsKey('results')) {
      List items = appsJson['results'];

      for (var item in items) {
        print(item);
        apps.add(
          FlavorAppModel(),
        );
      }
      return apps;
    }

    // return [];
    /// temp return $_apps
    return apps;
  }
  /////////////////////////////////////////
  ///

}
