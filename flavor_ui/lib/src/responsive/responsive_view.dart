import 'dart:developer';

import 'package:flavor_ui/src/responsive/responsive_utils.dart';
import 'package:flutter/widgets.dart';

class ResponsiveView extends StatefulWidget {
  final Map<DisplayType, Widget>? breakpoints;
  final Axis axis;
  final bool printDebug;

  final bool global;
  const ResponsiveView(
      {Key? key,
      this.axis = Axis.vertical,
      this.breakpoints,
      this.global = false,
      this.printDebug = false})
      : super(key: key);
  @override
  _ResponsiveViewState createState() => _ResponsiveViewState();
}

class _ResponsiveViewState extends State<ResponsiveView> {
  @override
  Widget build(BuildContext context) {
    if (widget.global) {
      return fromGlobal(context);
    }
    return fromLayout(context);
  }

  Widget fromLayout(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      if (widget.printDebug) {
        log(size.toString());
        log(fMediaQuery(context, size.maxWidth).toString());
        log(widget.breakpoints!
            .containsKey(fMediaQuery(context, size.maxWidth))
            .toString());
      }
      return getViewFromDisplayType(
          widget.breakpoints, fMediaQuery(context, size.maxWidth));
    });
  }

  Widget fromGlobal(BuildContext context) {
    // Widget _child;

    DisplayType dt = fDisplayMediaQuery(context);

    // log.e(_child);

    if (widget.printDebug) {
      log(dt.toString());
    }
    return getViewFromDisplayType(widget.breakpoints, dt);
  }
}

Widget getViewFromDisplayType(breakpoints, DisplayType displayType) {
  switch (displayType) {
    case DisplayType.s:
      return breakpoints[DisplayType.s];
      // ignore: dead_code
      break;
    case DisplayType.m:
      return breakpoints.containsKey(DisplayType.m)
          ? breakpoints[DisplayType.m]
          : breakpoints[DisplayType.s];
      // ignore: dead_code
      break;
    case DisplayType.l:
      return breakpoints.containsKey(DisplayType.l)
          ? breakpoints[DisplayType.l]
          : breakpoints.containsKey(DisplayType.m)
              ? breakpoints[DisplayType.m]
              : breakpoints[DisplayType.s];
      // ignore: dead_code
      break;
    case DisplayType.xl:
      return breakpoints.containsKey(DisplayType.xl)
          ? breakpoints[DisplayType.xl]
          : breakpoints.containsKey(DisplayType.l)
              ? breakpoints[DisplayType.l]
              : breakpoints.containsKey(DisplayType.m)
                  ? breakpoints[DisplayType.m]
                  : breakpoints[DisplayType.s];
      // ignore: dead_code
      break;
  }
  // ignore: dead_code
  return breakpoints[DisplayType.s];
}
