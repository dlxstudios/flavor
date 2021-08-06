import 'package:flavor/components/refactor_components.dart';
import 'package:flavor/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// !!! OLD. will delete in favor of FlavorCardTile
class ThumbTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? cover;

  final DataItem? data;

  final double borderRadius;

  final double elevation;
  final Widget? child;

  final void Function()? onTap;
  final BoxConstraints? constraints;

  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;

  final Color? color;

  final double? height;
  final double? width;

  const ThumbTile({
    Key? key,
    this.title,
    this.subtitle,
    this.cover,
    this.borderRadius = 0.0,
    this.elevation = 4.0,
    this.data,
    this.child,
    this.onTap,
    this.constraints = const BoxConstraints(minWidth: 4, minHeight: 4),
    this.padding,
    this.decoration,
    this.color,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      constraints: constraints,
      height: height,
      width: width,
      // padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ).copyWith(
        image: decoration?.image,
        backgroundBlendMode: decoration?.backgroundBlendMode,
        border: decoration?.border,
        borderRadius: decoration?.borderRadius,
        boxShadow: decoration?.boxShadow,
        gradient: decoration?.gradient,
        shape: decoration?.shape,
        color: decoration?.color,
      ),
      child: Material(
        elevation: elevation,
        color: decoration?.image != null
            ? Colors.transparent
            : decoration?.color ?? color,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        child: child != null
            ? child
            : Stack(
                fit: StackFit.expand,
                children: [
                  // cover ?? Container(),
                  InkWell(
                    // onHover: (value) => setState(() => _hovered = value),
                    splashColor: Theme.of(context).splashColor.withOpacity(.4),
                    onTap: onTap,
                    child: (title != null || subtitle != null) && cover != null
                        ? GridTile(
                            footer: GridTileBar(
                              title: this.title == null
                                  ? null
                                  : Text(
                                      title!,
                                      style: TextStyle(
                                        shadows: [
                                          BoxShadow(
                                              blurRadius: 1,
                                              color:
                                                  Colors.black.withOpacity(.25),
                                              offset: Offset(-2, 1),
                                              spreadRadius: 3)
                                        ],
                                        //  fontSize: 16,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              subtitle: this.subtitle == null
                                  ? null
                                  : Text(
                                      subtitle!,
                                      style: TextStyle(
                                        shadows: [
                                          BoxShadow(
                                              blurRadius: 2,
                                              color:
                                                  Colors.black.withOpacity(.2),
                                              offset: Offset(-2, 1),
                                              spreadRadius: 6)
                                        ],
                                      ),
                                    ),
                            ),
                            // child: this.cover != null
                            //     ? CachedNetworkImage(
                            //         fit: BoxFit.cover,
                            //         imageUrl: "${this.cover}",
                            //         placeholder: (context, url) => ShimmerPlaceholder(),
                            //         errorWidget: (context, url, error) => Icon(Icons.error),
                            //       )
                            //     : Container(),
                            // child: FlutterLogo(
                            //     // colors: Colors.amber,
                            //     ),
                            child: cover ?? Container(),
                          )
                        : Container(),
                  ),
                ],
              ),
      ),
    );

    // return Material(
    //   clipBehavior: Clip.antiAlias,
    //   // elevation: 6,
    //   color: Colors.transparent,
    //   borderRadius: borderRadius != null
    //       ? BorderRadius.circular(borderRadius)
    //       : BorderRadius.zero,
    //   child: InkWell(
    //     // onHover: (value) => setState(() => _hovered = value),
    //     splashColor: Theme.of(context).splashColor.withOpacity(.7),
    //     onTap: onTap,
    //     child: GridTile(
    //       footer: GridTileBar(
    //         title: this.title != null
    //             ? Text(
    //                 '${this.title}x',
    //                 // style: TextStyle(
    //                 //   shadows: [
    //                 //     BoxShadow(
    //                 //         blurRadius: 2,
    //                 //         color: Colors.black.withOpacity(.5),
    //                 //         offset: Offset(-2, 1),
    //                 //         spreadRadius: 6)
    //                 //   ],
    //                 //   //  fontSize: 16,
    //                 //   fontWeight: FontWeight.bold,
    //                 // ),
    //                 maxLines: 1,
    //                 overflow: TextOverflow.ellipsis,
    //               )
    //             : null,
    //         subtitle: this.subtitle != null
    //             ? Text("  ${this.subtitle}",
    //                 style: TextStyle(
    //                   shadows: [
    //                     BoxShadow(
    //                         blurRadius: 2,
    //                         color: Colors.black.withOpacity(.5),
    //                         offset: Offset(-2, 1),
    //                         spreadRadius: 6)
    //                   ],
    //                 ))
    //             : null,
    //       ),
    //       // child: this.cover != null
    //       //     ? CachedNetworkImage(
    //       //         fit: BoxFit.cover,
    //       //         imageUrl: "${this.cover}",
    //       //         placeholder: (context, url) => ShimmerPlaceholder(),
    //       //         errorWidget: (context, url, error) => Icon(Icons.error),
    //       //       )
    //       //     : Container(),
    //       // child: FlutterLogo(
    //       //     // colors: Colors.amber,
    //       //     ),
    //       child: child != null ? child : Container(),
    //     ),
    //   ),
    // );

    // return Material(
    //   elevation: 6,
    //   animationDuration: Duration(milliseconds: 700),
    //   clipBehavior: Clip.antiAlias,
    //   borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
    //   child: GridTile(
    //     footer: GridTileBar(
    //       title: this.title != null
    //           ? Text(
    //               '${this.title}x',
    //               // style: TextStyle(
    //               //   shadows: [
    //               //     BoxShadow(
    //               //         blurRadius: 2,
    //               //         color: Colors.black.withOpacity(.5),
    //               //         offset: Offset(-2, 1),
    //               //         spreadRadius: 6)
    //               //   ],
    //               //   //  fontSize: 16,
    //               //   fontWeight: FontWeight.bold,
    //               // ),
    //               maxLines: 1,
    //               overflow: TextOverflow.ellipsis,
    //             )
    //           : null,
    //       subtitle: this.subtitle != null
    //           ? Text("  ${this.subtitle}",
    //               style: TextStyle(
    //                 shadows: [
    //                   BoxShadow(
    //                       blurRadius: 2,
    //                       color: Colors.black.withOpacity(.5),
    //                       offset: Offset(-2, 1),
    //                       spreadRadius: 6)
    //                 ],
    //               ))
    //           : null,
    //     ),
    //     // child: this.cover != null
    //     //     ? CachedNetworkImage(
    //     //         fit: BoxFit.cover,
    //     //         imageUrl: "${this.cover}",
    //     //         placeholder: (context, url) => ShimmerPlaceholder(),
    //     //         errorWidget: (context, url, error) => Icon(Icons.error),
    //     //       )
    //     //     : Container(),
    //     // child: FlutterLogo(
    //     //     // colors: Colors.amber,
    //     //     ),
    //     child: child != null ? child : Container(),
    //   ),
    // );
  }
}

