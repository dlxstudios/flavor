import 'package:flutter/material.dart';
import 'package:flavor_http/http.dart';

import 'dart:convert';

import 'package:logger/logger.dart';

extension ListExt<T> on List<T> {
  List<T> copy() => List.from(this, growable: true);

  ///  Ok, so the state (eg. in Bloc) should be immutable, why? Oh boy, that needs a separate explanation for example from here. But let go back on tracks, if the state is immutable then lists in it are too. So when we want to change them we need to create a copy of them and not just add/remove on them.

  ///  List<Widget> _avatars() => urls.mapIndexed((url, index) {
  ///    final padding = _spaceBetween * index;
  ///      return Positioned(
  ///         top: 0.0,
  ///         left: 0.0 + padding,
  ///         child: Avatar(
  ///           size: size,
  ///           imageUrl: url,
  ///         ),
  ///      );
  ///  });
  ///

  List<Y> mapIndexed<Y>(Y Function(T, int) onMap) =>
      asMap().entries.map((entry) => onMap(entry.value, entry.key)).toList();
}

extension IterableExt<T> on Iterable<T> {
  /// final filtered = _currentChallenges
  /// .where((it) => it.categories.containsAll(filters));
  ///

  bool containsAll(Iterable<T> list) {
    for (final item in list) {
      if (!contains(item)) return false;
    }
    return true;
  }

  /// FindOrNull is just a shorter notation then using orElse with lambda.
  /// final workout = _currentWorkouts.findOrNull((it) => it.id == workoutId);
  ///

  // T findOrNull(bool Function(T) where) => firstWhere(where, orElse: () => );
}

String youtubeCoverUrlBuilder =
    "https://img.youtube.com/vi/__id__/maxresdefault.jpg";

String youtubeCoverURL(String id) {
  // print(youtubeCover.replaceAll("__id__", "-mJjb0k50ak"));
  return youtubeCoverUrlBuilder.replaceAll("__id__", id);
}

// class FlavorServices {
//   Future fetch(
//     String path, {
//     Map<String, String> headers,
//     Map<String, String> params,
//   }) async {
//     // log.w('fetching endpoint \n$path');
//     // log.w('with headers \n$headers');
//     // log.w('with params \n$params');

//     var uri = Uri.parse('$path');
//     uri = uri.replace(queryParameters: params);

//     // log.w(uri.queryParametersAll);

//     http.Response response;

//     try {
//       response = await http.get(uri, headers: headers).catchError((err) {
//         // log.wtf(err);
//       });
//     } catch (e) {
//       return Future.error(
//           'Fetch failed : unable to fetch from endpoint $path \n$e');
//     }

//     return Future.value(response.body);
//   }

//   Future<Map<String, dynamic>> fetchJson(
//     String path, {
//     Map<String, String> headers,
//     Map<String, String> params,
//   }) async {
//     // log.w('fetching endpoint \n$path');
//     // log.w('with headers \n$headers');
//     // log.w('with params \n$params');

//     var uri = Uri.parse('$path');
//     uri = uri.replace(queryParameters: params);

//     // log.w(uri.queryParametersAll);

//     String responseBody;
//     // try {
//     responseBody = await fetch(path, params: params, headers: headers);
//     // print('responseBody');
//     // } catch (e) {
//     // return Future.error('$e');
//     // return Future.error('unable to fetch from endpoint $path');
//     // }

//     try {
//       // log.w(json.decode(responseBody));
//       return json.decode(responseBody);
//     } catch (e) {
//       return Future.error('unable to decode to json from endpoint $path');
//     }
//   }

//   Future<Map<String, dynamic>> post(String path, dynamic body) async {
//     // log.w('posting endpoint $path');
//     final response = await http.post('$path', body: body);
//     try {
//       // log.w('response.statusCode ${response.statusCode}');
//       return json.decode(response.body);
//     } catch (e) {
//       return Future.error('unable to load from endpoint $path');
//     }
//   }
// }

