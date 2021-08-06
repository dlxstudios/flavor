/// Media model ( Video/ Audio / Images )

import 'package:flavor/utilities/firestoreObjects.dart';

abstract class Media {
  /// Algolia
  DateTime? createdAt;
  DateTime? updatedAt;
  String? id;

  /// File

  String? filename;
  String? fileUrl;
  String? status;

  /// Media
  double? duration = 0.0;
  String? title;
  String? aurthor;

  /// Social
  int? likeCount = 0;
  List<String>? likeUserIds;

  Media({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.filename,
    this.fileUrl,
    this.status,
    this.duration,
    this.title,
    this.aurthor,
    this.likeCount,
    this.likeUserIds,
  });
}

class Track extends Media {
  final List<String>? featuring;

  ///
  final String? coverUrl;
  final String? videoUrl;
  final String? audioUrl;

  ///
  final int? plays;
  final List<String>? categories;

  ///
  final String? user;

  ///
  // final Map<String, dynamic> json;
  //
  // //
  final String? title;

  Track({
    this.featuring,
    this.coverUrl,
    this.videoUrl,
    this.plays = 0,
    this.categories,
    this.user,
    this.audioUrl,
    this.title,
    int? likeCount,
  });

  static fromJson(Map<String, dynamic> json) {
    // print(json['id']);
    var id = json['id'];

    var title = json['title'];

    // TODO: change to ownerID
    // var aurthor = json['aurthor'];

    var featuring = json['featuring'];

    var coverUrl = json['cover_url'];

    var videoUrl = json['video_url'];

    String audioUrl = json['audio_url'];
    // Uri audioUrl = Uri(path: json['audio_url']);

    // var duration = json['duration'] ?? Duration.zero;

    var plays = json['plays'] ?? 0;

    var likeCount = json['favorites_count'] ?? 0;

    var categories = json['categories'];

    var createdAt = getDateValueFS(json, 'createTime');
    var updatedAt = getDateValueFS(json, 'updateTime');

    var t = Track(
      title: title,
      categories: categories,
      coverUrl: coverUrl,
      likeCount: likeCount,
      featuring: featuring,
      plays: plays,
      videoUrl: videoUrl,
      audioUrl: audioUrl,
    );
    t.createdAt = createdAt;
    t.updatedAt = updatedAt;
    if (json['audio_url'] != null) {
      print('t.audioUrl - ${t.audioUrl}');
    }
    return t;
  }

  static fromJsonFS(Map<String, dynamic> json) {
    // print(json['name']);
    var id = getIdFS(json);

    var title = getStringValueFS(json, 'title');
    // // print(title);
    var aurthor = getStringValueFS(json, 'aurthor');

    var featuring = [getStringValueFS(json, 'featuring')];

    var coverUrl = getStringValueFS(json, 'cover_url');

    var videoUrl = getStringValueFS(json, 'video_url');

    var duration = getDoubleValueFS(json, 'duration') ?? 0;

    var plays = getIntValueFS(json, 'plays') ?? 0;

    var likeCount = getIntValueFS(json, 'favoritings_count');

    var categories = [getStringValueFS(json, 'categories')];

    var createdAt = getDateValueFS(json, 'createTime');
    var updatedAt = getDateValueFS(json, 'updateTime');

    var t = Track(
      title: title,
      // categories: categories,
      coverUrl: coverUrl,
      likeCount: likeCount,
      // featuring: featuring,
      plays: plays,
      videoUrl: videoUrl,
    );
    t.createdAt = createdAt;
    t.updatedAt = updatedAt;
    return t;
  }

  /// WIP ( rest fetch )
  static List<Track> firestoreToTrackList(List<Map<String, dynamic>> items) {
    if (items.length > 0) {
      List<Track> temp = [];
      for (var i = 0; i < items.length; i++) {
        print('items.length ${items[i]}');
        temp.add(Track.fromJsonFS(items[i]));
      }
      return temp;
    }
    return [];
  }

  static List<Track> fromJsonList(List<Map<String, dynamic>> items) {
    if (items.length > 0) {
      List<Track> temp = [];
      for (var i = 0; i < items.length; i++) {
        temp.add(Track.fromJson(items[i]));
      }
      return temp;
    }
    return [];
  }
}

class Playlist extends Media {
  List<Track>? get tracks => _tracks != null ? _tracks : [];
  List<Track>? _tracks;

  int get length => _tracks != null ? _tracks!.length : 0;

  // String get title => _title;
  // String _title;

  String? get coverUrl => _coverUrl != null ? _coverUrl : null;
  String? _coverUrl;

  int? get plays => _plays;
  int? _plays;

  Playlist({
    List<Track> tracks = const [],
    String? title,
    String? coverUrl,
    int likeCount = 0,
    int plays = 0,
  }) {
    _tracks = tracks;
    _coverUrl = coverUrl;
    // _title = title;
    super.likeCount = likeCount;
    plays = plays;
    super.title = title;
  }
}
