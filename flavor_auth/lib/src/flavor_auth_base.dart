import 'dart:async';

import 'package:flavor_auth/src/email.dart';
import 'package:flavor_auth/src/models/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository(String gAPIKey) {
    _fue = FlavorAuthEmail(googleApiKey: gAPIKey);
  }

  late FlavorAuthEmail _fue;

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<FlavorUser> loginEmail(
    String username,
    String password,
  ) async {
    assert(username != null);
    assert(password != null);

    // await Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );

    return _fue.signInWithPassword(username, password);
  }

  Future<FlavorUser> signupEmail(
      String username, String password, String passwordReEnter) async {
    assert(username != null);
    assert(password != null);
    assert(passwordReEnter != null);

    // await Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );

    return await _fue.signUp(username, password, passwordReEnter);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

/// UserModel
class UserModel {
  final String id;
  String? permalink;
  String? username;
  final String email;
  String? avatarURL;
  String? country;
  String? fullName;
  String? city;
  String? description;
  bool? online;

  int? followersCount;
  List<String>? followers;
  int? followingsCount;
  List<String>? following;

  int? likesCount;
  List<String>? liked;

  UserModel({required this.id, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'permalink': permalink,
      'username': username,
      'email': email,
      'avatarURL': avatarURL,
      'country': country,
      'fullName': fullName,
      'city': city,
      'description': description,
      'online': online,
      'followersCount': followersCount,
      'followers': followers,
      'followingsCount': followingsCount,
      'following': following,
    };
  }
}
