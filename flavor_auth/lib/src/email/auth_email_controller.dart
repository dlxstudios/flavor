import 'dart:developer';

import 'package:flavor_auth/flavor_auth.dart';

class AuthController {
  FlavorUser? _user;

  void Function(FlavorUser? user)? onUserChange;

  AuthController({
    this.onUserChange,
    required this.authService,
  });
  // ignore: unnecessary_getters_setters
  FlavorUser? get user => _user;
  // ignore: unnecessary_getters_setters
  set user(FlavorUser? user) => _user = user;
  final FlavorAuthService authService;

  Future<void> signUpWithEmailAndPassword({
    required String displayName,
    required String email,
    required String password,
    String? phone,
  }) async {
    _user = await authService
        .signUpWithEmailAndPassword(
      displayName: displayName,
      email: email,
      password: password,
      phone: phone,
    )
        .then((value) {
      if (onUserChange != null) {
        onUserChange!(_user);
      }
    });
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    print(email);
    print(password);
    _user = await authService
        .logInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      if (onUserChange != null) {
        onUserChange!(_user);
      }
    });
  }

  Future<void> signInAnonymously() async {
    return authService.signInAnonymously().then((value) {
      if (onUserChange != null) {
        onUserChange!(_user);
      }
    });
  }
}
