import 'package:flavor_client/components/page.dart';
import 'package:flavor_client/components/grid.dart';
import 'package:flavor_client/components/flavorHorizontalList.dart';
import 'package:flavor_client/components/flavorMenu.dart';
import 'package:flavor_client/models/models.dart';
import 'package:flavor_client/models/section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter/widgets.dart';
import 'package:flavor_http/http.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FlavorBoard());
}

class Player {
  final String? id;
  final String? realName;
  final String? displayName;
  final String? tagLine;
  final String? image;

  Player({
    this.realName,
    this.displayName,
    this.tagLine,
    this.image,
    this.id,
  });
}

class Game {
  final int? id;
  final String? name;
  final String? released;
  final String? image; //image
  final String? backgroundImage; //background_image
  final String? backgroundImageAdditional; //background_image_additional
  final String? updated;
  final double? rating;
  final String? description;
  final int? added;
  final int? screenshotsCount; //screenshots_count
  final int? moviesCount; //movies_count
  final int? creatorsCount; //creators_count
  final int? twitchCount; //twitch_count
  final int? youtubeCount; //youtube_count
  final int? ratingsCount; //ratings_count
  final int? parentsCount; //parents_count
  final int? additionsCount; //additions_count
  final int? gameSeriesCount; //game_series_count

  Game({
    this.id,
    this.name,
    this.released,
    this.image,
    this.backgroundImage,
    this.backgroundImageAdditional,
    this.updated,
    this.rating,
    this.description,
    this.added,
    this.screenshotsCount,
    this.moviesCount,
    this.creatorsCount,
    this.twitchCount,
    this.youtubeCount,
    this.ratingsCount,
    this.parentsCount,
    this.additionsCount,
    this.gameSeriesCount,
  });
}

class Team {
  final List<Player> players;
  Team(this.players);
}

class FlavorBoardAppState extends ChangeNotifier {
  FlavorBoardAppState();

  List<Player> players = [];

  String playersApi = 'https://randomuser.me/api';
  Future<List<Player>> getPlayers() async {
    var playersJson = await fetchJson(playersApi,
        params: {'results': '50', 'gender': 'female'});

    if (playersJson.containsKey('results')) {
      List items = playersJson['results'];

      for (var item in items) {
        // print(item);
        players.add(
          Player(
            id: item['email'],
            displayName: item['name']['first'].toString() +
                ' ' +
                item['name']['last'].toString(),
            realName: item[''],
            image: item['picture']['large'],
          ),
        );
      }
      return players;
    }

    return [];
  }

  List games = [];

  String apiBase = 'https://api.rawg.io/api/games';

  Future<List<Game>> getGames() async {
    var gamesJson = await fetchJson(apiBase);
    List<Game> games = [];

    if (gamesJson.containsKey('results')) {
      List items = gamesJson['results'];

      for (var item in items) {
        // print(item);
        games.add(
          Game(
            name: item['name'],
            id: item['id'],
            image: item['image'],
            backgroundImage: item['background_image'],
          ),
        );
      }
      return games;
    }

    return [];
  }
}

class FlavorBoard extends StatefulWidget {
  @override
  _FlavorBoardState createState() => _FlavorBoardState();
}

class _FlavorBoardState extends State<FlavorBoard> {
  late GlobalKey<NavigatorState> navigatorKey;
  late Key scaffoldKey;

  double listItemExtent = 200;

  late double gridItemFactor;

  List<Player>? topTeams;
  List<Game>? topGames;

  @override
  void initState() {
    super.initState();
    navigatorKey = new GlobalKey<NavigatorState>();
    scaffoldKey = Key('scaffold_main');
    gridItemFactor = 1;
  }

