import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/widgets.dart';

class FlavorScaffold extends StatelessWidget {
  const FlavorScaffold({
    Key? key,
    required this.child,
    this.topBar,
    this.bottomBar,
  }) : super(key: key);

  final Widget child;
  final Widget? topBar;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    Widget? _child = child;
    if (topBar != null || bottomBar != null) {
      _child = Column(
        children: [
          topBar ?? Container(),
          Expanded(child: child),
          bottomBar ?? Container(),
        ],
      );
    }

    Theme themeStateController = Theme.of(context).theme;

    return FlavorAnimatedContainer(
      color: themeStateController.theme.backgroundColor!.value,
      child: _child,
    );
  }
}
