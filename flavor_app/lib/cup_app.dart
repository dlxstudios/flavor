import 'package:css_colors/css_colors.dart';
import 'package:flavor_app/features/card/card_box.dart';
import 'package:flavor_app/features/home/home_screen.dart';
import 'package:flavor_app/features/list_tile/list_tile.dart';
import 'package:flavor_app/features/scaffold/scaffold.dart';
import 'package:flavor_app/features/theme/theme.dart';
import 'package:flutter/cupertino.dart';

class CupApp extends StatelessWidget {
  const CupApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: ScreenHome(),
    );
  }
}

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    return DefaultTheme(
      child: FlavorScaffold(
        topBar: const FlavorTopBar(),
        bottomBar: const SizedBox(
          height: 60,
          child: ListTile(
              // color: FlavorColors().yellow,
              ),
        ),
        child: CupertinoPageScaffold(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => CardBox(
                  color: CSSColors.aliceBlue,
                  child: Column(
                    children: List.generate(
                      8,
                      (index) => const SizedBox(
                        height: 60,
                        child: ListTile(
                            leading: AspectRatio(
                              aspectRatio: 1,
                              child: Text('wwqeqeq'),
                            ),
                            title: Text('Check Tho'),
                            subtitle: Text('SirSkii')
                            // trailing: Container(
                            //   color: FlavorColors().amber,
                            //   child: const DLXLogo(),
                            // ),
                            ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 24,
                ),
                itemCount: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
