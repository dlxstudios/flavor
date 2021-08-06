import 'package:flavor/components/route.dart';
import 'package:flavor/models/media.dart';
import 'package:flavor/theme/clay/clay.dart';
import 'package:flavor/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediaDetailConsumer extends ConsumerWidget {
  final DataItem? mediaData;

  MediaDetailConsumer(this.mediaData);

  final ScrollController controller = ScrollController(keepScrollOffset: true);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Track item =
        Track.fromJson(this.mediaData!.data as Map<String, dynamic>);
    print(item.title);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            // onStretchTrigger: () {
            //   // Function callback for stretch
            // },
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: Text('${item.title == null ? 'Untitled' : item.title}'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  PhotoHero(
                    tag: item.hashCode.toStringAsFixed(4),
                    child: Image.network(
                      item.coverUrl!,
                    ),
                  ),
                  Hero(
                      tag: item,
                      child: ClayTileCard(
                        backgroundImage: DecorationImage(
                            image: Image.network(
                          item.coverUrl!,
                          fit: BoxFit.cover,
                        ).image),
                      )),
                  // Image.network(
                  //   item.coverUrl,
                  //   fit: BoxFit.cover,
                  // ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment(0.0, 0.0),
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SliverAnimatedList(
          //   initialItemCount: 4,
          //   itemBuilder: (context, index, animation) {
          //     return ClayTileCard(
          //       body: Text('data'),
          //     );
          //   },
          // ),
        ],
      ),
    );
    // ignore: dead_code
    return Scaffold(
      appBar: AppBar(

          // title: Text('data'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            background: Container(
              width: 80,
              height: 80,
              child: Image.network(
                item.coverUrl!,
                fit: BoxFit.cover,
              ),
            ),
            // title: Text(item.title),
            collapseMode: CollapseMode.parallax,
            // titlePadding: EdgeInsets.all(14),
          )),
    );
    // return FutureBuilder(
    //   future: adminState.service.search('', ''),
    //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.none:
    //         return ClayTileCard(
    //           body: Text('No Data!'),
    //         );
    //         break;
    //       case ConnectionState.waiting:
    //         return ClayTileCard(
    //           body: Text('Preparing yo order chef!'),
    //         );
    //         break;
    //       case ConnectionState.active:
    //         return ClayTileCard(
    //           body: Text('No Data!'),
    //         );
    //         break;
    //       case ConnectionState.done:
    //         if (snapshot.hasError) {
    //           return ClayTileCard(
    //             body: Column(
    //               children: [
    //                 Text(
    //                   'Error',
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .headline4
    //                       .copyWith(color: Theme.of(context).errorColor),
    //                 ),
    //                 Text(snapshot.error),
    //               ],
    //             ),
    //           );
    //         }
    //         if (snapshot.hasData) {
    //           // return ClayTileCard(
    //           //   body: Text(snapshot.data.toString()),
    //           // );

    //           List<Track> data = snapshot.data;
    //           var title = 'Latests Media';
    //           // print(data.length);

    //           return FlavorPageView(
    //             controller: controller,
    //             children: [
    //               FlavorTileSection(
    //                 title: '$title',
    //                 child: ClayLayoutGrid(
    //                   clayTileCardLayout: ClayTileCardLayout.seperated,
    //                   onbackgoundImage: (index) => DecorationImage(
    //                     image: Image.network(data[index].coverUrl).image,
    //                     fit: BoxFit.cover,
    //                   ),

    //                   // onHeader: (index) => Container(
    //                   //   // color: Colors.deepPurpleAccent,
    //                   //   // child: header,
    //                   //   padding: EdgeInsets.all(8),
    //                   //   child: Row(
    //                   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   //     children: [
    //                   //       CircleAvatar(
    //                   //         radius: 6,
    //                   //         backgroundColor: adminState.useDark
    //                   //             ? Colors.green
    //                   //             : Colors.grey,
    //                   //       ),
    //                   //       Spacer(),
    //                   //       ClayButton(
    //                   //         spread: 0,
    //                   //         surfaceColor: Colors.red,
    //                   //         // parentColor: Colors.transparent,
    //                   //         depth: 0,
    //                   //         child: Icon(Icons.edit),
    //                   //       )
    //                   //     ],
    //                   //   ),
    //                   // ),
    //                   // onHeader: (index) => ListTile(
    //                   //   contentPadding: EdgeInsets.only(bottom: 10),
    //                   //   leading: CircleAvatar(
    //                   //     radius: 16,
    //                   //     backgroundImage:
    //                   //         Image.network(sampleNetworkProfileCover).image,
    //                   //   ),
    //                   //   title: FlavorText.bodyText1(
    //                   //     context,
    //                   //     'aurthor.displayName',
    //                   //     maxLines: 1,
    //                   //   ),
    //                   //   // subtitle: Text(
    //                   //   //   '${data[index].title}',
    //                   //   //   maxLines: 1,
    //                   //   //   style: Theme.of(context).textTheme.caption,
    //                   //   // ),
    //                   //   subtitle: FlavorText.caption(
    //                   //     context,
    //                   //     '${data[index]}',
    //                   //     maxLines: 1,
    //                   //   ),
    //                   // ),
    //                   // onBody: (index) => FlavorText.bodyText1(
    //                   //   context,
    //                   //   '${data[index].title}',
    //                   //   maxLines: 2,
    //                   // ),
    //                   // onBody: (index) => Image.network(
    //                   //   sampleNetworkImageOwl,
    //                   //   fit: BoxFit.cover,
    //                   // ),
    //                   // onBody: (index) => AspectRatio(
    //                   //   aspectRatio: 1,
    //                   //   // child: ,
    //                   // ),
    //                   onTap: (index) {
    //                     // print(index);
    //                     // mediaDetail[index]['ontap'](index);
    //                     Navigator.of(context)
    //                         .pushNamed('/details', arguments: data[index].id);
    //                   },
    //                   // onFooter: (index) => Column(
    //                   //   mainAxisAlignment: MainAxisAlignment.end,
    //                   //   crossAxisAlignment: CrossAxisAlignment.start,
    //                   //   children: [
    //                   //     FlavorText.bodyText1(
    //                   //       context,
    //                   //       '${data[index].title}',
    //                   //       maxLines: 2,
    //                   //     ),
    //                   //     FlavorText.caption(
    //                   //       context,
    //                   //       '${data[index].title}',
    //                   //       maxLines: 1,
    //                   //     ),
    //                   //     SizedBox(
    //                   //       height: 16,
    //                   //     ),
    //                   //   ],
    //                   // ),

    //                   onFooter: (index) => ListTile(
    //                     contentPadding: EdgeInsets.all(0),
    //                     title: FlavorText.bodyText1(
    //                       context,
    //                       '${data[index].title}',
    //                       maxLines: 1,
    //                     ),
    //                     subtitle: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         FlavorText.caption(
    //                           context,
    //                           'uploading 20%',
    //                           maxLines: 1,
    //                         ),
    //                         Spacer(),
    //                         Flexible(
    //                           child: ClayContainer(
    //                             contraints: BoxConstraints(
    //                                 minWidth: 8, maxWidth: double.infinity),
    //                             // color: Colors.red,
    //                             depth: 10,
    //                             // width: 10,
    //                             height: 2,
    //                             child: LinearProgressIndicator(
    //                               value: .5,
    //                               backgroundColor: Colors.grey.shade400,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),

    //                   itemCount: 4,
    //                   crossAxisCount: 2,
    //                   controller: controller,
    //                 ),
    //               ),
    //               FlavorTileSection(
    //                 title: 'Title',
    //                 child: ListView.builder(
    //                   shrinkWrap: true,
    //                   controller: controller,
    //                   itemCount: 2,
    //                   itemBuilder: (context, index) => ClayButton(
    //                     onTap: () {},
    //                     borderRadius: 16,
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: [
    //                         Flexible(
    //                           flex: 1,
    //                           child: Container(
    //                             clipBehavior: Clip.antiAlias,
    //                             decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(16),
    //                               image: DecorationImage(
    //                                 image:
    //                                     Image.network(sampleNetworkProfileCover)
    //                                         .image,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         Flexible(
    //                           flex: 3,
    //                           child: Container(
    //                             padding: EdgeInsets.all(16),
    //                             child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 FlavorText.bodyText1(
    //                                     context, 'Courses I attended'),
    //                                 // Text('Courses I attended',
    //                                 //     style: Theme.of(context)
    //                                 //         .textTheme
    //                                 //         .bodyText1
    //                                 //     // .copyWith(fontSize: 16),
    //                                 //     ),
    //                                 SizedBox(
    //                                   height: 8,
    //                                 ),
    //                                 FlavorText.caption(
    //                                     context, '11 courses in total'),
    //                                 // Text('11 courses in total',
    //                                 //     style:
    //                                 //         Theme.of(context).textTheme.caption
    //                                 //     // .copyWith(fontSize: 16),
    //                                 //     ),
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           );
    //         }
    //         return ClayTileCard(
    //           body: Text('Done'),
    //         );
    //         break;
    //     }

    //     return Container();
    //   },
    // );
  }
}

FlavorRouteWidget get mediaDetailRoute => FlavorRouteWidget(
      path: '/media/:id',
      // title: 'Detail',
      // icon: Icons.mediaDetail,
      backgroundColor: Colors.teal,
      child: MediaDetailConsumer(DataItem({})),
    );

class PhotoHero extends StatelessWidget {
  final Widget? child;

  const PhotoHero({Key? key, this.onTap, this.width, this.tag, this.child})
      : super(key: key);

  final Object? tag;
  final VoidCallback? onTap;
  final double? width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: tag!,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}
