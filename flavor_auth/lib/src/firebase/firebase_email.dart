import 'dart:convert';
import 'dart:io';
import 'package:flavor_auth/src/models/user.dart';
import 'package:flavor_http/http.dart' as http;

var defaultHeaders = {
  // 'Content-Type': 'application/json',
};

class FlavorAuthEmailFirebase {
  // vars
  //
  final String googleApiKey;

  FlavorAuthEmailFirebase({required this.googleApiKey});
  // accounts:signUp
  //
  Future<FlavorUser> signUp(email, pass, passv) async {
    var url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$googleApiKey';
    // ignore: omit_local_variable_types
    Map<dynamic, dynamic> body = {
      'returnSecureToken': true.toString(),
      'email': email,
      'password': pass
    };
    try {
      // var response = await http.post(url, body: body);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      var response = await http.postJson(url, body);

      if (response != null) {
        var newUserAuth = await FlavorUser.fromMap(response);
        // print(newUserAuth);
        return newUserAuth;
      } else {
        return Future.error(response);
      }
    } catch (e) {
      return Future.error(e);
    }

    // return Future.error('Unknown error occured');
  }

  // accounts:signInWithPassword

  Future<FlavorUser> signInWithPassword(String email, String pass) async {
    var url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$googleApiKey';
    // ignore: omit_local_variable_types
    Map<dynamic, dynamic> body = {
      'returnSecureToken': true.toString(),
      'email': email,
      'password': pass
    };

    try {
      var response = await http.postJson(url, body);

      if (response != null) {
        var newUserAuth = await FlavorUser.fromMap(response);
        print(newUserAuth);
        return newUserAuth;
      } else {
        return Future.error(response);
      }
    } catch (e) {
      print('ERROR::HTTP - ${e.toString()}');
      return Future.error(e);
    }
  }

  /// Sign in with OAuth credential
  // accounts:signInWithIdp

  static Future<FlavorUser> signInWithIdp({
    required String providerId,
    required String identityToken,
    required String googleIdToken,
    required String googleApiKey,
  }) async {
    var url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=$googleApiKey';
    // ignore: omit_local_variable_types

    print('\n');
    print('\n');

    // return Future.value(FlavorUser());

    var body = json.encode(
      {
        'returnSecureToken': true,
        'returnIdpCredential': true,
        'requestUri': 'http://localhost',
        'postBody':
            'id_token=$identityToken&providerId=$providerId&access_token=$googleIdToken',
      },
    );

    try {
      var response = await http
          .postJson(url, body, headers: {'Content-Type': 'application/json'});

      if (response != null) {
        var newUserAuth = await FlavorUser.fromMap(response);
        print(newUserAuth);
        return newUserAuth;
      } else {
        return Future.error(response);
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
