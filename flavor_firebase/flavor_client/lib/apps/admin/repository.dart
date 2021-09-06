import 'package:algolia/algolia.dart';
import 'package:flavor_client/models/media.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/foundation.dart';

var mediaTestIndex = 'media_fs';
var postsIndex = 'posts';
var mediaIndex = 'media';
var commentsIndex = 'comments';
var usersIndex = 'users';

class FlavorSearchService extends ChangeNotifier {
  final FlavorUser user;

  static Algolia algolia = Algolia.init(
    applicationId: '29GNM5X5TX',
    apiKey: '55df2bac86ee52e70294cbfa5b88e6af',
  );

  FlavorSearchService(this.user);

  Future<List<Track>> search(String query, [String? index]) async {
    AlgoliaQuery _searchQuery =
        algolia.instance.index('$mediaTestIndex').query(query);
    AlgoliaQuerySnapshot snap = await _searchQuery.getObjects();
    print('snap.nbHits::${snap.nbHits}');

    AlgoliaIndexSettings settingsRef =
        algolia.instance.index('$mediaTestIndex').settings;

    // Get Settings
    Map<String, dynamic> currentSettings = await settingsRef.getSettings();

    // Checking if has [Map]
    print('\n\n');
    print(currentSettings);

    if (snap.nbHits > 0) {
      List<Track> temp = [];
      for (var i = 0; i < snap.nbHits; i++) {
        temp.add(Track.fromJsonFS(snap.hits[i].data));
      }
      return Future.value(temp);
    }

    return Future.error({
      'error': {'msg': 'empty list'}
    });
  }

  bool _init = false;
  List<Track> _tracks = [];
  List<Track> get tracks {
    if (!this._init && _tracks.length == 0) {
      this.getTrackList();
      this._init = true;
      // notifyListeners();
    }
    return _tracks;
  }

  List<Playlist> _playlists = [];
  List<Playlist> get playlists {
    if (!this._init) {
      this.getTrackList();
      this._init = true;
      // notifyListeners();
      print('_playlists ${this._init}');
    }
    return _playlists;
  }

  List<Track> homeTracks() {
    if (!this._init) {
      this.getTrackList();
      this._init = true;
      // notifyListeners();
    }
    return _tracks;
  }

  Future<List<Track>> getTrackList() async {
    AlgoliaQuery _searchQuery = algolia.instance.index('$mediaIndex').query('');
    AlgoliaQuerySnapshot snap = await _searchQuery.getObjects();
    List<Track> temp = [];

    if (snap.nbHits > 0) {
      for (var i = 0; i < snap.nbHits; i++) {
        print(snap.hits[i].objectID);
        temp.add(Track.fromJsonFS(snap.hits[i].data));
      }
    }
    return temp;

    // List<Map<String, dynamic>> _items = jsonToList(jsonData, 'documents');
    // _items.forEach((item) {
    //   _tracks.add(Track.fromJsonFS(item));
    // });

    // // Playlist 1
    // List<Track> p1tracks = [];
    // for (var i = 0; i < 5; i++) {
    //   p1tracks.add(_tracks[i]);
    // }

    // this._playlists.add(Playlist(tracks: p1tracks, title: 'HypeMix'));

    // // Playlist 2
    // List<Track> p2tracks = [];
    // for (var i = 5; i < 11; i++) {
    //   p2tracks.add(_tracks[i]);
    // }

    // this._playlists.add(Playlist(tracks: p2tracks, title: 'Str8 Fire'));

    // // Playlist 1
    // List<Track> p3tracks = [];
    // for (var i = 12; i < 15; i++) {
    //   p3tracks.add(_tracks[i]);
    // }

    // this._playlists.add(Playlist(tracks: p3tracks, title: "Crunk Ain't Dead"));

    // // Playlist 2
    // List<Track> p4tracks = [];
    // for (var i = 15; i < tracks.length; i++) {
    //   p4tracks.add(_tracks[i]);
    // }

    // this._playlists.add(Playlist(tracks: p4tracks, title: 'Fuego'));
  }
}