// Future fetch(
//   String path, {
//   Map<String, String> headers,
//   Map<String, String> params,
// }) async {
//   // log.w('fetching endpoint \n$path');
//   // log.w('with headers \n$headers');
//   // log.w('with params \n$params');

//   var uri = Uri.parse('$path');
//   uri = uri.replace(queryParameters: params);

//   // log.w(uri.queryParametersAll);

//   http.Response response;
//   try {
//     response = await http.get(uri, headers: headers).catchError((err) {
//       // log.wtf(err);
//     });
//   } catch (e) {
//     return Future.error('unable to fetch from endpoint $path \n$e');
//   }

//   return Future.value(response.body);
// }

// Future<Map<String, dynamic>> fetchJson(
//   String path, {
//   Map<String, String> headers,
//   Map<String, String> params,
// }) async {
//   // log.w('fetching endpoint \n$path');
//   // log.w('with headers \n$headers');
//   // log.w('with params \n$params');

//   var uri = Uri.parse('$path');
//   uri = uri.replace(queryParameters: params);

//   // log.w(uri.queryParametersAll);

//   String responseBody;
//   try {
//     responseBody = await fetch(path, params: params, headers: headers);
//   } catch (e) {
//     return Future.error('unable to fetch from endpoint $path');
//   }

//   try {
//     // log.w(json.decode(responseBody));
//     return json.decode(responseBody);
//   } catch (e) {
//     return Future.error('unable to decode to json from endpoint $path');
//   }
// }

// Future<Map<String, dynamic>> post(String path, dynamic body) async {
//   // log.w('posting endpoint $path');
//   final response = await http.post('$path', body: body);
//   try {
//     // log.w('response.statusCode ${response.statusCode}');
//     return json.decode(response.body);
//   } catch (e) {
//     return Future.error('unable to load from endpoint $path');
//   }
// }

// Structure
//   /pages/{route}
//     - title
//     - backgroundColor
//     - backgroundImage
//     - components
//       - list
//         - direction
//         - items
//           - 0_reference
//           - 1_reference

List<Map<String, dynamic>> jsonToList(Map<String, dynamic> itemsJson,
    [String? itemsSelector]) {
  List<Map<String, dynamic>> temp = [];
  // print('itemsSelector');
  // print(itemsSelector);
  if (itemsSelector != null) {
    // log.d('jsonFetchList selector $itemsSelector');
    // log.d("itemsJson.length ${itemsJson.length}");
    // log.d("itemsJson ${itemsJson}");
    // log.d(itemsJson[itemsSelector]);

    if (!itemsJson.containsKey(itemsSelector)) {
      return [];
    }
    for (int i = 0; i < itemsJson[itemsSelector].length; i++) {
      var result = itemsJson[itemsSelector][i];
      temp.add(result);
      // print(result.data['title']);
    }
  }
  // print(temp.length);
  return temp;
}

List<DataItem> jsonToDataItemList(List<dynamic> itemsJson,
    [String? itemsSelector]) {
  List<DataItem> temp = [];
  // print('itemsSelector');
  // print(itemsSelector);
  if (itemsSelector != null) {
    // print('jsonFetchList selector $itemsSelector');
    // print("itemsJson.length ${itemsJson.length}");
    for (int i = 0; i < itemsJson.length; i++) {
      DataItem result = DataItem(itemsJson[i]);
      temp.add(result);
      // print(result.data['title']);
    }
  }
  // print(temp.length);
  return temp;
}

Future<List<DataItem>> jsonFetchList(String url,
    [String? itemsSelector]) async {
  return fetchJson(url).then((resBody) {
// print(resBody.length.toString());
    List<DataItem> temp = [];
    // print('itemsSelector');
    // print(itemsSelector);
    if (itemsSelector != null) {
      // print('jsonFetchList + selector');
      // print(url);
      for (int i = 0; i < resBody[itemsSelector].length; i++) {
        DataItem result = DataItem(resBody[itemsSelector][i]);
        temp.add(result);
        // print(result.data['title']);
      }
    } else {
      print('jsonFetchList without selector');
      for (int i = 0; i < resBody.length; i++) {
        DataItem result = DataItem(resBody[i]);
        temp.add(result);
        // print(result.data['title']);
      }
    }
    // print(temp.length);
    return temp;
  });
}

