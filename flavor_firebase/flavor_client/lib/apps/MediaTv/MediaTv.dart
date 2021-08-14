// import 'package:flavor_client/components/flavorCard.dart';
import 'package:flavor_client/components/card.dart';
import 'package:flavor_client/components/flavorHorizontalList.dart';
import 'package:flavor_client/components/flavorMenu.dart';
import 'package:flavor_client/models/media.dart';
import 'package:flavor_client/models/models.dart';
import 'package:flavor_client/models/section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'MediaTvAppState.dart';

class MediaTv extends StatefulWidget {
  @override
  _MediaTvState createState() => _MediaTvState();
}

class _MediaTvState extends State<MediaTv> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MediaTvAppState>(
      create: (BuildContext context) {
        return MediaTvAppState();
      },
      child: Consumer<MediaTvAppState>(builder: (context, state, child) {
        Widget _flavorMenu = FlavorMenu(
          backgroundColor: Colors.red,
          navigatorKey: state.navigatorKey,
          sections: [
            Section(title: 'Menu', items: [
              SectionItem(title: 'Home', subtitle: ''),
              SectionItem(title: 'page 2', subtitle: ''),
              SectionItem(title: 'page 3', subtitle: ''),
            ]),
            Section(title: 'Plugins', items: [
              SectionItem(title: 'This one', subtitle: 'by google'),
              SectionItem(title: 'that one', subtitle: 'by dlxstudios'),
              SectionItem(title: 'third eye', subtitle: 'by aurthor'),
            ])
          ],
        );
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData.light().copyWith(
          //   textTheme: TextTheme(
          //       headline5: GoogleFonts.aBeeZee(), headline6: GoogleFonts.aBeeZee()),
          // ),
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark().copyWith(
              // textTheme: TextTheme(
              //   headline5: GoogleFonts.aBeeZee(),
              //   headline6: GoogleFonts.aBeeZee(),
              // ),
              // textTheme:
              //     GoogleFonts.yeonSungTextTheme(ThemeData.dark().textTheme),
              ),
          // themeMode: ThemeMode.light,

          navigatorKey: state.navigatorKey,
          builder: (context, child) {
            return LayoutBuilder(builder: (context, size) {
              var addSidebar = kIsWeb && size.maxWidth > 820;
              return Scaffold(
                key: state.scaffoldKey,
                drawer: !addSidebar
                    ? SafeArea(
                        child: _flavorMenu,
                      )
                    : null,

                appBar: state.playerViewState == PlayerViewState.fullscreen
                    ? null
                    : AppBar(
                        // backgroundColor: Colors.transparent,
                        elevation: 0,

                        leading: IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(Icons.menu),
                        ),

                        title: Container(
                          // padding: EdgeInsets.all(9),
                          child: RideOrDieTvLogo(),
                        ),

                        actions: <Widget>[
                          MediaTVToolbarMenu(),
                          SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                body: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: child,
                    ),
                    // SizedBox.expand(
                    //   child: SlideUpPlayer(
                    //       minSizeFractional: minSizeFractional,
                    //       maxPlayerHeight: maxPlayerHeight,
                    //       bodyHeight: bodyHeight,
                    //       width: width),
                    // ),
                  ],
                ),

                // body: LayoutBuilder(builder: (context, size) {
                //   // print(
                //   //     'size.maxHeight - (size.maxHeight - 80) : ${1 - (size.maxHeight - 80) / (size.maxHeight)}');
                //   double minSizeFractional =
                //       1 - (size.maxHeight - 80) / (size.maxHeight);
                //   double aspectRatio = (16 / 9);
                //   double maxPlayerHeight = size.maxWidth / aspectRatio;
                //   print('maxPlayerHeight : $maxPlayerHeight');
                //   double bodyHeight = size.maxHeight - maxPlayerHeight;
                //   double width = size.maxWidth;

                //   return Stack(
                //     children: <Widget>[
                //       Padding(
                //         padding: const EdgeInsets.only(bottom: 0.0),
                //         child: child,
                //       ),
                //       // SizedBox.expand(
                //       //   child: SlideUpPlayer(
                //       //       minSizeFractional: minSizeFractional,
                //       //       maxPlayerHeight: maxPlayerHeight,
                //       //       bodyHeight: bodyHeight,
                //       //       width: width),
                //       // ),
                //     ],
                //   );
                // }),
              );
            });
          },
          home: TvPage(
            child: MediaTvHome(state),
          ),
        );
      }),
    );
  }
}

