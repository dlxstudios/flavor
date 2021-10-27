import 'package:css_colors/css_colors.dart';
import 'package:flavor_app/features/logo/logo.dart';
import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Theme _themeStateController = Theme.of(context).theme;
    return FlavorScaffold(
      topBar: const FlavorTopBar(),
      bottomBar: const FlavorBottomBar(),
      child: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        primary: true,
        clipBehavior: Clip.antiAlias,
        physics: const BouncingScrollPhysics(),
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
                          color: CSSColors.gold,
                          child: const Text('wwqeqeq'),
                        ),
                      ),
                      title: const Text('Check Tho'),
                      subtitle: const Text('SirSkii'),
                      trailing: Container(
                        color: CSSColors.aliceBlue,
                        child: const DLXLogo(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 24,
            ),
            itemCount: 5,
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
      child: Container(
        padding: const EdgeInsets.only(bottom: .4),
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: CSSColors.black,
              blurRadius: 5,
              spreadRadius: 5,
              offset: Offset(0, -8),
            ),
          ],
          // color: CSSColors.deepPink,
        ),
        child: ListTile(
          color: _themeStateController.theme.backgroundColor!.value,
          // title: Text(
          //   'data',
          //   style: FlavorTextTheme.of(context)?.headline5?.textStyle,
          // ),
          // leading: GestureDetector(
          //   onTap: () {
          //     _themeStateController.updateThemeMode(
          //       _themeStateController.themeMode == FlavorThemeMode.light
          //           ? FlavorThemeMode.dark
          //           : FlavorThemeMode.light,
          //     );
          //   },
          //   child: Icon(
          //     FlutterRemix.sun_line,
          //     color: _themeStateController.themeMode == FlavorThemeMode.light
          //         ? CSSColors.black
          //         : CSSColors.white,
          //   ),
          // ),
        ),
      ),
    );
  }
}

class FlavorBottomBar extends StatelessWidget {
  const FlavorBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Theme _themeStateController = Theme.of(context).theme;

    return SizedBox(
      height: 60,
      child: Container(
        padding: const EdgeInsets.only(top: .4),
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: CSSColors.black,
              blurRadius: 5,
              spreadRadius: 5,
              offset: Offset(0, 8),
            ),
          ],
          // color: CSSColors.deepPink,
        ),
        child: ListTile(
          color: _themeStateController.theme.cardColor!.value,
          // title: Text(
          //   'data',
          //   style: FlavorTextTheme.of(context)?.headline5?.textStyle,
          // ),
          // leading: GestureDetector(
          //   onTap: () {
          //     _themeStateController.updateThemeMode(
          //       _themeStateController.themeMode == FlavorThemeMode.light
          //           ? FlavorThemeMode.dark
          //           : FlavorThemeMode.light,
          //     );
          //   },
          //   child: Icon(
          //     FlutterRemix.sun_line,
          //     color: _themeStateController.themeMode == FlavorThemeMode.light
          //         ? CSSColors.black
          //         : CSSColors.white,
          //   ),
          // ),
        ),
      ),
    );
  }
}
