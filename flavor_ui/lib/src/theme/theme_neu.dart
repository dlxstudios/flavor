import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/widgets.dart';

extension Neumorphism on Widget {
  addNeu({
    double borderRadius = 10.0,
    double blurRadius = 10.0,
    Offset offset = const Offset(5, 5),
    // Color topShadowColor = FlavorColor(co: FlavorColors.white).value,
    Color bottomShadowColor = const Color(0x26234395),
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(
            offset: offset,
            blurRadius: blurRadius,
            color: bottomShadowColor,
          ),
          BoxShadow(
            offset: Offset(-offset.dx, -offset.dx),
            blurRadius: blurRadius,
            // color: topShadowColor,
          ),
        ],
      ),
      child: this,
    );
  }
}
