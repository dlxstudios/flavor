import 'package:flutter/material.dart';

class ClayContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Color? parentColor;
  final Color? surfaceColor;
  final double? spread;
  final Widget? child;
  final double? borderRadius;
  final BorderRadius? customBorderRadius;
  final CurveType? curveType;
  final int? depth;
  final bool? emboss;
  final BoxDecoration? decoration;
  final BoxConstraints? contraints;
  final EdgeInsetsGeometry? padding;
  ClayContainer({
    this.child,
    this.height,
    this.width,
    this.color,
    this.surfaceColor,
    this.parentColor,
    this.spread,
    this.borderRadius,
    this.customBorderRadius,
    this.curveType,
    this.depth,
    this.emboss,
    this.decoration,
    this.contraints,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    final double? heightValue = height == null ? null : height;
    final double? widthValue = width == null ? null : width;
    final int? depthValue = depth == null ? 20 : depth;
    // Color colorValue = color == null ? Color(0xFFf0f0f0) : color;
    Color? colorValue = color == null ? Theme.of(context).canvasColor : color;
    final Color? parentColorValue =
        parentColor == null ? colorValue : parentColor;
    final Color? surfaceColorValue =
        surfaceColor == null ? colorValue : surfaceColor;
    final double? spreadValue = spread == null ? 6 : spread;
    final bool? embossValue = emboss == null ? false : emboss;
    BorderRadius borderRadiusValue = borderRadius == null
        ? BorderRadius.zero
        : BorderRadius.circular(borderRadius!);

    if (customBorderRadius != null) {
      borderRadiusValue = customBorderRadius!;
    }
    final CurveType? curveTypeValue =
        curveType == null ? CurveType.none : curveType;

    List<BoxShadow> shadowList = [
      BoxShadow(
          color: _getAdjustColor(parentColorValue!,
              embossValue != null ? 0 - depthValue! : depthValue),
          offset: Offset(0 - spreadValue!, 0 - spreadValue),
          blurRadius: spreadValue),
      BoxShadow(
          color: _getAdjustColor(parentColorValue,
              embossValue != null ? depthValue : 0 - depthValue!),
          offset: Offset(spreadValue, spreadValue),
          blurRadius: spreadValue)
    ];

    if (embossValue != null) shadowList = shadowList.reversed.toList();
    if (embossValue != null)
      colorValue = _getAdjustColor(colorValue!, 0 - depthValue! ~/ 2);
    if (surfaceColor != null) colorValue = surfaceColorValue;

    List<Color>? gradientColors;
    switch (curveTypeValue) {
      case CurveType.concave:
        gradientColors = _getConcaveGradients(colorValue, depthValue);
        break;
      case CurveType.convex:
        gradientColors = _getConvexGradients(colorValue, depthValue);
        break;
      case CurveType.none:
        gradientColors = _getFlatGradients(colorValue, depthValue);
        break;
      case null:
        break;
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      constraints: contraints,
      height: heightValue,
      width: widthValue,
      child: child,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadiusValue,
        color: colorValue,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors!,
        ),
        boxShadow: shadowList,
      ).copyWith(
        image: decoration?.image,
        backgroundBlendMode: decoration?.backgroundBlendMode,
        border: decoration?.border,
        borderRadius: decoration?.borderRadius,
        boxShadow: decoration?.boxShadow,
        color: decoration?.color,
        gradient: decoration?.gradient,
        shape: decoration?.shape,
      ),
      // decoration: decoration,
    );
  }

  Color _getAdjustColor(Color baseColor, amount) {
    Map colors = {
      "red": baseColor.red,
      "green": baseColor.green,
      "blue": baseColor.blue
    };
    colors = colors.map((key, value) {
      if (value + amount < 0) return MapEntry(key, 0);
      if (value + amount > 255) return MapEntry(key, 255);
      return MapEntry(key, value + amount);
    });
    return Color.fromRGBO(colors["red"], colors["green"], colors["blue"], 1);
  }

  List<Color> _getConcaveGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, 0 - depth),
      _getAdjustColor(baseColor, depth),
    ];
  }

  List<Color> _getConvexGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, depth),
      _getAdjustColor(baseColor, 0 - depth),
    ];
  }

  List<Color> _getFlatGradients(baseColor, depth) {
    return [
      baseColor,
      baseColor,
    ];
  }
}

