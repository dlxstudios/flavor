import 'package:flavor_app/features/container/container_animated.dart';
import 'package:flavor_app/features/theme/theme_data.dart';
import 'package:flavor_app/features/theme/theme_defaults.dart';
import 'package:flavor_app/features/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListTile extends StatefulWidget {
  const ListTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.color,
    this.selectedColor,
    this.selected,
  }) : super(key: key);

  //Widgets
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  // Colors
  final Color? color;
  final Color? selectedColor;
  //
  final bool? selected;

  @override
  State<ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<ListTile> {
  late Color _color;
  late Color _selectedColor;
  bool selected = false;

  @override
  void initState() {
    // _color = widget.color ?? FlavorTheme().theme.cardColor!;
    // _color = widget.color ?? FlavorColors.black.withOpacity(0);
    _color = widget.color ?? FlavorColor(FlavorColors.black).value;

    _selectedColor =
        widget.selectedColor ?? FlavorColor(FlavorColors.red).value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   selected = !selected;
        // });
        // // ignore: avoid_print
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        color: !selected ? _color : _selectedColor,
        // duration: defaultThemeDuration,
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 0,
              child: ListTileLeading(child: widget.leading),
            ),
            Expanded(
              child:
                  ListTileBody(title: widget.title, subtitle: widget.subtitle),
            ),
            Flexible(
              flex: 0,
              child: ListTileTrailing(child: widget.trailing),
            ),
          ],
        ),
      ),
    );
  }
}

class ListTileLeading extends StatelessWidget {
  final Widget? child;

  const ListTileLeading({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child ??
        Container(
            // margin: const EdgeInsets.all(4),
            );
  }
}

class ListTileBody extends StatelessWidget {
  const ListTileBody({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);
  final Widget? title;
  final Widget? subtitle;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Container(
        // color: FlavorColors.black45,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          height: size.maxHeight,
          width: size.maxWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              title ??
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
              subtitle ?? Container(),
            ],
          ),
        ),
      );
    });
  }
}

class ListTileTrailing extends StatelessWidget {
  final Widget? child;

  const ListTileTrailing({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child ??
        Container(
            // padding: const EdgeInsets.all(4),
            );
  }
}
