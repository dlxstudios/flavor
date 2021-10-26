import 'package:css_colors/css_colors.dart';
import 'package:flavor_app/features/card/card_box.dart';
import 'package:flavor_app/features/list_tile/list_tile.dart';
import 'package:flavor_app/features/scaffold/scaffold.dart';
import 'package:flavor_app/features/theme/theme.dart';
import 'package:flavor_app/features/theme/theme_data.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_remix/flutter_remix.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Theme _themeStateController = Theme.of(context).theme;
    return FlavorScaffold(
      topBar: const FlavorTopBar(),
      bottomBar: const SizedBox(
        height: 60,
        child: ListTile(
            // color: FlavorColors().yellow,
            ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => CardBox(
              child: Column(
                children: List.generate(
                  8,
                  (index) => SizedBox(
                    height: 60,
                    child: ListTile(
                        leading: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            // color: FlavorColors().gold,
                            child: const Text('wwqeqeq'),
                          ),
                        ),
                        title: const Text('Check Tho'),
                        subtitle: const Text('SirSkii')
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
    );
  }
}

class FlavorTopBar extends StatelessWidget {
  const FlavorTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Theme _themeStateController = Theme.of(context).theme;

    return SizedBox(
      height: 60,
      child: ListTile(
        color: _themeStateController.theme.primaryColor!.value.withOpacity(.2),
        title: const Text('data'),
        leading: GestureDetector(
          onTap: () {
            _themeStateController.updateThemeMode(
              _themeStateController.themeMode == FlavorThemeMode.light
                  ? FlavorThemeMode.dark
                  : FlavorThemeMode.light,
            );
          },
          child: Icon(
            FlutterRemix.sun_line,
            color: _themeStateController.themeMode == FlavorThemeMode.light
                ? CSSColors.black
                : CSSColors.white,
          ),
        ),
      ),
    );
  }
}