class SlideUpPlayer extends StatelessWidget {
  const SlideUpPlayer({
    Key? key,
    required this.minSizeFractional,
    required this.maxPlayerHeight,
    required this.bodyHeight,
    this.width,
  }) : super(key: key);

  final double minSizeFractional;
  final double maxPlayerHeight;
  final double bodyHeight;
  final double? width;

  @override
  Widget build(BuildContext context) {
    print('width : $maxPlayerHeight');

    MediaTvAppState state = Provider.of<MediaTvAppState>(context);

    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: minSizeFractional,
      minChildSize: minSizeFractional,
      builder: (BuildContext context, ScrollController scrollController) {
        // print(scrollController.positions.length);
        return CustomScrollView(
          shrinkWrap: true,
          controller: scrollController,
          slivers: <Widget>[
            SliverAppBar(
              elevation: 8,
              forceElevated: true,
              pinned: true,
              primary: true,
              titleSpacing: 0,
              leading: Container(color: Colors.black54),
              actions: [Container(color: Colors.black54)],
              // title: Container(
              //     color: Colors.amber,
              //     height: 200,
              //     // height: size.maxHeight * minSizeFractional,
              //     width: size.maxWidth,
              //     child: MiniPlayerView()),
              // floating: true,
              expandedHeight: maxPlayerHeight,
              flexibleSpace: VideoPlayer(
                state.controller ?? VideoPlayerController.network(''),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.deepOrangeAccent,
                height: bodyHeight,
                width: width,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 8,
                  itemBuilder: (context, i) => Container(
                    margin: EdgeInsets.all(16),
                    height: 300,
                    color: Colors.cyanAccent,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter()
          ],
        );
      },
    );
  }
}

class MiniPlayerView extends StatelessWidget {
  const MiniPlayerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaTvAppState state = Provider.of<MediaTvAppState>(context);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Material(
              child: VideoPlayer(
                state.controller ?? VideoPlayerController.network(''),
              ),
            ),
          ),

          // Flexible(
          //   flex: 1,
          //   child: ListTile(
          //     title: Text('data'),
          //     subtitle: Text('data'),
          //     // contentPadding: EdgeInsets.all(0),
          //   ),
          // ),

          /// Controller Buttons

          Container(
            // width: size.maxWidth,
            child: Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      onPressed: () {},
                    )
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_up),
                  onPressed: () {
                    state.playerViewStateToggle();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MediaTVToolbarMenu extends StatelessWidget {
  const MediaTVToolbarMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: Container(),
      value: 'x',
      items: [
        DropdownMenuItem(
            value: 'x',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 36,
                  width: 36,
                  color: Colors.red,
                  child: Center(child: Text('D')),
                ),
                // SizedBox(
                //   width: 8,
                // ),
                // Text('data')
              ],
            )),
        DropdownMenuItem(
            value: 'y',
            child: Row(
              children: <Widget>[
                Container(
                  height: 36,
                  width: 36,
                  color: Colors.red,
                  child: Center(child: Text('D')),
                ),
                // SizedBox(
                //   width: 8,
                // ),
                // Text('data')
              ],
            )),
      ],
      onChanged: (i) {
        print(i);
      },
    );
  }
}

class MediaVideoView extends StatefulWidget {
  const MediaVideoView({
    Key? key,
  }) : super(key: key);

  @override
  _MediaVideoViewState createState() => _MediaVideoViewState();
}