class ClayText extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color? parentColor;
  final Color? textColor;
  final TextStyle? style;
  final double? spread;
  final int? depth;
  final double? size;
  final bool? emboss;

  ClayText(
    this.text, {
    this.parentColor,
    this.textColor,
    this.color,
    this.spread,
    this.depth,
    this.style,
    this.size,
    this.emboss,
  });

  @override
  Widget build(BuildContext context) {
    final int? depthValue = depth == null ? 40 : depth;
    print(depthValue);
    // Color colorValue = color == null ? Color(0xFFf0f0f0) : color;
    Color? colorValue =
        color == null ? Theme.of(context).scaffoldBackgroundColor : color;
    final Color? outerColorValue =
        parentColor == null ? colorValue : parentColor;
    double? fontSizeValue = size == null ? 14 : size;

    // final TextStyle styleValue =
    //     style == null ? Theme.of(context).textTheme.button : style;
    final TextStyle? styleValue = style == null ? TextStyle() : style;
    fontSizeValue =
        styleValue!.fontSize != null ? styleValue.fontSize : fontSizeValue;

    final double? spreadValue =
        spread == null ? _getSpread(fontSizeValue) : spread;
    final bool? embossValue = emboss == null ? false : emboss;

    List<Shadow> shadowList = [
      Shadow(
          color: _getAdjustColor(outerColorValue!,
              embossValue != null ? 0 - depthValue! : depthValue),
          offset: Offset(0 - spreadValue! / 2, 0 - spreadValue / 2),
          blurRadius: spreadValue),
      Shadow(
          color: _getAdjustColor(outerColorValue,
              embossValue != null ? depthValue : 0 - depthValue!),
          offset: Offset(spreadValue / 2, spreadValue / 2),
          blurRadius: spreadValue)
    ];

    if (embossValue != null) shadowList = shadowList.reversed.toList();
    if (embossValue != null)
      colorValue = _getAdjustColor(colorValue!, 0 - depthValue!);
    if (textColor != null) colorValue = textColor;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: text,
          style: styleValue.copyWith(
            color: colorValue,
            shadows: shadowList,
            fontSize: fontSizeValue,
          )
          // style: Theme.of(context)
          //     .textTheme
          //     .headline1
          //     .copyWith(
          //       fontSize: fontSizeValue,
          //       color: colorValue,
          //       shadows: shadowList,
          //     )
          //     .merge(styleValue),
          ),
    );

    // return Text(text,
    //     style: styleValue.copyWith(
    //       color: colorValue,
    //       shadows: shadowList,
    //       fontSize: fontSizeValue,
    //     ));
  }

  Color _getAdjustColor(Color baseColor, amount) {
    Map colors = {
      "red": baseColor.red,
      "green": baseColor.green,
      "blue": baseColor.blue
    };
    colors = colors.map((key, value) {
      if (value + amount < 0) return MapEntry(key, 0);
      if (value + amount > 255) return MapEntry(key, 255);
      return MapEntry(key, value + amount);
    });
    return Color.fromRGBO(colors["red"], colors["green"], colors["blue"], 1);
  }

  double _getSpread(base) {
    double calculated = (base / 10).floor().toDouble();
    return calculated == 0 ? 1 : calculated;
  }
}

enum CurveType { concave, convex, none }

///
///
///
///
/// `
/// var button = ClayButton(
///   onTap: () {},
/// );
/// \n
/// ClayButton(
///   onTap: () {},
///   child: Icon(Icons.record_voice_over),
/// ),
/// ClayButton(
///   borderRadius: 16,
///   onTap: () {},
///   text: 'Icon(Icons.record_voice_over)',
/// )
/// `
class ClayButton extends StatefulWidget {
  final String? text;
  final Widget? child;
  final bool? emboss;
  final int? depth;

  final double? borderRadius;

  final void Function()? onTap;
  final BoxConstraints? constraints;

  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;

  final Color? parentColor;

  final Color? surfaceColor;

  final double? spread;

  final Color? color;

  const ClayButton({
    Key? key,
    this.text,
    this.child,
    this.emboss = false,
    this.borderRadius = 0,
    this.onTap,
    this.constraints = const BoxConstraints(minWidth: 4, minHeight: 4),
    // this.padding = const EdgeInsets.all(12.0),
    this.padding,
    this.depth,
    this.decoration,
    this.parentColor,
    this.surfaceColor,
    this.spread,
    this.color,
  }) : super(key: key);

  @override
  _ClayButtonState createState() => _ClayButtonState();
}

