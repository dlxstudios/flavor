import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'settings_service.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

var yt = YoutubeExplode();

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  late Player player = Player(id: 0);
  MediaType mediaType = MediaType.file;
  CurrentState current = CurrentState();
  PositionState position = PositionState();
  PlaybackState playback = PlaybackState();
  GeneralState general = GeneralState();
  VideoDimensions videoDimensions = const VideoDimensions(0, 0);
  List<Media> medias = <Media>[];
  List<Device> devices = <Device>[];
  double bufferingProgress = 0.0;
  Media? metasMedia;

  SettingsController(this._settingsService);
  final SettingsService _settingsService;
  late ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();

    player.currentStream.listen((current) {
      current = current;
      notifyListeners();
    });
    player.positionStream.listen((position) {
      position = position;
      notifyListeners();
    });
    player.playbackStream.listen((playback) {
      playback = playback;
      notifyListeners();
    });
    player.generalStream.listen((general) {
      general = general;
      notifyListeners();
    });
    player.videoDimensionsStream.listen((videoDimensions) {
      videoDimensions = videoDimensions;
      notifyListeners();
    });
    player.bufferingProgressStream.listen(
      (bufferingProgress) {
        bufferingProgress = bufferingProgress;
        notifyListeners();
      },
    );

    // var manifest = await yt.videos.streamsClient.getManifest(
    //     'https://www.youtube.com/watch?v=ijWs-1aw0Rs&list=LL&index=3');

    // print(manifest.streams[2].qualityLabel);
    // // print(manifest.streams[0].url);

    // medias.add(Media.network(
    //   manifest.streams[0].url,
    //   parse: true,
    // ));

    player.open(
      Media.network(
        'https://firebasestorage.googleapis.com/v0/b/dlxstudios-f6e64.appspot.com/o/\'CRIMINAL\'%20Hard%20Trap%20Beat%20Instrumental%20_%20Dark%20Rap%20Hip%20Hop%20Freestyle%20Beats-cR-GH_BuIMI.mp4?alt=media&token=89e0fe65-7900-451d-aa96-49177c023d0a',
      ),
      autoStart: false,
    );

    // notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    print(newThemeMode);
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    await _settingsService.updateThemeMode(newThemeMode);
  }

  @override
  void dispose() {
    print('dispose::dispose');
    player.dispose();
    super.dispose();
  }

  void toggleThemeMode() {
    updateThemeMode(
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
    notifyListeners();
  }
}