  @override
  Widget build(BuildContext context) {
    // FlavorJson flavorBoardJson = FlavorJson(context);
    return OrientationBuilder(builder: (context, ori) {
      // log.e(size);

      return LayoutBuilder(builder: (context, size) {
        var width =
            ori == Orientation.portrait ? size.maxWidth : size.maxHeight;
        var height =
            ori == Orientation.portrait ? size.maxHeight : size.maxWidth;

        gridItemFactor = height / width;
        // log.e('gridItemFactor : ${gridItemFactor}');

        var addSidebar = kIsWeb && width > 820;

        // var sectionHeightFactor = height < 900 ? 6 : 4;
        //  listItemExtent = (height / 10) * gridItemFactor;
        listItemExtent = kIsWeb ? 300 : (height / 8) * gridItemFactor;
        // print('listItemExtent : $listItemExtent');
        print('mediaQuery : ${height / 16}');

        // if (listItemExtent < 100) listItemExtent = 200;
        // log.wtf(height / 6);
        // var device = ori == Orientation.landscape;
        // || !kIsWeb && width > 800;

        // log.i(ori == Orientation.landscape);

        return ChangeNotifierProvider<FlavorBoardAppState>(
          create: (BuildContext context) {
            return FlavorBoardAppState();
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: this.navigatorKey,
            darkTheme: ThemeData.dark().copyWith(
              textTheme:
                  GoogleFonts.yeonSungTextTheme(ThemeData.dark().textTheme),

              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white),
              accentColor: Colors.lightGreen,
              primaryColor: Colors.lightGreen,
              // primaryColor: Colors.black,
              // scaffoldBackgroundColor: Colors.purple,
              // textTheme: TextTheme(
              //     headline1: GoogleFonts.lacquerTextTheme().headline1),
            ),
            builder: (context, child) {
              var _menu = FlavorMenu(
                navigatorKey: navigatorKey,
                backgroundColor: Colors.transparent,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.ondemand_video),
                    title: Text('Matches'),
                    onTap: () => navigatorKey.currentState!.pushNamed('/'),
                  ),
                  ListTile(
                    leading: Icon(Icons.people),
                    title: Text('Players'),
                    onTap: () {
                      navigatorKey.currentState!.pushNamed('players');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.people_outline),
                    title: Text('Teams'),
                    onTap: () => navigatorKey.currentState!.pushNamed('teams'),
                  ),
                  ListTile(
                    leading: Icon(Icons.gamepad),
                    title: Text('Games'),
                    onTap: () => navigatorKey.currentState!.pushNamed('games'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () =>
                        navigatorKey.currentState!.pushNamed('settings'),
                  ),
                ],
              );
              return PageShell(
                child: Scaffold(
                  drawer: !addSidebar ? _menu : null,
                  appBar: AppBar(
                    elevation: 1,
                    title: Text('FlavorBoard'),
                    primary: true,
                    leading: !addSidebar
                        ? Builder(builder: (context) {
                            return IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            );
                          })
                        : null,
                  ),
                  body: Row(
                    children: <Widget>[
                      addSidebar
                          ? SizedBox(
                              width: 280,
                              height: size.maxHeight,
                              child: _menu,
                            )
                          : Container(),
                      SizedBox(
                        width: addSidebar ? size.maxWidth - 280 : size.maxWidth,
                        height: size.maxHeight,
                        child: child,
                      ),
                    ],
                  ),
                ),
              );
            },

            onGenerateRoute: (routeSettings) {
              Widget _page = PageError(
                errorCode: 404.toString(),
                msg:
                    'Page Not Found - ${routeSettings.name} ${routeSettings.arguments != null ? "\n Arguments : ${routeSettings.arguments}" : ""}',
              );
              var page = MaterialPageRoute(
                builder: (context) {
                  return _page;
                },
              );
              Map<String, dynamic> args =
                  routeSettings.arguments as Map<String, dynamic>;

              switch (routeSettings.name) {
                case 'home':
                  break;

                case 'game':
                  if (args.containsKey('id')) {
                    _page = SinglePlayerPage(id: args['id']);
                    break;
                  }
                  _page = FlavorPageGrid(
                    listItemExtent: listItemExtent,
                  );
                  break;
                case 'player':
                  if (args.containsKey('id')) {
                    _page = SinglePlayerPage(id: args['id']);
                    break;
                  }
                  _page = FlavorPageGrid(
                    listItemExtent: listItemExtent,
                  );

                  break;
                default:
                  return page;
              }

              return page;
            },
            home: FlavorBoardPageHome(
              navigatorKey: navigatorKey,
              listItemExtent: listItemExtent,
            ),
            // home: Container(),
          ),
        );
      });
    });
  }
}

