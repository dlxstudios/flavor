import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: top_level_function_literal_block
final flavorAuthGoogleState = ChangeNotifierProvider((_) {
  return FlavorAuthGoogleState();
});

class FlavorAuthGoogleState extends ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleSignOut() => _googleSignIn.disconnect();

  FlavorAuthGoogleState() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      // account.authHeaders
      // user = FlavorUser
    });
    _googleSignIn.signInSilently();
  }

  bool _user;
  bool get user => _user;
  set useColor(value) {
    _user = value;
    notifyListeners();
  }
}
