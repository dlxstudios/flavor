import 'package:flavor/layout/adaptive.dart';
import 'package:flavor/utilities/services.dart';
import 'package:flutter/material.dart';

/// Breakpoint Examples
// Map<DisplayType, Widget> _breakpoints = {
//   DisplayType.s: Container(
//     child: Center(
//       child: Text('480'),
//     ),
//   ),
//   DisplayType.m: Row(
//     children: [
//       Container(
//         child: Center(
//           child: Text('480'),
//         ),
//       ),
//       Container(
//         child: Center(
//           child: Text('720'),
//         ),
//       )
//     ],
//   ),
//   DisplayType.l: Row(children: [
//     Container(
//       child: Center(
//         child: Text('480'),
//       ),
//     ),
//     Container(
//       child: Center(
//         child: Text('720'),
//       ),
//     ),
//     Container(
//       child: Center(
//         child: Text('1080'),
//       ),
//     )
//   ])
// };

class FlavorResponsiveView extends StatefulWidget {
  final Map<DisplayType, Widget>? breakpoints;
  final Axis axis;
  final bool printDebug;

  final bool global;
  const FlavorResponsiveView(
      {Key? key,
      this.axis = Axis.vertical,
      this.breakpoints,
      this.global = false,
      this.printDebug = false})
      : super(key: key);
  @override
  _FlavorResponsiveViewState createState() => _FlavorResponsiveViewState();
}

class _FlavorResponsiveViewState extends State<FlavorResponsiveView> {
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
        log.i(size);
        log.i(fMediaQuery(context, size.maxWidth));
        log.i(widget.breakpoints!
            .containsKey(fMediaQuery(context, size.maxWidth)));
      }
      // log.i(size.maxWidth);
      return getViewFromDisplayType(
          widget.breakpoints, fMediaQuery(context, size.maxWidth));
      // return widget.breakpoints[fMediaQuery(context, size.maxWidth)];
    });
  }

  Widget fromGlobal(BuildContext context) {
    // Widget _child;

    DisplayType dt = fDisplayMediaQuery(context);

    // log.e(_child);

    if (widget.printDebug) {
      log.i(dt);
      // log.i(_child);
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
