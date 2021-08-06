import 'dart:convert';

import 'package:http/http.dart' as http;

class FlavorHttp {
  Future fetch(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? params,
  }) async {
    // log.w('fetching endpoint \n$path');
    // log.w('with headers \n$headers');
    // log.w('with params \n$params');

    var uri = Uri.parse('$path');
    uri = uri.replace(queryParameters: params);

    // log.w(uri.queryParametersAll);

    http.Response response;

    try {
      response = await http.get(uri, headers: headers).catchError((err) {
        // log.wtf(err);
      });
    } catch (e) {
      return Future.error(
          'Fetch failed : unable to fetch from endpoint $path \n$e');
    }

    return Future.value(response.body);
  }

  Future<Map<String, dynamic>> fetchJson(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? params,
  }) async {
    // log.w('fetching endpoint \n$path');
    // log.w('with headers \n$headers');
    // log.w('with params \n$params');

    var uri = Uri.parse('$path');
    uri = uri.replace(queryParameters: params);

    // log.w(uri.queryParametersAll);

    String responseBody;
    // try {
    responseBody = await fetch(path, params: params, headers: headers);
    // print('responseBody');
    // } catch (e) {
    // return Future.error('$e');
    // return Future.error('unable to fetch from endpoint $path');
    // }

    try {
      // log.w(json.decode(responseBody));
      return json.decode(responseBody);
    } catch (e) {
      return Future.error('unable to decode to json from endpoint $path');
    }
  }

  Future<Map<String, dynamic>> post(dynamic path, dynamic body) async {
    // log.w('posting endpoint $path');
    final response = await http.post(path, body: body);
    try {
      // log.w('response.statusCode ${response.statusCode}');
      return json.decode(response.body);
    } catch (e) {
      return Future.error('unable to load from endpoint $path');
    }
  }
}

Future fetch(
  String path, {
  Map<String, String>? headers,
  Map<String, String>? params,
}) async {
  // log.w('fetching endpoint \n$path');
  // log.w('with headers \n$headers');
  // log.w('with params \n$params');

  var uri = Uri.parse('$path');
  uri = uri.replace(queryParameters: params);

  // log.w(uri.queryParametersAll);

  http.Response response;
  try {
    response = await http.get(uri, headers: headers).catchError((err) {
      // log.wtf(err);
    });
  } catch (e) {
    return Future.error('unable to fetch from endpoint $path \n$e');
  }

  return Future.value(response.body);
}

Future<Map<String, dynamic>> fetchJson(
  String path, {
  Map<String, String>? headers,
  Map<String, String>? params,
}) async {
  // log.w('fetching endpoint \n$path');
  // log.w('with headers \n$headers');
  // log.w('with params \n$params');

  var uri = Uri.parse('$path');
  uri = uri.replace(queryParameters: params);

  // log.w(uri.queryParametersAll);

  String responseBody;
  try {
    responseBody = await fetch(path, params: params, headers: headers);
  } catch (e) {
    return Future.error('unable to fetch from endpoint $path');
  }

  try {
    // log.w(json.decode(responseBody));
    return json.decode(responseBody);
  } catch (e) {
    return Future.error('unable to decode to json from endpoint $path');
  }
}

/// Sends an HTTP HEAD request with the given headers to the given URL, which
/// can be a [Uri] or a [String].
///
/// This automatically initializes a new [Client] and closes that client once
/// the request is complete. If you're planning on making multiple requests to
/// the same server, you should use a single [Client] for all of those requests.
///
/// For more fine-grained control over the request, use [Request] instead.
Future<http.Response>? head(url, {Map<String, String>? headers}) {}

/// Sends an HTTP GET request with the given headers to the given URL, which can
/// be a [Uri] or a [String].
///
/// This automatically initializes a new [Client] and closes that client once
/// the request is complete. If you're planning on making multiple requests to
/// the same server, you should use a single [Client] for all of those requests.
///
/// For more fine-grained control over the request, use [Request] instead.
Future<http.Response>? get(url, {Map<String, String>? headers}) {}

/// Sends an HTTP POST request with the given headers and body to the given URL,
/// which can be a [Uri] or a [String].
///
/// [body] sets the body of the request. It can be a [String], a [List<int>] or
/// a [Map<String, String>]. If it's a String, it's encoded using [encoding] and
/// used as the body of the request. The content-type of the request will
/// default to "text/plain".
///
/// If [body] is a List, it's used as a list of bytes for the body of the
/// request.
///
/// If [body] is a Map, it's encoded as form fields using [encoding]. The
/// content-type of the request will be set to
/// `"application/x-www-form-urlencoded"`; this cannot be overridden.
///
/// [encoding] defaults to [utf8].
///
/// For more fine-grained control over the request, use [Request] or
/// [StreamedRequest] instead.
// Future<Response> post(url,
//     {Map<String, String> headers, body, Encoding encoding}) {}
Future<Map<String, dynamic>> postJson(
  String path,
  dynamic body, {
  Map<String, String>? headers,
}) async {
  Map<String, String> _headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  // log.w('posting endpoint $path');
  final response = await http.post(
    Uri(path: path),
    body: jsonEncode(body),
    headers: {
      ..._headers,
      ...?headers,
    },
  );
  try {
    // log.w('response.statusCode ${response.statusCode}');
    return json.decode(response.body);
  } catch (e) {
    return Future.error('unable to load from endpoint $path');
  }
}

/// Sends an HTTP PUT request with the given headers and body to the given URL,
/// which can be a [Uri] or a [String].
///
/// [body] sets the body of the request. It can be a [String], a [List<int>] or
/// a [Map<String, String>]. If it's a String, it's encoded using [encoding] and
/// used as the body of the request. The content-type of the request will
/// default to "text/plain".
///
/// If [body] is a List, it's used as a list of bytes for the body of the
/// request.
///
/// If [body] is a Map, it's encoded as form fields using [encoding]. The
/// content-type of the request will be set to
/// `"application/x-www-form-urlencoded"`; this cannot be overridden.
///
/// [encoding] defaults to [utf8].
///
/// For more fine-grained control over the request, use [Request] or
/// [StreamedRequest] instead.
Future<http.Response>? put(url,
    {Map<String, String>? headers, body, Encoding? encoding}) {}

/// Sends an HTTP PATCH request with the given headers and body to the given
/// URL, which can be a [Uri] or a [String].
///
/// [body] sets the body of the request. It can be a [String], a [List<int>] or
/// a [Map<String, String>]. If it's a String, it's encoded using [encoding] and
/// used as the body of the request. The content-type of the request will
/// default to "text/plain".
///
/// If [body] is a List, it's used as a list of bytes for the body of the
/// request.
///
/// If [body] is a Map, it's encoded as form fields using [encoding]. The
/// content-type of the request will be set to
/// `"application/x-www-form-urlencoded"`; this cannot be overridden.
///
/// [encoding] defaults to [utf8].
///
/// For more fine-grained control over the request, use [Request] or
/// [StreamedRequest] instead.
Future<http.Response>? patch(url,
    {Map<String, String>? headers, body, Encoding? encoding}) {}

/// Sends an HTTP DELETE request with the given headers to the given URL, which
/// can be a [Uri] or a [String].
///
/// This automatically initializes a new [Client] and closes that client once
/// the request is complete. If you're planning on making multiple requests to
/// the same server, you should use a single [Client] for all of those requests.
///
/// For more fine-grained control over the request, use [Request] instead.
Future<http.Response>? delete(url, {Map<String, String>? headers}) {}
