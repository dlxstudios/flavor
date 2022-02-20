import 'dart:developer';

import 'package:flavor_auth/flavor_auth.dart';
import 'package:flavor_http/http.dart';
import 'package:flavor_redis/flavor_redis.dart';

class FlavorAuthService {
  final String baseUrl;

  FlavorAuthService({this.baseUrl = 'http://localhost:8547/auth'});

  Future<FlavorUser> signUpWithEmailAndPassword({
    String? displayName,
    required String email,
    required String password,
    String? phone,
  }) async {
    return await fetchJson(
      '$baseUrl/email',
      method: FlavorHttpMethod.put,
      body: {'email': email, 'password': password},
    ).then((value) {
      return FlavorUser.fromMap(value);
    });
  }

  Future<FlavorUser> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await fetchJson(
      '$baseUrl/email',
      method: FlavorHttpMethod.post,
      body: {'email': email, 'password': password},
    ).then((value) {
      return FlavorUser.fromMap(value);
    });
  }

  Future<void> signInAnonymously() async {}
}

class FlavorAuthRedisService {
  final String loc;

  FlavorAuthRedisService(this.loc);
  late final RedisService redisService;

  // ignore: always_declare_return_types
  connect({required String redisHost, required int redisPort}) async {
    redisService = RedisService();
    await redisService.start(host: redisHost, port: redisPort);
  }

  Future<void> signUpWithEmailAndPassword(
      {String? displayName,
      required String email,
      required String password,
      String? phone}) async {}

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {}

  Future<void> signInAnonymously() async {}
}
