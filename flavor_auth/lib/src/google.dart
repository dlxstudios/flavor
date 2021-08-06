import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class GoogleAuthTokenResponse {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final String? refreshToken;
  final String? idToken;
  final dynamic? raw;

  GoogleAuthTokenResponse({
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.accessToken,
    this.idToken,
    this.raw,
  });

  static Future<GoogleAuthTokenResponse> fromTokenRequest(
      GoogleAuthTokenRequest req) async {
    var clientId = req._app.clientId;
    var clientSecret = req._app.clientSecret;
    var redirectUri = req._app.redirectUri;
    var authCode = req.authCode;

    var oauthTokenUri = Uri(host: 'https://oauth2.googleapis.com/token?');
    // code=$authCode&client_id=$clientId&client_secret=$clientSecret&redirect_uri=$redirectUri&grant_type=$grantType

    var clientTokenResponse = await http.post(oauthTokenUri, body: {
      'code': authCode,
      'client_id': clientId,
      'client_secret': clientSecret,
      'redirect_uri': redirectUri,
      'grant_type': 'authorization_code',
    });
    // print(clientTokenResponse.body);
    var responseJson = json.decode(clientTokenResponse.body);
    var accessToken = responseJson['access_token'];
    var expiresIn = responseJson['expires_in'];
    var refreshToken = responseJson['refresh_token'];
    var tokenType = responseJson['token_type'];
    var idToken = responseJson['id_token'];

    return Future.value(
      GoogleAuthTokenResponse(
        accessToken: accessToken,
        expiresIn: expiresIn,
        refreshToken: refreshToken,
        tokenType: tokenType,
        idToken: idToken,
        raw: responseJson,
      ),
    );
  }
}

class GoogleAuthTokenRequest {
  // final GoogleOAuthApp app;
  // final String authCode;

  final String accessType = 'offline';
  final bool includeGrantedScopes = true;
  final String responseType = 'code';
  final String state = '';

  var authCode;

  String get oauthLink => _oauth;
  var _oauth;

  var _app;

  GoogleAuthTokenRequest(GoogleOAuthApp googleApp) {
    _app = googleApp;
    var clientId = googleApp.clientId;
    var redirectUri = googleApp.redirectUri;
    var _scopes = StringBuffer();

    googleApp.scopes!.forEach((element) {
      _scopes.write('$element ');
    });

    var uri = Uri(
        scheme: 'https',
        host: 'accounts.google.com',
        path: 'o/oauth2/v2/auth',
        queryParameters: {
          'client_id': clientId,
          'redirect_uri': redirectUri,
          'scope': _scopes.toString(),
          'access_type': accessType,
          'include_granted_scopes': includeGrantedScopes.toString(),
          'state': '',
          'response_type': responseType,
        });

    _oauth = uri.toString();
  }
}

class GoogleOAuthApp {
  final String? clientId;
  final String? clientSecret;
  final String? redirectUri;

  final List<String>? scopes;

  GoogleOAuthApp({
    this.clientId,
    this.clientSecret,
    this.redirectUri,
    this.scopes,
  });
}

Future<GoogleAuthTokenResponse> startOAuthServerGoogle(GoogleOAuthApp googleApp,
    [void Function(GoogleOAuthApp params)? onResponse]) async {
  // Open the page
  var req = GoogleAuthTokenRequest(googleApp);
  print('Follow link to continue with Google...');
  // print(req.oauthLink);

  /// start the server to listen for auth code
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8714);
  Uri uri;

  await for (HttpRequest request in server) {
    uri = request.uri;
    // print('uri.pathSegments | ${uri.pathSegments}');
    // print('uri.queryParameters | ${uri.queryParameters}');
    // print('uri.normalizePath().toString( | ${uri.normalizePath().toString()}');
    // print('uri.path | ${uri.path}');

    // request.response.write(uri.queryParameters);
    request.response.write('Done. Please close window.');
    await request.response.close();
    return await server.close().then((value) {
      var params = uri.queryParameters;

      var code = params.containsKey('code') ? params['code'] : '';
      req.authCode = code.toString();
      return GoogleAuthTokenResponse.fromTokenRequest(req);
    }).then((value) {
      // print(tr.accessToken);

      if (onResponse != null) {
        onResponse(googleApp);
      }

      return value;
    });
  }
  return Future.value();
}
