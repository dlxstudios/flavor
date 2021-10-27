import 'package:flavor_app/features/client/client.dart';
import 'package:flavor_app/features/client/client_model.dart';
import 'package:flavor_app/features/splash/splash_screen.dart';
import 'package:flavor_app/test_flavor_app_1.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

var testApp = testFlavorApp1;
var app = FlavorAppClientModel.fromMap(testApp);

class FlavorClientBootStrap extends StatelessWidget {
  const FlavorClientBootStrap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('Bootstrap Started');

    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 00)),
      // .then((value) => Future.value(FlavorAppClientModel())),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // var app = snapshot.data;
          // ignore: avoid_print
          print('App JSON loaded');
          // ignore: avoid_print
          print('App JSON converted to FlavorAppClientModel');

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => null,
              ),
            ],
            child: const FlavorClient(),
          );
        } else {
          return const ScreenSplash();
        }
      },
    );
  }
}
