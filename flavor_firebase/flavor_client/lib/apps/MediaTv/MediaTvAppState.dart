import 'package:algolia/algolia.dart';
import 'package:flavor/models/media.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

String apiRoot =
    'https://firestore.googleapis.com/v1/projects/dlxstudios-f6e64/databases/(default)/documents/';

var aindex = 'media_fs';

/// Moddels
// class Media {}

/// PlayerView
enum PlayerViewState { min, max, fullscreen }

/// App State
///
class MediaTvAppState extends ChangeNotifier {
  static Algolia algolia = Algolia.init(
    applicationId: '29GNM5X5TX',
    apiKey: '55df2bac86ee52e70294cbfa5b88e6af',
  );

  Future<List<Track>> search([String query = '']) async {
    AlgoliaQuery _searchQuery =
        MediaTvAppState.algolia.instance.index('$aindex').search(query);
    AlgoliaQuerySnapshot snap = await _searchQuery.getObjects();

    if (snap.nbHits > 0) {
      List<Track> temp = [];
      // return snap;

      for (var i = 0; i < snap.nbHits; i++) {
        print(snap.hits[i].objectID);
        temp.add(Track.fromJsonFS(snap.hits[i].data));
      }
      return temp;
    }

    return Future.error('error');
  }

  /// Moddels
  Media? nowPlaying;

  /// PlayerView
  PlayerViewState _playerViewState = PlayerViewState.min;

  PlayerViewState get playerViewState => _playerViewState;
  set playerViewState(PlayerViewState playerViewState) {
    _playerViewState = playerViewState;
    notifyListeners();
  }

  void playerViewStateToggle() {
    print(playerViewState);
    // this.playerViewState = _playerViewState == PlayerViewState.min
    this.playerViewState = _playerViewState == PlayerViewState.min
        ? _playerViewState = PlayerViewState.fullscreen
        : _playerViewState = PlayerViewState.min;
    print(playerViewState);
  }

  /// Video Controller
  VideoPlayerController? controller;
  bool? isPlaying = false;
  bool? initialized;
  double? aspectRatio;
  VoidCallback? listener;

  /// Navigation
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  /// Api
  String url =
      "https://firebasestorage.googleapis.com/v0/b/dlxstudios-f6e64.appspot.com/o/'CRIMINAL'%20Hard%20Trap%20Beat%20Instrumental%20_%20Dark%20Rap%20Hip%20Hop%20Freestyle%20Beats-cR-GH_BuIMI.mp4?alt=media&token=89e0fe65-7900-451d-aa96-49177c023d0a";

  webMediaController() {
    print('WebMediaController ready');
    // player = VideoPlayer();
    // player.controller.play();
    // notifyListeners();

    listener = () {
      this.initialized = controller?.value.isInitialized;
      print(controller?.value.isInitialized);

      this.aspectRatio = controller?.value.aspectRatio;
      print(controller?.value.aspectRatio);

      this.aspectRatio = controller?.value.aspectRatio;
      print(controller?.value.volume);
    };
  }

  Future<void> destroyController() async {
    if (controller != null) {
      // if (controller.hasListeners) controller.removeListener(listener);
      // controller
      //     .dispose()
      //     .then((value) => controller = null)
      //     .timeout(Duration(milliseconds: 100))
      //     .then((value) => notifyListeners());
      controller = null;
      await Future.delayed(Duration(milliseconds: 100))
          .then((value) => notifyListeners());
    }
  }

  void play() {
    controller?.play().then((_) {
      // logger.i(controller.value.isPlaying);
      notifyListeners();
    });
  }

  void pause() {
    controller?.pause().then((_) {
      // logger.i(controller.value.isPlaying);
      notifyListeners();
    });
  }

  void playFromNetwork() {
    destroyController();

    controller = VideoPlayerController.network(url)
      ..initialize().then((value) {
        controller!.play();
      });

    // controller.addListener(listener);
  }

  void playPause() {
    controller!.value.isPlaying ? controller!.pause() : controller!.play();
  }
}