Logger console = Logger();

stringVarToConstant(String input) {
  // Started, needs to be complete
  var _processed;
  // String _matchGroup0;
  String _matchGroup1;
  // set the input if any
  if (input == null) return {'error': 'no input'};

  // Find vars in string between ${}
  // (?<=\${)(.*?)(?=\})
  RegExp regExp = new RegExp('{(.*?)}', caseSensitive: false);

  Iterable<Match> matches = regExp.allMatches(input);

  if (matches.length < 1) {
    return _processed = input;
  }

  for (Match match in matches) {
    // _matchGroup0 = match.group(0);
    _matchGroup1 = match.group(1)!;

    // Check for nested
    var nestedKeys = _matchGroup1.split('.');

    switch (nestedKeys[0]) {
      case 'Colors':
        _processed = nestedKeys[1];
        break;
      default:
    }

    for (var i = 0; i < nestedKeys.length; i++) {
      stringVarLoop(nestedKeys[i]);
    }
  }

  return _processed;
}

Color getColorConst(String color) {
  Color _color;

  if (color != null && color.startsWith('Colors'))
    color = stringVarToConstant(color);

  switch (color) {
    case 'amber':
      _color = Colors.amber;
      break;
    default:
      _color = Colors.orangeAccent;
  }

  return _color;
}

getThemeMode(String modeString) {
  var mode = Brightness.light;

  switch (modeString) {
    case 'dark':
      mode = Brightness.dark;

      break;
    default:
  }

  return mode;
}

stringVarLoop(input, {prev}) {}

String? stringVarMap(String input, {DataItem? item}) {
  String? _processed;
  String _matchGroup0;
  String _matchGroup1;
  // set the input if any
  if (input != null) {
    // print(input);

    // Find vars in string between ${}
    // (?<=\${)(.*?)(?=\})
    RegExp regExp = new RegExp('{(.*?)}', caseSensitive: false);

    // print("allMatches : "+regExp.allMatches(input).first.toString());
    // input.replaceAllMapped(regExp, (Match m){
    //   print('Match : '+ m.groupCount.toString());
    // });

    Iterable<Match> matches = regExp.allMatches(input);

    // print("matches.length : ${matches.length.toString()}");

    if (matches.length < 1) {
      // print(input);
      return _processed = input != null ? input : 'no data';
    }

    for (Match match in matches) {
      _matchGroup0 = match.group(0)!;
      _matchGroup1 = match.group(1)!;

      // print('Match');

      // print("var : " + input);

      // print(item.data['snippet']['title'] ?? 'null');

      // print(match.toString());
      // print('match.group');
      // print(_matchGroup0);
      // print("group(1) : " + match.group(1) ?? "null");

      // Check for nested
      var nestedKeys = _matchGroup1.split('.');
      dynamic dat = item!.data;
      // nestedKeys.reduce((prev, curr){
      //   print("prev : " + prev);
      // print("curr : " + curr);
      //    dat = item.data[prev];
      //    print(dat.runtimeType);
      // print("dat : ${ item.data[prev][curr]}");
      // });
      _getNest(key) {
        if (dat.containsKey(key)) {
          // print("containsKey : " + key);
          // print(dat[key].toString());
          dat = dat[key];
        }
        // print("nope: " + key);
      }

      if (nestedKeys.length > 1) {
        // print(" > 1 - nestedKeys.length : " + nestedKeys.length.toString());

        for (var i = 0; i < nestedKeys.length; i++) {
          // print("NestedKeys [$i]  " + nestedKeys[i].toString());
          _getNest(nestedKeys[i]);
          // print(i);
        }
        _matchGroup1 = dat.toString();
        _processed = input.replaceAll(_matchGroup0, _matchGroup1);
      } else if (nestedKeys.length == 1) {
        // print(" == 1 - nestedKeys.length : " + nestedKeys.length.toString());
        // Check if the key exist
        if (item.data.containsKey(nestedKeys[0])) {
          _matchGroup1 = item.data[nestedKeys[0]];
          if (_matchGroup1 == null) {
            _processed = input;
          } else {
            _processed = input.replaceAll(_matchGroup0, _matchGroup1);
          }
        } else {
          _processed = input;
        }

        // print("_processed... " + _processed.toString());
      }

      // poster = poster.replaceAll('-large', '-t500x500');

      // print(_processed);
    }
    // print('input');
    // print(input);
  } else {
    // print(item.data);
    if (item!.data['cover'] != null) {
      _processed = item.data['cover'];
    }
  }

  return _processed;
}

