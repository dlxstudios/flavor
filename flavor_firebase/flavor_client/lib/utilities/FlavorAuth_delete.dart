// import 'dart:convert';
// import 'dart:io';

// import 'package:flavor_auth/src/models/user.dart';


// import 'package:flavor_client/utilities/FlavorStore.dart';
// import 'package:flavor_client/utilities/services.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart';
// import 'package:process_run/process_run.dart';
// import 'package:url_launcher/url_launcher.dart';

// class FlavorAuthStateOld extends ChangeNotifier {
//   final FlavorAuthEmail auth;
//   final store = FlavorStore;

//   bool isLoggedIn;

//   FlavorUser _currentUser;

//   String googleWebApiKey;

//   FlavorAuthStateOld({this.auth}) {
//     // store.delete('currentUser');
//     var currentUserjson = this.store?.read('currentUser');
//     // print(FlavorUser.fromJson( currentUserjson));
//     currentUser =
//         currentUserjson != null ? FlavorUser.fromJson(currentUserjson) : null;
//     // log.wtf(FlavorUser.fromJson(this.store?.read('currentUser')));
//   }
//   FlavorUser get currentUser => _currentUser;
//   set currentUser(FlavorUser cu) {
//     if (cu == null) {
//       store.delete('currentUser');
//       _currentUser = null;
//       isLoggedIn = false;
//       notifyListeners();
//       return;
//     }
//     // !TEST
//     // log.w(cu.toJson());
//     // store.write('currentUser', cu.toJson());

//     // - final
//     _currentUser = cu;

//     store.write('currentUser', cu.toJson());
//     isLoggedIn = true;
//     notifyListeners();
//   }

//   Future<bool> signOut() async {
//     // log.w('Signout');
//     currentUser = null;
//     return true;
//   }

//   Future<void> googleSignIn() async {
//     print('fIsDesktop | $fIsDesktop');
//     if (fIsDesktop) {
//       // Start server
//       return currentUser = await startOAuthServerGoogle();
//     }
//     if (kIsWeb) {
//       return currentUser = await startOAuthBrowser();
//     }
//     if (!fIsDesktop) {
//       return currentUser = await startOAuthMobile();
//     }
//   }

//   Future<FlavorUser> signInWithEmail(String email, String password) async {
//     return auth
//         .signInWithEmail(email, password)
//         .then((value) => currentUser = FlavorUser.fromJson(value));
//   }

//   Future fetch() {
//     var _clientBody = {
//       'token': currentUser.idToken,
//     };

//     Client client;
//   }
// }

// class FlavorAuthEmail {
//   final String googleWebApiKey;

//   FlavorAuthEmail({this.googleWebApiKey});

// // server info
//   String clientId =
//       '546747910139-k7ed76efm8e9lrhd7iuu6bfdmveg6m5c.apps.googleusercontent.com';
//   String clientSecret = 'FhaABYFADcFi3fl5in3mMfUs';
//   String grantType = 'authorization_code';
//   String redirectUri = 'http://localhost:8880';
// // OAuth Response info
//   String oauthRequestUri() =>
//       'https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/calendar email&include_granted_scopes=$includeGrantedScopes&response_type=$responseType&state=$state&redirect_uri=$redirectUri&client_id=$clientId';
//   String authCode;
//   var accessType = 'offline';
//   var includeGrantedScopes = true;
//   var responseType = 'code';
//   var state;
// // Token Resonse info
//   String oauthTokenUri() =>
//       'https://oauth2.googleapis.com/token?code=$authCode&client_id=$clientId&client_secret=$clientSecret&redirect_uri=$redirectUri&grant_type=$authCode';
//   String accessToken;
//   int expiresIn;
//   String refreshToken;
//   String scope;
//   String tokenType;
//   String idToken;
//   String firebaseAuthUri() =>
//       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=$googleWebApiKey';

// // Email and Password
//   String signInWithEmailUri() =>
//       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$googleWebApiKey';

//   fromOAuthTokenResponse(Map<String, dynamic> json) {
//     accessToken = json["access_token"];
//     expiresIn = json["expires_in"];
//     refreshToken = json["refresh_token"];
//     scope = json["scope"];
//     tokenType = json["token_type"];
//     idToken = json["id_token"];
//   }

//   asMap() => {
//         'code': authCode,
//         'client_id': clientId,
//         'client_secret': clientSecret,
//         'redirect_uri': redirectUri,
//         'grant_type': grantType
//       };

//   @override
//   String toString() {
//     return {
//       clientId,
//       clientSecret,
//       grantType,
//       redirectUri,
//     }.toString();
//   }

//   Future<Map<String, dynamic>> signInWithEmail(
//       String email, String password) async {
//     var _clientBody = {
//       'email': email,
//       'password': password,
//       'returnSecureToken': 'true',
//     };
//     Map<String, dynamic> _responseBody;

//     await Client()
//         .post(signInWithEmailUri(), body: _clientBody)
//         .then((Response res) {
//       try {
//         _responseBody = json.decode(res.body) as Map<String, dynamic>;
//       } catch (e) {
//         return Future.error(e);
//       }
//       return _responseBody;
//     }).catchError((err) {
//       log.e(err);
//       return Future.error(err);
//     });
//     return Future.value(_responseBody);
//   }
// }

// Future<void> _launchInBrowser(String url) async {
//   try {
//     await canLaunch(url);
//     await launch(
//       url,
//       forceSafariVC: true,
//       forceWebView: true,
//       headers: <String, String>{'my_header_key': 'my_header_value'},
//     );
//   } catch (e) {
//     log.wtf(e);
//   }
// }

