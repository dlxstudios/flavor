import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/material.dart' as m;
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
    this.onTap,
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
  final void Function()? onTap;

  @override
  State<ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<ListTile> {
  // late Color _color;
  // late Color _selectedColor;
  bool selected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Color? _color;
    late Color _selectedColor;

    Theme themeStateController = Theme.of(context).theme;
    _color = widget.color;

    _selectedColor =
        widget.selectedColor ?? themeStateController.theme.primaryColor!.value;

    return GestureDetector(
      onTap: widget.onTap,
      // onTap: () {
      //   print('selected::$selected');
      //   setState(() {
      //     selected = !selected;
      //   });
      //   // // ignore: avoid_print
      // },
      child: AnimatedContainer(
        duration: Duration(milliseconds: themeStateController.theme.duration),

        color: !selected ? _color ?? m.Colors.transparent : _selectedColor,
        // duration: defaultThemeDuration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 0,
                child: ListTileLeading(child: widget.leading),
              ),
              Expanded(
                child: ListTileBody(
                    title: widget.title, subtitle: widget.subtitle),
              ),
              Flexible(
                flex: 0,
                child: ListTileTrailing(child: widget.trailing),
              ),
            ],
          ),
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
        margin: const EdgeInsets.symmetric(horizontal: 8),
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
