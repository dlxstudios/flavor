import 'package:flavor_app/features/container/container_animated.dart';
import 'package:flutter/widgets.dart';

import 'package:flavor_app/features/theme/theme.dart';

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
