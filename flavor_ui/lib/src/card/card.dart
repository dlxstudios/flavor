import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/material.dart' show GridTileBar;
import 'package:flutter/widgets.dart';

enum CardTileLayout { stacked, seperated }

class CardTile extends StatelessWidget {
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

  final CardTileLayout? containerTileLayout;

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

  const CardTile({
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
    this.containerTileLayout = CardTileLayout.stacked,
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
    return ListTile(
      title: footerTitle != null ? Text(footerTitle!) : null,
      subtitle: footerSubtitle != null ? Text(footerSubtitle!) : null,
      leading: footerLeading,
      trailing: footerTrailing,
    );
  }

  Widget _buildHeaderListTile() {
    return ListTile(
      title: headerTitle != null ? Text(headerTitle!) : null,
      subtitle: headerSubtitle != null ? Text(headerSubtitle!) : null,
      leading: headerLeading,
      trailing: headerTrailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _final;

    switch (containerTileLayout) {
      case CardTileLayout.stacked:
        return stackedLayout(context);
      case CardTileLayout.seperated:
        return seperatedLayout();

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

    if (header != null) {
      _childrenSeperated.add(header!);
    }

    _childrenSeperated.add(
      Expanded(
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
            GestureDetector(
              onTap: onTap,
            ),
          ],
        ),
      ),
    );

    if (footerExist) {
      _childrenSeperated.add(_buildFooterListTile());
    }

    if (footer != null) {
      _childrenSeperated.add(footer!);
    }

    return CardBox(
      borderRadius: borderRadius,
      color: color,
      padding: padding,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: _childrenSeperated,
      ),
    );
  }

  Widget stackedLayout(BuildContext context) {
    final List<Widget> _childrenStacked = [];

    if (header != null) {
      _childrenStacked.add(
        Positioned(
          top: 0,
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
        // child: Container(),
        child: GridTileBar(
          title: headerTitle != null ? FlavorText(headerTitle!) : null,
          subtitle: headerSubtitle != null ? FlavorText(headerSubtitle!) : null,
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
        // child: Container(),
        child: GridTileBar(
          leading: footerLeading,
          subtitle: footerTitle != null ? FlavorText(footerTitle!) : null,
          title: footerSubtitle != null ? FlavorText(footerSubtitle!) : null,
        ),
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
              decoration: const BoxDecoration(),
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
