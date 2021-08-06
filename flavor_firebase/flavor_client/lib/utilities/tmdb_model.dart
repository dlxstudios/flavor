import 'package:flavor/utilities/tmdb_api.dart';

class ItemModel {
  int? _page;
  int? _totalResults;
  int? _totalPages;
  List<Result> _results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    //  print(parsedJson['total_pages']);
    _page = parsedJson['page'];
    _totalResults = parsedJson['total_results'];
    _totalPages = parsedJson['total_pages'];
    List<Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      Result result = Result(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<Result> get results => _results;

  int? get totalPages => _totalPages;

  int? get totalResults => _totalResults;

  int? get page => _page;
}

class Result {
  int? _voteCount;
  int? _id;
  bool? _video;
  var _voteAverage;
  String? _title;
  double? _popularity;
  String? _posterPath;
  String? _originalLanguage;
  String? _originalTitle;
  List<int>? _genreIDs = [];
  String? _backdropPath;
  bool? _adult;
  String? _overview;
  String? _releaseDate;

  Result(Map<String, dynamic> result) {
    var _posterPathLink =
        result.containsKey('poster_path') ? result['poster_path'] : null;
    var _backdropPathLink =
        result.containsKey('backdrop_path') ? result['backdrop_path'] : null;
    _posterPath = "https://image.tmdb.org/t/p/w500$_posterPathLink";
    _backdropPath = "https://image.tmdb.org/t/p/w1280$_backdropPathLink";

//     _voteCount = result.containsKey('vote_count') ? result['vote_count'] : null;
    _id = result.containsKey('id') ? result['id'] : 0;
    _video = result.containsKey('video') ? result['video'] : null;
    _voteAverage =
        result.containsKey('vote_average') ? result['vote_average'] : null;
    _title = result.containsKey('title') ? result['title'] : null;
    _popularity =
        result.containsKey('popularity') ? result['popularity'] : null;
    //!FIX
    // _originalLanguage =
    //     result.containsKey('vote_count') ? result['vote_count'] : null;
//     _originalTitle =
//         result.containsKey('vote_count') ? result['vote_count'] : null;
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genreIDs!.add(result['genre_ids'][i]);
    }
// //    print(_backdropPath);
    _adult = result['adult'];
    _overview = result['overview'];
    _releaseDate = result['release_date'];
  }

  String? get releaseDate => _releaseDate;

  String? get overview => _overview;

  bool? get adult => _adult;

  String? get backdropPath => _backdropPath;

  List<int>? get genreIds => _genreIDs;

  String? get originalTitle => _originalTitle;

  String? get originalLanguage => _originalLanguage;

  String? get posterPath => _posterPath;

  double? get popularity => _popularity;

  String? get title => _title;

  double get voteAverage => _voteAverage;

  bool? get video => _video;

  int? get id => _id;

  int? get voteCount => _voteCount;

  ImagesModel? images;
  // ImagesModel get images => _images;
  //  set images(String id) {
  //   this.empName = name;
  // }
}

class ImagesModel {
  int? _id;
  int? get id => _id;

  List _backdrops = [];
  List get backdrops => _backdrops;
  List _posters = [];
  List get posters => _posters;

  ImagesModel();

  ImagesModel.fromJson(Map<String, dynamic> parsedJson) {
    //  print(parsedJson['total_pages']);
    _id = parsedJson['id'];

    List temp = parsedJson['backdrops'];

    if (temp.length > 0) {
      // print(temp.length);
      for (int i = 0; i < parsedJson['backdrops'].length; i++) {
        _backdrops.add(ImageModel.fromJson(parsedJson['backdrops'][i]));
      }
    }

    // for (int i = 0; i < parsedJson['posters'].length; i++) {
    //   _posters.add(ImageModel.fromJson(parsedJson['posters'][i]));
    // }
  }
}

class ImageModel {
  double? _aspectRatio;
  double? get aspectRatio => _aspectRatio;

  String? _filePath;
  String? get filePath => _filePath;
  int? _height;
  int? get height => _height;
  int? _width;
  int? get width => _width;
  int? _voteCount;
  int? get voteCount => _voteCount;
  int? _voteAverage;
  int? get voteAverage => _voteAverage;

  ImageModel();

  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    _aspectRatio = parsedJson['aspect_ratio'];
    _filePath = parsedJson['file_path'];
    _height = parsedJson['height'];
    _width = parsedJson['width'];
    _voteCount = parsedJson['vote_count'];
    // _voteAverage = parsedJson['vote_average'];
  }
}