class _MediaVideoViewState extends State<MediaVideoView> {
  @override
  Widget build(BuildContext context) {
    MediaTvAppState state = Provider.of<MediaTvAppState>(context);

    VideoPlayerController controller = state.controller!;

    return Container(
      child: Material(
        child: Stack(
          children: <Widget>[
            // VideoPlayer(mc.controller != null
            //     ? mc.controller
            //     : VideoPlayerController.network('')),

            VideoPlayer(controller != null
                ? controller
                : VideoPlayerController.network('')),

            /// Overlay
            /// Top Left Text

            Align(
              alignment: Alignment.topLeft,
              child: Container(
                // color: Colors.cyanAccent,
                width: 560,
                height: 100,
                child: ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AspectRatio(
                          aspectRatio: 1.6,
                          child: FlavorImageBox(
                            imageUrl:
                                'https://randomuser.me/api/portraits/women/88.jpg',
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Title',
                              style: TextStyle(fontSize: 44),
                            ),
                            Text(
                              'Subtitle',
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// Center Play Button
            Align(
              alignment: Alignment.center,
              child: IconButton(
                  icon: Icon(Icons.play_circle_filled),
                  iconSize: 120,
                  onPressed: () {
                    // mc.playPause();
                  }),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  // iconSize: 120,
                  onPressed: () {
                    // mc.playPause();
                    state.playerViewStateToggle();
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class TvPage extends StatelessWidget {
  final Widget child;
  const TvPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: child,
    );
  }
}

class RideOrDieTvLogo extends StatelessWidget {
  const RideOrDieTvLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Ride or Die',
        style: TextStyle(
          fontSize: 40,
          color: Colors.red,
        ));
  }
}

class MediaTvHome extends StatefulWidget {
  final MediaTvAppState state;
  const MediaTvHome(this.state, {Key? key}) : super(key: key);
  @override
  _MediaTvHomeState createState() => _MediaTvHomeState();
}

class _MediaTvHomeState extends State<MediaTvHome> {
  // ItemModel mediaItemsRequest;
  List<Track>? mediaItemsRequest;
  List<SectionItem> newreleases = [];
  List<SectionItem> whatshot = [];
  List<SectionItem> dramas = [];
  bool loading = true;

  @override
  initState() {
    super.initState();

    // var dataLoader = TMDBAPI.getPopular().then((value) {
    //   mediaItemsRequest = value;
    // });

    var dataLoader = widget.state.search().then((value) {
      mediaItemsRequest = value;
    });

    dataLoader.then((_) => setState(() => loading = false));

    // dataLoader.then((value) => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    // print(mediaItemsRequest != null);
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    ////////////////////////////////////

    // SectZ

    // double listItemExtent = (MediaQuery.of(context).size.width /
    //         MediaQuery.of(context).devicePixelRatio) /
    //     (MediaQuery.of(context).size.height) *
    //     (MediaQuery.of(context).size.height / 5);

    double listItemExtent = ((MediaQuery.of(context).size.height / 3));
    // double gridItemExtent = listItemExtent;

    // listItemExtent = gridItemExtent;
    // print(
    //     'MediaQuery.of ${MediaQuery.of(context).size.width / MediaQuery.of(context).devicePixelRatio}');
    // print('listItemExtent : $listItemExtent');

    // return Container();

    return FlavorPageHorizontalLists(
        listItemExtent: listItemExtent,
        // sections: [whatsHotSection, newReleasesSection, dramasSection],
        sections: List.generate(
            20,
            (index) => Section(
                title: 'Section $index',
                items: mediaItemsRequest!.map<SectionItem>((section) {
                  // return [];
                  // var title = section.title != null ? section.title : '';
                  // print(section.title);

                  return SectionItem(
                    cover: section.coverUrl,
                    title: section.title,
                    subtitle: section.status,
                    headerTitleText: section.title,
                    headerSubtitleText: section.title,
                    // itemAspectRatio: 16 / 9,
                    onTap: () {
                      // MediaTvAppState state =
                      //     Provider.of<MediaTvAppState>(context);

                      // print(
                      //     'media/detail/${section.id} : ${section.title} was navigated');
                      // state.navigatorKey.currentState.pushNamed("media/detail/",
                      //     arguments: {'id': section.id});
                      var mc = Provider.of<MediaTvAppState>(context);
                      mc.playFromNetwork();
                    },
                  );
                }).toList())));
  }
}
