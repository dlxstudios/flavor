import 'package:flavor/components/card.dart';
import 'package:flavor/components/refactor_components.dart';
import 'package:flavor/components/tiles.dart';
import 'package:flavor/models/section.dart';
import 'package:flutter/material.dart';

class FlavorGrid extends StatelessWidget {
  final List<SectionItem> items;

  final int crossAxisCountSmall;
  final int crossAxisCountMed;
  final int crossAxisCountLarge;

  const FlavorGrid({
    Key? key,
    required this.items,
    this.crossAxisCountSmall = 2,
    this.crossAxisCountMed = 4,
    this.crossAxisCountLarge = 6,
  }) : super(key: key);

  static fromJson(Map<String, dynamic> json) {
    return FlavorGrid(
      items: json['name'],
      crossAxisCountSmall: json[''],
      crossAxisCountMed: json[''],
      crossAxisCountLarge: json[''],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return OrientationBuilder(builder: (context, ori) {
        var width = size.maxWidth;
        // ignore: unused_local_variable
        var height = size.maxHeight;

        var med = width > 760;
        var large = width > 1200;
        var crossAxisCount = large
            ? crossAxisCountLarge
            : med
                ? crossAxisCountMed
                : crossAxisCountSmall;

        return GridView.builder(
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemCount: items.length,
          itemBuilder: (context, indx) {
            SectionItem sectionItem = items[indx];
            return FlavorCard.fromFlavorItem(sectionItem);
          },
        );
      });
    });
  }
}

class FlavorPageGrid extends StatefulWidget {
  final double? listItemExtent;
  final List<SectionItem>? items;

  const FlavorPageGrid({Key? key, this.listItemExtent, this.items})
      : super(key: key);
  @override
  _FlavorPageGridState createState() => _FlavorPageGridState();
}

class _FlavorPageGridState extends State<FlavorPageGrid> {
  @override
  Widget build(BuildContext context) {
    return FlavorGrid(
      items: widget.items!,
    );
  }
}

class FlavorLayoutGrid extends StatelessWidget {
  static builder() {}

  final ScrollController? controller;
  final EdgeInsets? padding;
  final int? itemCount;
  final bool? shrinkWrap;
  final SliverGridDelegate? gridDelegate;
  final double? childAspectRatio;
  final Widget Function(BuildContext context, int index)? itemBuilder;

  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final int? crossAxisCount;
  final double? borderRadius;

  final void Function(int index)? onTap;

  final Widget? emptyState;
  final DecorationImage Function(int index)? onbackgoundImage;
  final Widget Function(int index)? onHeader;
  final Widget Function(int index)? onBody;
  final Widget Function(int index)? onFooter;
  final FlavorCardTileLayout tileCardLayout;

  final Object? Function(int index)? onHeroTag;

  const FlavorLayoutGrid({
    Key? key,
    this.controller,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.itemCount = 0,
    this.shrinkWrap = true,
    this.gridDelegate,
    this.childAspectRatio = 1.0,
    this.itemBuilder,
    this.crossAxisSpacing = 20,
    this.mainAxisSpacing = 20,
    this.crossAxisCount = 1,
    this.onTap,
    this.emptyState,
    this.onbackgoundImage,
    this.onHeader,
    this.onBody,
    this.onFooter,
    this.borderRadius = 16,
    this.tileCardLayout = FlavorCardTileLayout.stacked,
    this.onHeroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return emptyState ?? DefaultEmptyState();
    }
    return GridView.builder(
      padding: padding,
      controller: controller,
      itemCount: itemCount,
      shrinkWrap: true,
      gridDelegate: gridDelegate ??
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount!,
            crossAxisSpacing: crossAxisSpacing!,
            mainAxisSpacing: mainAxisSpacing!,
            childAspectRatio: childAspectRatio!,
          ),
      itemBuilder: itemBuilder ??
          (BuildContext context, int index) {
            // print('onHeroTag $onHeroTag');

            return FlavorCardTile(
              padding: EdgeInsets.all(0),
              heroTag: onHeroTag != null ? onHeroTag!(index) : null,
              cardTileLayout: tileCardLayout,
              onTap: onTap != null ? () => onTap!(index) : null,
              borderRadius: borderRadius!,
              // decorationImage: onbackgoundImage!(index),
              // header: onHeader != null ? onHeader!(index) : null,
              body: onBody != null ? onBody!(index) : null,
              // footer: onFooter != null ? onFooter!(index) : null,
            );
          },
    );
  }
}

class DefaultEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlavorText.bodyText1(context, 'No Items'),
      ),
    );
  }
}