class _ClayButtonState extends State<ClayButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      contraints: BoxConstraints(
        minHeight: 50,
        minWidth: 50,
        maxHeight: double.infinity,
        maxWidth: double.infinity,
      ),
      decoration: widget.decoration,
      depth: widget.depth,
      emboss: widget.emboss,
      borderRadius: widget.borderRadius,
      color: widget.color,
      surfaceColor: widget.surfaceColor,
      parentColor: widget.parentColor,
      spread: widget.spread,
      padding: widget.padding != null ? widget.padding : EdgeInsets.all(8.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        // elevation: 6,
        color: Colors.transparent,
        borderRadius: widget.borderRadius != null
            ? BorderRadius.circular(widget.borderRadius!)
            : BorderRadius.zero,
        child: InkWell(
          onHover: (value) => setState(() => _hovered = value),
          splashColor: Theme.of(context).splashColor.withOpacity(.7),
          onTap: widget.onTap,
          child: Container(
            constraints: widget.constraints,
            // padding:
            //     widget.padding != null ? widget.padding : EdgeInsets.all(8.0),
            child: widget.text != null ? ClayText(widget.text) : widget.child,
          ),
        ),
      ),
    );
  }
}

enum ClayTileCardLayout { stacked, seperated }

class ClayTileCard extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Widget? footer;

  final String? text;
  final Widget? child;
  final bool? emboss;
  final int? depth;

  final double? borderRadius;

  final void Function()? onTap;
  final BoxConstraints? constraints;

  final EdgeInsetsGeometry? padding;

  final DecorationImage? backgroundImage;

  final ClayTileCardLayout? clayTileCardLayout;

  final Object? heroTag;

  const ClayTileCard({
    Key? key,
    this.header,
    this.body,
    this.footer,
    this.text,
    this.child,
    this.emboss,
    this.depth,
    this.borderRadius,
    this.onTap,
    this.constraints,
    this.padding,
    this.backgroundImage,
    this.clayTileCardLayout = ClayTileCardLayout.stacked,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _final;

    switch (clayTileCardLayout) {
      case ClayTileCardLayout.stacked:
        _final = stackedLayout();
        break;
      case ClayTileCardLayout.seperated:
        _final = seperatedLayout();
        break;
      default:
        _final = Container(
          child: Center(
            child: Text('No layout chosen'),
          ),
        );
    }
// !not working
    // _final = heroTag != null
    //     ? Hero(
    //         tag: heroTag,
    //         child: _final,
    //       )
    //     : _final;

    // print('onHeroTag $heroTag');

    return _final;
  }

  Widget seperatedLayout() {
    final List<Widget> _childrenSeperated = [];

    if (header != null) {
      _childrenSeperated.add(Flexible(
        flex: 0,
        child: Container(
          // color: Colors.green,
          // width: double.infinity,
          // height: double.infinity,
          child: header,
        ),
      ));
    }

    // if (body != null) {
    //   print('body');
    //   _childrenSeperated.add(Flexible(
    //     flex: 1,
    //     child: Container(
    //         color: Colors.green,
    //         width: double.infinity,
    //         height: double.infinity,
    //         child: body),
    //   ));
    // }

    if (body != null) {
      _childrenSeperated.add(Expanded(
        flex: 1,
        // color: Colors.amber,
        child: Container(
          // color: Colors.green,
          width: double.infinity,
          height: double.infinity,
          child: ClayButton(
            decoration: BoxDecoration(image: backgroundImage),
            // decoration: BoxDecoration(
            //     image: backgroundImage,
            //     borderRadius: BorderRadius.all(Radius.circular(80))),
            constraints: constraints,
            depth: depth,
            emboss: emboss,
            text: text,
            borderRadius: borderRadius,
            onTap: onTap,
            child: body,
            padding: EdgeInsets.all(0),
          ),
        ),
      ));
    }

    if (footer != null) {
      _childrenSeperated.add(Flexible(
        flex: 0,
        child: footer != null
            ? Container(
                // color: Colors.yellow,
                // width: double.infinity,
                // height: double.infinity,
                child: footer)
            : Container(),
      ));
    }

    print(_childrenSeperated);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _childrenSeperated,
    );
  }

  Widget stackedLayout() {
    final List<Widget> _childrenStacked = [];

    if (header != null) {
      _childrenStacked.add(Flexible(
        flex: 1,
        child: header!,
      ));
    }

    if (body != null) {
      _childrenStacked.add(Expanded(
        // flex: 1,
        child: Container(
          // color: Colors.green,
          // width: double.infinity,
          // height: double.infinity,
          child: body,
        ),
      ));
    }

    if (footer != null) {
      _childrenStacked.add(
        Flexible(
          flex: 0,
          child: Container(
              // color: Colors.yellow,
              // width: double.infinity,
              // height: double.infinity,
              child: footer),
        ),
      );
    }

    return ClayButton(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(image: backgroundImage),
      constraints: constraints,
      depth: depth,
      emboss: emboss,
      text: text,
      borderRadius: borderRadius,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _childrenStacked,
      ),
    );
  }
}