class FlavorBoardPageHome extends StatefulWidget {
  const FlavorBoardPageHome({
    Key? key,
    this.listItemExtent,
    this.navigatorKey,
  }) : super(key: key);

  final double? listItemExtent;
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  _FlavorBoardPageHomeState createState() => _FlavorBoardPageHomeState();
}

class _FlavorBoardPageHomeState extends State<FlavorBoardPageHome> {
  List<Section> _sections = [];
  List<SectionItem>? topPlayers;
  List<SectionItem>? topGames;
  @override
  void initState() {
    super.initState();

    FlavorBoardAppState().getGames().then((games) {
      setState(() {
        topGames = games.map((game) {
          // print(game.backgroundImage);
          return SectionItem(
            cover: game.backgroundImage,
            title: game.name,
            onTap: () {
              // print('player/${_topPlayers[index].id} was navigated');
              widget.navigatorKey!.currentState!
                  .pushNamed("game", arguments: {'id': game.id});
            },
          );
        }).toList();

        _sections.add(Section(title: 'Top Games', items: topGames));
      });
    });

    /// top Players

    FlavorBoardAppState().getPlayers().then((players) {
      setState(() {
        /// top Players
        var topPlayers = players.map((player) {
          print(player.displayName);
          return SectionItem(
            // footerTitleText: player.displayName,
            cover: player.image,
            title: player.displayName,
            onTap: () {
              // print('player/${_topPlayers[index].id} was navigated');
              widget.navigatorKey!.currentState!
                  .pushNamed("player", arguments: {'id': player.id});
            },
          );
        }).toList();
        _sections.add(Section(title: 'Top Players', items: topPlayers));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlavorBoardAppState>(
      builder: (BuildContext context, FlavorBoardAppState app, Widget? child) {
        //       SectionItem(
        //   cover: _topPlayers[index].image,
        //   title: _topPlayers[index].displayName,
        //   onTap: () {
        //     // print('player/${_topPlayers[index].id} was navigated');
        //     widget.navigatorKey.currentState
        //         .pushNamed("player", arguments: {'id': _topPlayers[index].id});
        //   },
        // ),
        // return FlavorPageHorizontalLists(
        //         listItemExtent: widget.listItemExtent,
        //         cardAspectRatio: 1,
        //         itemAspectRatio: 1,
        //         sections: _sections,
        //       );

        // print(topgames != null);

        return topGames != null
            ? FlavorPageHorizontalLists(
                listItemExtent: widget.listItemExtent,
                cardAspectRatio: 1,
                itemAspectRatio: 1,
                sections: _sections,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class SinglePlayerPage extends StatefulWidget {
  final String? id;

  const SinglePlayerPage({Key? key, this.id}) : super(key: key);
  @override
  _SinglePlayerPageState createState() => _SinglePlayerPageState();
}

class _SinglePlayerPageState extends State<SinglePlayerPage> {
  @override
  Widget build(BuildContext context) {
    // Player player = _topPlayers[int.parse(widget.id)];

    // print(player.displayName);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<FlavorBoardAppState>(context)
                .getGames()
                .then((value) => print(value));
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: <Widget>[
            Text('Single Player Page'),
            Container(
              child: Center(
                child: Text('Single Player Page'),
              ),
            ),
          ],
        ));
  }
}
