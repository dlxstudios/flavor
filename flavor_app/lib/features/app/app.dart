import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FlavorApp extends StatelessWidget {
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale>? supportedLocales;
  final String Function(BuildContext)? onGenerateTitle;
  const FlavorApp({
    Key? key,
    this.onGenerateRoute,
    this.localizationsDelegates,
    this.supportedLocales,
    this.onGenerateTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      canRequestFocus: false,
      onKey: (FocusNode node, RawKeyEvent event) {
        // print(event);
        if (event is! RawKeyDownEvent ||
            event.logicalKey != LogicalKeyboardKey.escape) {
          return KeyEventResult.ignored;
        }
        return KeyEventResult.handled;
      },
      child: DefaultTheme(
        child: Builder(builder: (context) {
          Theme _themeStateController = Theme.of(context).theme;

          return WidgetsApp(
            title: 'App',
            restorationScopeId: 'app',
            debugShowCheckedModeBanner: false,
            color: _themeStateController.theme.primaryColor!.value,
            onGenerateRoute: onGenerateRoute,
            localizationsDelegates: localizationsDelegates,
            // supportedLocales: supportedLocales,
            onGenerateTitle: onGenerateTitle,
          );
        }),
      ),
    );
  }
}