String? stringVar(String input, Map<String, dynamic> item) {
  String? _processed;
  String _matchGroup0;
  String _matchGroup1;
  // set the input if any
  if (input != null) {
    // print(input);

    // Find vars in string between ${}
    // (?<=\${)(.*?)(?=\})
    RegExp regExp = new RegExp('{(.*?)}', caseSensitive: false);

    // print("allMatches : "+regExp.allMatches(input).first.toString());
    // input.replaceAllMapped(regExp, (Match m){
    //   print('Match : '+ m.groupCount.toString());
    // });

    Iterable<Match> matches = regExp.allMatches(input);

    // print("matches.length : ${matches.length.toString()}");

    if (matches.length < 1) {
      // print(input);
      return _processed = input != null ? input : 'no data';
    }

    for (Match match in matches) {
      _matchGroup0 = match.group(0)!;
      _matchGroup1 = match.group(1)!;

      // print('Match');

      // print("var : " + input);

      // print(item.data['snippet']['title'] ?? 'null');

      // print(match.toString());
      // print('match.group');
      // print(_matchGroup0);
      // print("group(1) : " + match.group(1) ?? "null");

      // Check for nested
      var nestedKeys = _matchGroup1.split('.');
      dynamic dat = item;
      // nestedKeys.reduce((prev, curr){
      //   print("prev : " + prev);
      // print("curr : " + curr);
      //    dat = item.data[prev];
      //    print(dat.runtimeType);
      // print("dat : ${ item.data[prev][curr]}");
      // });
      _getNest(key) {
        if (dat.containsKey(key)) {
          // print("containsKey : " + key);
          // print(dat[key].toString());
          dat = dat[key];
        }
        // print("nope: " + key);
      }

      if (nestedKeys.length > 1) {
        // print(" > 1 - nestedKeys.length : " + nestedKeys.length.toString());

        for (var i = 0; i < nestedKeys.length; i++) {
          // print("NestedKeys [$i]  " + nestedKeys[i].toString());
          _getNest(nestedKeys[i]);
          // print(i);
        }
        _matchGroup1 = dat.toString();
        _processed = input.replaceAll(_matchGroup0, _matchGroup1);
      } else if (nestedKeys.length == 1) {
        // print(" == 1 - nestedKeys.length : " + nestedKeys.length.toString());
        // Check if the key exist
        if (item.containsKey(nestedKeys[0])) {
          _matchGroup1 = item[nestedKeys[0]];
          if (_matchGroup1 == null) {
            _processed = input;
          } else {
            _processed = input.replaceAll(_matchGroup0, _matchGroup1);
          }
        } else {
          _processed = input;
        }

        // print("_processed... " + _processed.toString());
      }

      // poster = poster.replaceAll('-large', '-t500x500');

      // print(_processed);
    }
    // print('input');
    // print(input);
  }
  // else {
  //   // print(item.data);
  //   // if (item['cover'] != null) {
  //   //   _processed = item['cover'];
  //   // }
  // }

  return _processed;
}

class DataItem {
  DataItem(this.data);
  Map<dynamic, dynamic> data;
  //
  Map<String, String> get json => jsonDecode(this.data.toString());
  //
  @override
  String toString() {
    return jsonEncode(this.data).toString();
  }
}
