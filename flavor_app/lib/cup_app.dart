import 'package:flavor_app/features/home/home_screen.dart';
import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/cupertino.dart';

class CupApp extends StatelessWidget {
  const CupApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: ScreenHomeCup(),
    );
  }
}

class ScreenHomeCup extends StatelessWidget {
  const ScreenHomeCup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    return DefaultTheme(
      child: Builder(builder: (context) {
        Theme _themeStateController = Theme.of(context).theme;

        return CupertinoPageScaffold(
          backgroundColor: _themeStateController.theme.backgroundColor?.value,
          child: const ScreenHome(),
        );
      }),
    );
  }
}