enum FlavorCardTileLayout { stacked, seperated }

class FlavorCardTile extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Widget? footer;

  final String? text;
  final Widget? child;
  final bool? emboss;
  final int? depth;

  final double borderRadius;

  final void Function()? onTap;
  final BoxConstraints? constraints;

  final EdgeInsetsGeometry? padding;

  final FlavorCardTileLayout? cardTileLayout;

  final Object? heroTag;

  final String? backgroundImage;
  final BoxFit backgroundImageBoxFit;

  final Color? color;

  final String? headerTitle;
  final String? headerSubtitle;
  final String? footerTitle;
  final String? footerSubtitle;
  final Widget? footerLeading;
  final Widget? headerLeading;
  final Widget? footerTrailing;
  final Widget? headerTrailing;

  const FlavorCardTile({
    Key? key,
    this.header,
    this.body,
    this.footer,
    this.text,
    this.child,
    this.emboss,
    this.depth,
    this.borderRadius = 8,
    this.onTap,
    this.constraints,
    this.padding,
    this.backgroundImage,
    this.backgroundImageBoxFit = BoxFit.cover,
    this.cardTileLayout = FlavorCardTileLayout.stacked,
    this.heroTag,
    this.color,
    this.headerTitle,
    this.headerSubtitle,
    this.footerTitle,
    this.footerSubtitle,
    this.footerLeading,
    this.headerLeading,
    this.footerTrailing,
    this.headerTrailing,
  }) : super(key: key);

  bool get headerExist =>
      headerTitle != null ||
      headerSubtitle != null ||
      headerLeading != null ||
      headerTrailing != null;

  bool get footerExist =>
      footerTitle != null ||
      footerSubtitle != null ||
      footerLeading != null ||
      footerTrailing != null;

  Widget _buildFooterListTile() {
    return FlavorListTile(
      title: footerTitle,
      subtitle: footerSubtitle,
      leading: footerLeading,
      trailing: footerTrailing,
    );
  }

  Widget _buildHeaderListTile() {
    return FlavorListTile(
      title: headerTitle,
      subtitle: headerSubtitle,
      leading: headerLeading,
      trailing: headerTrailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _final;

    switch (cardTileLayout) {
      case FlavorCardTileLayout.stacked:
        _final = stackedLayout(context);
        break;
      case FlavorCardTileLayout.seperated:
        _final = seperatedLayout();
        break;
      default:
        _final = stackedLayout(context);
      // _final = Container(
      //   child: Center(
      //     child: Text('No layout chosen'),
      //   ),
      // );
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

    if (headerExist) {
      _childrenSeperated.add(_buildHeaderListTile());
    }

    _childrenSeperated.add(
      Expanded(
        child: Card(
          elevation: 0,
          margin: EdgeInsets.all(0),
          shape: Border.all(width: 0, color: Colors.transparent),
          color: color,
          child: Stack(
            fit: StackFit.expand,
            children: [
              backgroundImage != null
                  ? Container(
                      color: color,
                      child: Image.network(
                        backgroundImage!,
                        fit: backgroundImageBoxFit,
                      ),
                    )
                  : Container(),
              body != null ? body! : Container(),
              Material(
                elevation: 0,
                borderOnForeground: true,
                borderRadius: BorderRadius.zero,
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (footerExist) {
      _childrenSeperated.add(_buildFooterListTile());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _childrenSeperated,
    );
  }

  Widget stackedLayout(BuildContext context) {
    final List<Widget> _childrenStacked = [];

    if (header != null) {
      _childrenStacked.add(
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: header!,
        ),
      );
    } else if (headerExist) {
      _childrenStacked.add(Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: GridTileBar(
          title: headerTitle != null
              ? FlavorText.bodyText1(context, headerTitle!)
              : null,
          subtitle: headerSubtitle != null
              ? FlavorText.caption(context, headerSubtitle!)
              : null,
        ),
      ));
    }

    if (footer != null) {
      _childrenStacked.add(
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: footer!,
        ),
      );
    }

    if (footerExist && footer == null) {
      _childrenStacked.add(Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: GridTileBar(
          leading: footerLeading,
          subtitle: footerTitle != null
              ? FlavorText.caption(context, footerTitle!)
              : null,
          title: footerSubtitle != null
              ? FlavorText.bodyText2(context, footerSubtitle!)
              : null,
        ),
      ));
    }

    _childrenStacked.add(
      Card(
        shape: Border.all(width: 0, color: Colors.transparent),
        color: color,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              // color: color,
              child: backgroundImage != null
                  ? Image.network(
                      backgroundImage!,
                      fit: backgroundImageBoxFit,
                    )
                  : body,
            ),
            Material(
              borderRadius: BorderRadius.zero,
              elevation: 0,
              borderOnForeground: true,
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: [..._childrenStacked.reversed],
    );
  }
}

class FlavorListTile extends StatelessWidget {
  const FlavorListTile({
    Key? key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: title != null
          ? FlavorText.headline6(
              context,
              title!,
              maxLines: 1,
            )
          : null,
      subtitle: subtitle != null
          ? FlavorText.bodyText1(
              context,
              subtitle!,
              maxLines: 1,
            )
          : null,
      leading: leading != null
          ? AspectRatio(
              aspectRatio: 1,
              child: leading,
            )
          : null,
      trailing: trailing != null
          ? AspectRatio(aspectRatio: 1, child: trailing!)
          : null,
    );
  }
}

class FlavorListTileHeader extends StatelessWidget {
  final String? title;

  final Function? onTapTrailing;

  final EdgeInsets? contentPadding;

  final TextStyle? titleStyle;

  const FlavorListTileHeader({
    Key? key,
    this.title,
    this.onTapTrailing,
    this.contentPadding,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextOneLine(
        title!,
        style: titleStyle ?? Theme.of(context).textTheme.headline4,
      ),
      contentPadding: contentPadding != null
          ? contentPadding
          : EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      trailing: DLXElevatedButton(
        text: 'MORE',
        onPressed: onTapTrailing != null
            ? () => onTapTrailing!(key)
            : () {
                print('onTap of $key not implimented');
              },
      ),
    );
  }
}

class ShimmerPlaceholder extends StatelessWidget {
  final Widget child;

  const ShimmerPlaceholder({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Shimmer.fromColors(
          baseColor: Theme.of(context).primaryColorDark.withOpacity(.9),
          highlightColor: Theme.of(context).primaryColorDark.withOpacity(.6),
          child: Container(
            height: size.maxHeight,
            width: size.maxWidth,
            color: Colors.black.withOpacity(.8),
          )
          // child: child != null ? child : null),
          );
    });
  }
}
