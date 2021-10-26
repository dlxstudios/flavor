import 'package:flavor_app/features/client/client_model.dart';
import 'package:flavor_app/features/page/page.dart';
import 'package:flavor_app/features/page/page_error.dart';
import 'package:flavor_app/features/theme/theme.dart';
import 'package:flavor_app/test_flavor_app_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regex_router/regex_router.dart';

var testApp = testFlavorApp1;
var app = FlavorAppClientModel.fromMap(testApp);

class FCup extends StatelessWidget {
  const FCup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(app);
    return DefaultTheme(
      child: WidgetsApp(
        color: Colors.green,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(0),
            // color: Colors.red,
            child: child,
          );
        },
        onGenerateRoute: computeRouter(app.pages),
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
