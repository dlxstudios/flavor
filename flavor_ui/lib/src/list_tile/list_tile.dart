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
    Theme themeStateController;
    Duration _duration;
    try {
      themeStateController = Theme.of(context).theme;
      _selectedColor = widget.selectedColor ??
          themeStateController.theme.primaryColor!.value;
      _duration = Duration(milliseconds: themeStateController.theme.duration);
    } catch (e) {
      _selectedColor = widget.selectedColor ?? const Color(0xFF333333);
      _duration = const Duration(milliseconds: 300);
    }

    _color = widget.color;

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
        duration: _duration,
        color: !selected ? _color ?? m.Colors.transparent : _selectedColor,
        // duration: defaultThemeDuration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: _ListTile(
            leading: widget.leading,
            title: widget.title,
            subtitle: widget.subtitle,
            trailing: widget.trailing,
          ),
          // child: Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Flexible(
          //       flex: 0,
          //       child: ListTileLeading(child: widget.leading),
          //     ),
          //     Expanded(
          //       child: ListTileBody(
          //           title: widget.title, subtitle: widget.subtitle),
          //     ),
          //     Flexible(
          //       flex: 0,
          //       child: ListTileTrailing(child: widget.trailing),
          //     ),
          //   ],
          // ),
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
          // height: size.maxHeight,
          // width: size.maxWidth,
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

class _ListTile extends StatelessWidget {
  const _ListTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
  }) : super(key: key);

  final Widget? leading;

  final Widget? title;

  ///
  final Widget? subtitle;

  ///
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    BoxDecoration? decoration;

    final EdgeInsetsDirectional padding = EdgeInsetsDirectional.only(
      start: leading != null ? 8.0 : 16.0,
      end: trailing != null ? 8.0 : 16.0,
    );

    return Container(
      padding: padding,
      decoration: decoration,
      height: (title != null && subtitle != null) ? 68.0 : 48.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (leading != null)
            Padding(
                padding: const EdgeInsetsDirectional.only(end: 8.0),
                child: leading),
          if (title != null && subtitle != null)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title!,
                  subtitle!,
                ],
              ),
            )
          else if (title != null || subtitle != null)
            Expanded(
              child: title ?? subtitle!,
            ),
          if (trailing != null)
            Padding(
                padding: const EdgeInsetsDirectional.only(start: 8.0),
                child: trailing),
        ],
      ),
    );
  }
}