// /// Starts an OAuth server with Google for Desktop and Web applications
// Future<FlavorUser> startOAuthServerGoogle(
//     [void Function(FlavorAuthEmail params) onResponse]) async {
//   // Prep the GoogleAuth Object ( scopes, redirectURI, etc )
//   FlavorAuthEmail _googleInfo = FlavorAuthEmail();

//   print('Prep the GoogleAuth Object ( scopes, redirectURI, etc )');

//   /// Open the page

//   if (Platform.isLinux) {
//     run('xdg-open', [_googleInfo.oauthRequestUri()]);
//   }

//   if (Platform.isWindows) {
//     print('Opening chrome on Windows ');
//     run(
//         'start',
//         [
//           '''""''',
//           _googleInfo.oauthRequestUri(),
//         ],
//         verbose: true);
//   }

//   if (kIsWeb) {
//     print('_googleInfo.oauthRequestUri() - ${_googleInfo.oauthRequestUri()}');
//     _launchInBrowser(_googleInfo.oauthRequestUri());
//   }

//   // if (Platform.isAndroid) {
//   //   print('_googleInfo.oauthRequestUri() - ${_googleInfo.oauthRequestUri()}');
//   //   _launchInBrowser(_googleInfo.oauthRequestUri());
//   // }

//   /// custom server

//   final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8880);
//   Uri uri;

//   await for (HttpRequest request in server) {
//     uri = request.uri;
//     // print('uri.pathSegments | ${uri.pathSegments}');
//     // print('uri.queryParameters | ${uri.queryParameters}');
//     // print('uri.normalizePath().toString( | ${uri.normalizePath().toString()}');
//     // print('uri.path | ${uri.path}');

//     // request.response.write(uri.queryParameters);
//     request.response.write('Done. Please close window.');
//     await request.response.close();
//     await server.close();
//   }

//   var params = uri.queryParameters;

//   var code = params.containsKey('code') ? params['code'] : '';
//   _googleInfo.authCode = code;
//   // log.e(code);

//   Response clientTokenResponse = await Client()
//       .post('https://oauth2.googleapis.com/token', body: _googleInfo.asMap())
//       .catchError((err) {
//     log.i(err);
//     return Future.error(err);
//   });
//   // log.i(clientTokenResponse.body);

//   _googleInfo.fromOAuthTokenResponse(json.decode(clientTokenResponse.body));

//   // log.i(_googleInfo.accessToken);

//   Response fbAuthClient = await Client().post(
//     'https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=AIzaSyA6B4rr-ym0RaiXTK-HD4CEyFJvuSwVrJY',
//     body: {
//       "postBody": "id_token=${_googleInfo.idToken}&providerId=google.com",
//       "requestUri": "http://localhost:8880",
//       "returnIdpCredential": true.toString(),
//       "returnSecureToken": true.toString()
//     },
//   ).catchError((err) {
//     log.i(err);
//     return Future.error(err);
//   });

//   Map<String, dynamic> finalres = json.decode(fbAuthClient.body);

//   // print(finalres);
//   if (finalres.containsKey('error')) {
//     log.e(finalres);
//     return Future.error(finalres);
//   }

//   if (onResponse != null) {
//     onResponse(_googleInfo);
//   }

//   await Future.delayed(Duration(seconds: 1)).then((value) {});
//   return FlavorUser.fromJson(finalres);
// }

// Future<FlavorUser> startOAuthBrowser(
//     [void Function(FlavorAuthEmail params) onResponse]) async {
//   // Prep the GoogleAuth Object ( scopes, redirectURI, etc )
//   FlavorAuthEmail _googleInfo = FlavorAuthEmail();

//   /// Open the page

//   print('_googleInfo.oauthRequestUri() - ${_googleInfo.oauthRequestUri()}');
//   _launchInBrowser(_googleInfo.oauthRequestUri());

//   /// custom server

//   // var code = params.containsKey('code') ? params['code'] : '';
//   // _googleInfo.authCode = code;
//   // log.e(code);

//   Response clientTokenResponse = await Client()
//       .post('https://oauth2.googleapis.com/token', body: _googleInfo.asMap())
//       .catchError((err) {
//     log.i(err);
//     return Future.error(err);
//   });
//   // log.i(clientTokenResponse.body);

//   _googleInfo.fromOAuthTokenResponse(json.decode(clientTokenResponse.body));

//   // log.i(_googleInfo.accessToken);

//   Response fbAuthClient = await Client().post(
//     'https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=AIzaSyA6B4rr-ym0RaiXTK-HD4CEyFJvuSwVrJY',
//     body: {
//       "postBody": "id_token=${_googleInfo.idToken}&providerId=google.com",
//       "requestUri": "http://localhost:8880",
//       "returnIdpCredential": true.toString(),
//       "returnSecureToken": true.toString()
//     },
//   ).catchError((err) {
//     return Future.error(err);
//   });

//   Map<String, dynamic> finalres = json.decode(fbAuthClient.body);

//   // print(finalres);
//   if (finalres.containsKey('error')) {
//     return Future.error(finalres);
//   }

//   if (onResponse != null) {
//     onResponse(_googleInfo);
//   }

//   await Future.delayed(Duration(seconds: 1)).then((value) {});
//   return FlavorUser.fromJson(finalres);
// }

// Future<FlavorUser> startOAuthMobile(
//     [void Function(FlavorAuthEmail params) onResponse]) async {
//   // ! Needs Impl

//   return Future.delayed(Duration(seconds: 1)).then((value) {});
// }
