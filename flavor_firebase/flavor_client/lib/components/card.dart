import 'package:flavor/components/tiles.dart';
import 'package:flavor/components/refactor_components.dart';
import 'package:flavor/models/models.dart';
import 'package:flavor/models/section.dart';
import 'package:flutter/material.dart';

class FlavorCard extends StatelessWidget {
  final EdgeInsets? padding;

  final bool? showHeader;
  final bool? showFooter;
  final bool? showCover;
  const FlavorCard({
    Key? key,
    this.itemAspectRatio = 1,
    this.cardAspectRatio = 1,
    this.onTap,
    this.imageUrl,
    this.padding = const EdgeInsets.all(8),
    this.showHeader = false,
    this.showFooter = false,
    this.showCover = false,
    this.headerTitleText,
    this.headerSubtitleText,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final double? itemAspectRatio;
  final double? cardAspectRatio;
  final GestureTapCallback? onTap;
  final String? imageUrl;
  final String? headerTitleText;
  final String? headerSubtitleText;
  final String? title;
  final String? subtitle;

  static fromFlavorItem(SectionItem sectionItem) {
    return FlavorCard(
      cardAspectRatio:
          sectionItem.cardAspectRatio != null ? sectionItem.cardAspectRatio : 1,
      title: sectionItem.title,
      subtitle: sectionItem.subtitle,
      headerSubtitleText: sectionItem.headerSubtitleText,
      headerTitleText: sectionItem.headerTitleText,
      imageUrl: sectionItem.cover,
      itemAspectRatio:
          sectionItem.itemAspectRatio != null ? sectionItem.itemAspectRatio : 1,
      key: sectionItem.key,
      onTap: sectionItem.onTap,
      padding:
          sectionItem.padding != null ? sectionItem.padding : EdgeInsets.all(8),
      showCover: sectionItem.showCover != null ? sectionItem.showCover : true,
      showFooter:
          sectionItem.showFooter != null ? sectionItem.showFooter : false,
      showHeader:
          sectionItem.showHeader != null ? sectionItem.showHeader : false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _showHeader = showHeader ?? headerTitleText != null;
    var _showFooter = showFooter ?? title != null;

    // print('_showFooter : $title');

    return Container(
      padding: padding,
      child: AspectRatio(
        aspectRatio: itemAspectRatio!,
        child: GridTile(
          child: imageUrl != null
              ? FlavorCardCover(
                  aspectRatio: .2,
                  imageUrl: imageUrl!,
                  onTap: onTap!,
                )
              : Container(),
          footer: _showFooter
              ? ListTile(
                  title: title != null ? TextOneLine(title!) : null,
                  subtitle: subtitle != null ? TextOneLine(subtitle!) : null,
                )
              : Container(),
          header: _showHeader
              ? ListTile(
                  title: headerTitleText != null
                      ? TextOneLine(headerTitleText!)
                      : null,
                  subtitle: headerSubtitleText != null
                      ? TextOneLine(headerSubtitleText!)
                      : null,
                )
              : Container(),
        ),
      ),
    );

    // return AspectRatio(
    //   aspectRatio: itemAspectRatio,
    //   child: Container(
    //     // width: 200,
    //     // height: 200,
    //     padding: EdgeInsets.all(8),
    //     child: Material(
    //       clipBehavior: Clip.antiAlias,
    //       borderRadius: BorderRadius.all(Radius.circular(8)),
    //       // color: Colors.amber,
    //       elevation: 4,
    //       child: Column(
    //         children: <Widget>[
    //           _showHeader
    //               ? Flexible(
    //                   child: ListTile(
    //                     title: headerTitleText != null
    //                         ? TextOneLine(headerTitleText)
    //                         : null,
    //                     subtitle: headerSubtitleText != null
    //                         ? TextOneLine(headerSubtitleText)
    //                         : null,
    //                   ),
    //                 )
    //               : Container(),
    //           Flexible(
    //             fit: FlexFit.tight,
    //             flex: 2,
    //             child: Container(
    //               width: double.infinity,
    //               height: double.infinity,
    //               color: Colors.deepPurpleAccent,
    //               child: FlavorCardCover(
    //                 // aspectRatio: .2,
    //                 imageUrl: imageUrl,
    //                 onTap: onTap,
    //               ),
    //             ),
    //           ),
    //           _showFooter
    //               ? Flexible(
    //                   child: ListTile(
    //                     title: title != null ? TextOneLine(title) : null,
    //                     subtitle:
    //                         subtitle != null ? TextOneLine(subtitle) : null,
    //                   ),
    //                 )
    //               : Container(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class FlavorCardCover extends StatelessWidget {
  final double? aspectRatio;
  final String? imageUrl;
  final EdgeInsets? padding;

  final GestureTapCallback? onTap;
  final double? borderRadius;

  const FlavorCardCover({
    Key? key,
    this.aspectRatio = 1,
    this.imageUrl,
    this.padding = const EdgeInsets.all(0),
    this.onTap,
    this.borderRadius = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: size.maxWidth,
      // height: size.maxHeight,
      // padding: padding,
      // color: Colors.purpleAccent,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius!),
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).backgroundColor,
        elevation: 3,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: FlavorImageBox(
                aspectRatio: aspectRatio!,
                imageUrl: imageUrl!,
              ),
            ),
            Material(
              elevation: 0,
              // color: Colors.grey.shade900,
              color: Colors.transparent,

              child: InkWell(
                onHover: (e) {},
                onTap: this.onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlavorImageBox extends StatefulWidget {
  final String? imageUrl;
  final double? aspectRatio;

  FlavorImageBox({
    this.imageUrl,
    this.aspectRatio,
  });

  @override
  _FlavorImageBoxState createState() => _FlavorImageBoxState();
}

class _FlavorImageBoxState extends State<FlavorImageBox> {
  bool? _showImage;

  @override
  void initState() {
    super.initState();

    _showImage = false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrl == null) {
      return Center(
          child: Text(
        '😢',
        style: TextStyle(fontSize: 50, color: Colors.white.withOpacity(.1)),
      ));
    }

    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //       image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
      // ),
      child: Image.network(
        widget.imageUrl ?? '',
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          // loadingProgress != null ? print(loadingProgresss) : null;
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, _, x) {
          return Center(
              child: ShimmerPlaceholder(
            child: Container(),
          ));
        },
      ),
    );

    // print(widget.imageUrl);
    // return Image.network(
    //   widget.imageUrl,
    //   fit: BoxFit.cover,
    //   alignment: Alignment.center,
    //   // loadingBuilder: (BuildContext context, Widget child,
    //   //     ImageChunkEvent loadingProgress) {
    //   //   // loadingProgress != null ? print(loadingProgresss) : null;
    //   //   if (loadingProgress == null) return child;
    //   //   return Center(
    //   //     child: CircularProgressIndicator(
    //   //       value: loadingProgress.expectedTotalBytes != null
    //   //           ? loadingProgress.cumulativeBytesLoaded /
    //   //               loadingProgress.expectedTotalBytes
    //   //           : null,
    //   //     ),
    //   //   );
    //   // },
    // errorBuilder: (context, _, x) {
    //   return Center(
    //       child: Text(
    //     '😢',
    //     style: TextStyle(fontSize: 50),
    //   ));
    // },
    //   frameBuilder: (context, child, frame, asyncLoaded) {
    //     return child;
    //   },
    // );

    return GestureDetector(
      onTap: () {
        setState(() {
          _showImage = !_showImage!;
        });
      },
      child: Center(
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: const FlutterLogo(
              style: FlutterLogoStyle.horizontal, size: 100.0),
          // secondChild: const ShimmerPlaceholder(),
          secondChild: Icon(Icons.music_video),
          crossFadeState: _showImage!
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ),
    );
  }
}
