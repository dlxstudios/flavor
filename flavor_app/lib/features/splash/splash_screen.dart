import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Center(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 320, maxWidth: 320),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CupertinoActivityIndicator(radius: 50.0),
                Text(
                  'App Name',
                  style: (TextStyle(fontSize: 56, fontWeight: FontWeight.w300)),
                ),
              ],
            ),
          ),
        ),
      ),
      color: Color(int.parse(FlavorColors.purple)),
    );
  }
}
