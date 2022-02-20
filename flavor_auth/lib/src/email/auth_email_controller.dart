import 'package:flavor_auth/flavor_auth.dart';

class AuthController {
  FlavorUser? _user;
  void Function(FlavorUser? user)? onUserChange;
  late final FlavorAuthService authService;

  Future<FlavorUser> signUpWithEmailAndPassword({
    String? displayName,
    required String email,
    required String password,
    String? phone,
  }) async {
    return await authService
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
      return value;
    });
  }

  Future<FlavorUser> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // print(email);
    // print(password);
    return await authService
        .logInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      if (onUserChange != null) {
        onUserChange!(_user);
      }
      return value;
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
