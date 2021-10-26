import 'package:flavor_app/features/card/card.dart';
import 'package:flavor_app/features/text/text.dart';
import 'package:flutter/material.dart';

class FlavorList extends StatelessWidget {
  final Axis scrollDirection;
  // Header
  final Widget Function(BuildContext context, int index)? builder;

  final String? headerTitle;
  final String? headerSubtitle;
  final String? footerTitle;
  final String? footerSubtitle;
  final Widget? footerLeading;
  final Widget? headerLeading;
  final Widget? footerTrailing;
  final Widget? headerTrailing;

  final ScrollController? controller;

  final String? backgroundImage;
  final double? aspectRatio;
  const FlavorList(
      {Key? key,
      this.itemCount,
      this.scrollDirection = Axis.vertical,
      this.headerTitle,
      this.headerSubtitle,
      this.footerTitle,
      this.footerSubtitle,
      this.footerLeading,
      this.headerLeading,
      this.footerTrailing,
      this.headerTrailing,
      this.controller,
      this.backgroundImage,
      this.aspectRatio,
      this.builder})
      : super(key: key);

  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('controller::$controller');

    if (itemCount == null) {
      return AspectRatio(
        aspectRatio: aspectRatio ?? 1.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: const FlavorContainerTile(
            //
            headerTitle: 'No Items',
          ),
        ),
      );
    }

    if (builder != null) {
      return ListView.builder(
        cacheExtent: 100,
        controller: controller,
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: scrollDirection,
        itemBuilder: (context, itemIndex) {
          return AspectRatio(
            // aspectRatio: .7,
            aspectRatio: aspectRatio ?? 1.0,
            child: builder!(context, itemIndex),
          );
        },
      );
    }

    return ListView.builder(
      cacheExtent: 100,
      controller: controller,
      shrinkWrap: true,
      itemCount: itemCount,
      scrollDirection: scrollDirection,
      itemBuilder: (context, itemIndex) {
        return AspectRatio(
          // aspectRatio: .7,
          aspectRatio: aspectRatio ?? 1.0,
          child: Container(
            padding: const EdgeInsets.all(0.0),
            child: FlavorContainerTile(
              backgroundImage: backgroundImage,
              containerTileLayout: FlavorContainerTileLayout.stacked,
              onTap: () {},
              //
              footerTitle: footerTitle,
              footerSubtitle: footerSubtitle,
              footerLeading: footerLeading,
              footerTrailing: footerTrailing,
              //
              headerTitle: headerTitle,
              headerSubtitle: headerSubtitle,
              headerLeading: headerLeading,
              headerTrailing: headerTrailing,
            ),
          ),
        );
      },
    );
  }
}

class FlavorTileSection extends StatelessWidget {
  final String? title;

  final Widget child;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const FlavorTileSection({
    Key? key,
    this.title,
    required this.child,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        title != null
            ? Flexible(
                flex: 0,
                child: FlavorTileHeader(
                  title: title,
                ),
              )
            : Container(),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}

class FlavorTileHeader extends StatelessWidget {
  final String? title;
  const FlavorTileHeader({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return title != null
        ? Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 8,
              bottom: 8,
              right: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: FlavorText.headline4(
                    context,
                    '$title',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
