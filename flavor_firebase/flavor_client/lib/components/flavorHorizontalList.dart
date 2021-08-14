import 'package:flavor_client/components/tiles.dart';
import 'package:flavor_client/models/models.dart';
import 'package:flavor_client/models/section.dart';
import 'package:flutter/material.dart';

import 'refactor_components.dart';
import 'card.dart';

class FlavorPageHorizontalLists extends StatelessWidget {
  final List<Section>? sections;
  final double? listItemExtent;

  final double? itemAspectRatio;
  final double? cardAspectRatio;

  final List<Widget>? children;
  final String? title;
  final bool? showTitle;

  const FlavorPageHorizontalLists({
    Key? key,
    this.listItemExtent = 200,
    this.sections = const [],
    this.itemAspectRatio = 1,
    this.cardAspectRatio = 1,
    this.children,
    this.title,
    this.showTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(listItemExtent);

    if (sections == null && children != null) {
      return CustomScrollView(
        /// ! Maybe shrink-wrap
        shrinkWrap: true,
        slivers: List.generate(
          children!.length,
          (indx) => SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: listItemExtent,
                child: children![indx],
              ),
            ),
          ),
        ),
      );
    }

    return CustomScrollView(
      /// ! Maybe shrink-wrap
      shrinkWrap: true,
      slivers: List.generate(
        sections!.length,
        (indx) => SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                sections![indx].title != null
                    ? FlavorListTileHeader(
                        title: sections![indx].title!,
                      )
                    : Container(),
                Container(
                  // margin: EdgeInsets.all(8),
                  height: listItemExtent,
                  // width: 100,
                  // color: Colors.redAccent,
                  child: CustomScrollView(
                    scrollDirection: Axis.horizontal,
                    slivers: List.generate(
                      sections![indx].items!.length,
                      (index) => SliverToBoxAdapter(
                          child: FlavorCard.fromFlavorItem(
                              sections![indx].items![index])),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FlavorHorizontalList extends StatelessWidget {
  final List<Widget> children;
  final String? title;
  final bool? showTitle;
  final double? itemExtent;
  final Section? section;

  final double? itemAspectRatio;
  final double? cardAspectRatio;

  const FlavorHorizontalList(
    this.section, {
    Key? key,
    this.children = const [],
    this.title,
    this.itemExtent = 100,
    this.showTitle = true,
    this.itemAspectRatio,
    this.cardAspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(items != null ? items[0].images : 'nathan');
    // log.wtf(itemExtent);
    return Container(
      height: itemExtent,
      child: Column(
        children: <Widget>[
          AppBar(
            primary: false,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: section!.title != null
                ? Text(section!.title!,
                    style: Theme.of(context).textTheme.headline3)
                : null,
            titleSpacing: 0,
          ),
          Flexible(
            flex: 3,
            // child: Container(
            //   // width: 200,
            //   margin: EdgeInsets.all(8),
            //   color: Colors.white,
            // ),
            child: SingleChildScrollView(
              child: Row(
                children: List.generate(
                  section!.items!.length,
                  (indx) => // FlavorItem FlavorItem = section.items[indx];
                      AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      // margin: EdgeInsets.all(8),
                      // color: Colors.redAccent,
                      child: FlavorCard.fromFlavorItem(section!.items![indx]),
                    ),
                  ),
                ),
              ),
              scrollDirection: Axis.horizontal,
            ),
            // child: Stack(
            //   children: <Widget>[
            //     Container(
            //       child: ListView.builder(
            //         cacheExtent: 100,
            //         scrollDirection: Axis.horizontal,
            //         shrinkWrap: true,
            //         itemCount: section.items.length,
            //         itemExtent: itemExtent,
            //         itemBuilder: (context, indx) {
            //           FlavorItem FlavorItem = section.items[indx];
            //           return FlavorCard.fromFlavorItem(FlavorItem);

            //           // return FlavorCard(
            //           //   padding: EdgeInsets.all(16),
            //           //   imageUrl: section.items[indx].cover,
            //           //   onTap: section.items[indx].onTap,
            //           //   itemAspectRatio: itemAspectRatio,
            //           //   cardAspectRatio: cardAspectRatio,
            //           // );
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          )
        ],
      ),
    );

    return SizedBox(
      height: itemExtent,
      child: Container(
        // color: Colors.red,
        // padding: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showTitle != null
                ? Flexible(
                    flex: 1,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      trailing: DLXElevatedButton(
                        text: 'MORE',
                        onPressed: () {
                          print('object');
                        },
                      ),
                      // leading: AspectRatio(
                      //   aspectRatio: 1,
                      //   child: Material(),
                      // ),
                      subtitle: Text(section!.title!),
                      title: Text(
                        section!.title!,
                        style: Theme.of(context).textTheme.headline5,
                        maxLines: 1,
                      ),
                    ),
                    // child: Container(
                    //   // color: Colors.tealAccent,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                    //     child: LayoutBuilder(builder: (context, size) {
                    //       // log.wtf(size.maxHeight);
                    //       return Text(
                    //         title,
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .caption
                    //             // .copyWith(fontSize: size.maxHeight),
                    //             .copyWith(fontSize: size.maxHeight - 16),
                    //       );
                    //     }),
                    //   ),
                    // ),
                  )
                : Container(),
            Flexible(
              flex: 3,
              child: Stack(
                children: <Widget>[
                  Container(
                    // color: Colors.tealAccent,
                    child: ListView.builder(
                      cacheExtent: 100,
                      scrollDirection: Axis.horizontal,
                      // padding: EdgeInsets.only(left: 8, right: 8),
                      shrinkWrap: true,
                      itemCount: section!.items!.length,
                      itemBuilder: (context, ind) {
                        return AspectRatio(
                          aspectRatio: 8,
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: FlavorCardCover(
                                  padding: EdgeInsets.all(0),
                                  // aspectRatio: .2,
                                  imageUrl:
                                      section!.items![ind].cover.toString(),
                                  onTap: () => section!.items![ind].onTap,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  // leading: CircleAvatar(
                                  //   backgroundColor: Colors.red,
                                  // ),
                                  title: Text('Title goes here'),
                                  subtitle: Text('uploaded 5 hours ago'),
                                  // trailing: IconButton(
                                  //     icon: Icon(Icons.more_vert),
                                  //     onPressed: () {}),
                                ),
                              )
                            ],
                          ),
                        );

                        // return FlavorCard(
                        //   aspectRatio: .6,
                        //   imageUrl: section.items[ind].cover,
                        //   onTap: () => section.items[ind].onTap(),
                        // );
                      },
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Container(
                  //     margin: EdgeInsets.only(top: 8, bottom: 8),
                  //     width: 32,
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //         begin: FractionalOffset.centerRight,
                  //         end: FractionalOffset.centerLeft,
                  //         colors: [
                  //           Colors.transparent,
                  //           Colors.transparent,
                  //           Colors.transparent,
                  //           Colors.purple
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Container(
                  //     margin: EdgeInsets.only(top: 8, bottom: 8),
                  //     width: 32,
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //         begin: FractionalOffset.centerLeft,
                  //         end: FractionalOffset.centerRight,
                  //         colors: [
                  //           Colors.transparent,
                  //           Colors.transparent,
                  //           Colors.transparent,
                  //           Colors.purple
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
