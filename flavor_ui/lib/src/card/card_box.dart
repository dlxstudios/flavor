import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/widgets.dart';

class CardBox extends StatelessWidget {
  const CardBox({
    Key? key,
    required this.child,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.all(0),
    this.color,
  }) : super(key: key);

  final Widget child;

  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Theme _themeStateController = Theme.of(context).theme;
    return FlavorAnimatedContainer(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: _themeStateController.theme.cardColor!.value.withOpacity(.2),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
