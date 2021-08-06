import 'package:flavor/theme/clay/clay.dart';
import 'package:flavor/components/refactor_components.dart';
import 'package:flutter/material.dart';

class ClayTileHeader extends StatelessWidget {
  final String? title;
  const ClayTileHeader({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return FlavorText.headline4(
    //   context,
    //   '$title',
    //   style: Theme.of(context)
    //       .textTheme
    //       .headline4!
    //       .copyWith(fontWeight: FontWeight.bold),
    // );
    return title != null
        ? Container(
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24.0, top: 8, bottom: 8, right: 24),
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

                  // Flexible(
                  //   child: ClayText(
                  //     '$title',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .headline4
                  //         .copyWith(fontWeight: FontWeight.bold),
                  //   ),
                  // ),

                  // Text(
                  //   '$title',
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .headline4
                  //       .copyWith(fontWeight: FontWeight.bold),
                  // )
                ],
              ),
            ),
          )
        : Container();
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

class ClayLayoutGrid extends StatelessWidget {
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
  final ClayTileCardLayout? clayTileCardLayout;

  final Object Function(int index)? onHeroTag;

  const ClayLayoutGrid({
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
    this.clayTileCardLayout = ClayTileCardLayout.stacked,
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

            return ClayTileCard(
              // depth: 0,
              padding: EdgeInsets.all(0),
              heroTag: onHeroTag != null ? onHeroTag!(index) : null,
              clayTileCardLayout: clayTileCardLayout,
              onTap: onTap != null ? () => onTap!(index) : null,
              borderRadius: borderRadius,
              backgroundImage:
                  onbackgoundImage != null ? onbackgoundImage!(index) : null,
              header: onHeader != null ? onHeader!(index) : null,
              body: onBody != null ? onBody!(index) : null,
              footer: onFooter != null ? onFooter!(index) : null,
            );
          },
    );
  }
}

class ClayAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _ClayAppBarState createState() => _ClayAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 54);
}

class _ClayAppBarState extends State<ClayAppBar> {
  @override
  Widget build(BuildContext context) {
    final BoxConstraints unadjustedConstraints = const BoxConstraints(
      minWidth: kMinInteractiveDimension,
      minHeight: kMinInteractiveDimension,
      maxHeight: kMinInteractiveDimension,
      maxWidth: kMinInteractiveDimension,
    );

    var color = Theme.of(context).accentColor;

    return ClayContainer(
      contraints: unadjustedConstraints,
      // depth: 4,
      depth: 0,
      // surfaceColor: Theme.of(context).accentColor,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 0,
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // _renderLeading(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClayButton(
                  constraints: unadjustedConstraints,
                  // text: 'flavor',
                  padding: EdgeInsets.all(0),
                  borderRadius: 16,
                  onTap: () {
                    // print('openDrawer');
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(Icons.menu),
                ),
              ],
            ),

            SizedBox(
              width: 16,
            ),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Title')],
              ),
            ),
            SizedBox(
              width: 16,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClayButton(
                  constraints: unadjustedConstraints,
                  // text: 'flavor',
                  padding: EdgeInsets.all(0),
                  borderRadius: 16,
                  onTap: () {
                    // print('openDrawer');
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(Icons.person),
                ),
              ],
            ),

            // Spacer(),
            // _renderBody(),
            // _renderTrailing(),
          ],
        ),
      ),
    );
  }
}
