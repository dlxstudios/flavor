import 'package:flavor/components/refactor_components.dart';

import 'package:flavor/utilities/AppSettings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageSplash extends StatefulWidget {
  final String? text;

  const PageSplash({Key? key, this.text}) : super(key: key);

  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  var initListener;

  void _onAfterBuild(BuildContext context) {
    AppSettingsModel settings = Provider.of<AppSettingsModel>(context);

    settings.addListener(() {
      print(settings.init);

      if (settings.init) {
        // settings.isLoggedIn == true
        //     ? settings.pushTo('home', context: context)
        //     : settings.pushTo('onbording', context: context);

        settings.isLoggedIn == true
            ? Navigator.of(this.context).pushReplacementNamed(
                'home',
              )
            : Navigator.of(this.context).pushReplacementNamed(
                'onboarding',
              );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // AppSettingsModel settings = Provider.of<AppSettingsModel>(context);
    // settings.removeListener(initListener);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _onAfterBuild(context));
    // print('object');

    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Container(
        child: Center(
          child: DLXLogo(
            text: widget.text!,
            fontSize: 160,
          ),
        ),
      ),
    );
  }
}
