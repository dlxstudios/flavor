import 'dart:async';

import 'package:flavor_auth/flavor_auth.dart';

abstract class BaseAuthRepository {
  Future<void> signInAnonymously();
  FlavorUser? getCurrentUser();
  Future<void> signOut();
}

class FlavorAuthEmailRepository implements BaseAuthRepository {
  @override
  Future<void> signInAnonymously() async {
    // await fbAuth.signInAnonymously();
    // .then((cred) => FlavorUser(
    //       email: cred.user!.email,
    //       isAnonymous: true,
    //       localId: cred.user!.uid,
    //       refreshToken: cred.user!.refreshToken,
    //     ));
  }

  @override
  FlavorUser? getCurrentUser() {
    // return fbAuth.currentUser;
    // return _read(firebaseAuthProvider).currentUser;
  }

  @override
  Future<void> signOut() async {
    // await _read(firebaseAuthProvider).signOut();
    // await fbAuth.signOut();
    // return signInAnonymously().then((value) {
    //   return FlavorUser(
    //     displayName: value.user!.displayName,
    //     email: value.user!.email,
    //     emailVerified: value.user!.emailVerified,
    //     localId: value.user!.uid,
    //     photoUrl: value.user!.photoURL,
    //     refreshToken: value.user!.refreshToken,
    //   );
    // });
  }

  Future<FlavorUser> signUpWithEmailAndPassword({
    required String displayName,
    required String email,
    required String password,
    String? phone,
  }) async {
    return FlavorUser();
  }

  Future<FlavorUser> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return FlavorUser();
  }
}
