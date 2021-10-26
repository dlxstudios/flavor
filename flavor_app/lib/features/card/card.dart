import 'package:flavor_app/features/list_tile/list_tile.dart';
import 'package:flutter/widgets.dart';

enum FlavorContainerTileLayout { stacked, seperated }

class FlavorContainerTile extends StatelessWidget {
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

  final FlavorContainerTileLayout? containerTileLayout;

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

  const FlavorContainerTile({
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
    this.containerTileLayout = FlavorContainerTileLayout.stacked,
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

    switch (containerTileLayout) {
      case FlavorContainerTileLayout.stacked:
        _final = stackedLayout(context);
        break;
      case FlavorContainerTileLayout.seperated:
        _final = seperatedLayout();
        break;
      default:
        _final = stackedLayout(context);
    }

    return _final;
  }

  Widget seperatedLayout() {
    final List<Widget> _childrenSeperated = [];

    if (headerExist) {
      _childrenSeperated.add(_buildHeaderListTile());
    }

    _childrenSeperated.add(
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          margin: const EdgeInsets.all(0),
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
              Container(
                // elevation: 0,
                // borderOnForeground: true,
                // borderRadius: BorderRadius.circular(borderRadius),
                // color: FlavorColors().transparent,
                clipBehavior: Clip.antiAlias,
                child: GestureDetector(
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

    return Container(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _childrenSeperated,
      ),
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
        child: Container(),
        // child: GridTileBar(
        //   title: headerTitle != null
        //       ? FlavorText.bodyText1(context, headerTitle!)
        //       : null,
        //   subtitle: headerSubtitle != null
        //       ? FlavorText.caption(context, headerSubtitle!)
        //       : null,
        // ),
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
        child: Container(),
        // child: GridTileBar(
        //   leading: footerLeading,
        //   subtitle: footerTitle != null
        //       ? FlavorText.caption(context, footerTitle!)
        //       : null,
        //   title: footerSubtitle != null
        //       ? FlavorText.bodyText2(context, footerSubtitle!)
        //       : null,
        // ),
      ));
    }

    _childrenStacked.add(
      Container(
        // shape: Border.all(width: 5, color: FlavorColors().red),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(borderRadius),
        // ),

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
            Container(
              // borderRadius: BorderRadius.circular(borderRadius),
              // elevation: 0,
              // borderOnForeground: true,
              // color: FlavorColors().transparent,
              clipBehavior: Clip.antiAlias,
              child: GestureDetector(
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
      // contentPadding: EdgeInsets.all(0),
      title: title != null
          ? Text(
              title!,
              maxLines: 1,
              // overflow: TextOverflow.ellipsis,
            )
          : null,
      subtitle: subtitle != null
          ? Text(
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
      title: Text(
        title!,
        // style: titleStyle ?? Theme.of(context).textTheme.headline4,
      ),
      // title: TextOneLine(
      //   title!,
      //   // style: titleStyle ?? Theme.of(context).textTheme.headline4,
      // ),
      // contentPadding: contentPadding != null
      //     ? contentPadding
      //     : EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      // trailing: DLXElevatedButton(
      //   text: 'MORE',
      //   onPressed: onTapTrailing != null
      //       ? () => onTapTrailing!(key)
      //       : () {
      //           print('onTap of $key not implimented');
      //         },
      // ),
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
      return SizedBox(
        height: size.maxHeight,
        width: size.maxWidth,
        // color: FlavorColors().black.withOpacity(.8),

        // child: child != null ? child : null),
      );
    });
  }
}
