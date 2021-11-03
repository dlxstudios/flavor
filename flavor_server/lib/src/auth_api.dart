import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flavor_redis/flavor_redis.dart';
import 'package:redis/redis.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:flavor_server/auth_server.dart';
import 'package:flavor_server/src/logger.dart';

import './utils.dart';

var userEmailPrefix = 'user::email::';
var userIDPrefix = 'user::id::';
var userTokenPrefix = 'user::token::';
var userFlavorUserPrefix = 'user::flavorUser::';

class AuthApi {
  RedisService redisService;

  AuthApi(this.redisService);

  Handler get router {
    final router = Router();

    router.get('/keys', (Request req) async {
      var data = await redisService.command.send_object(['KEYS', '*']);
      return Response.ok(data.toString());
    });

    router.get('/keys/<path>', (Request req, String path) async {
      var data = await redisService.command.send_object(['Get', path]);
      // var data = await redisService.command.send_object(['FLUSHALL']);
      return Response.ok(data.toString());
    });

    router.delete('/keys', (Request req) async {
      var data = await redisService.command.send_object(['FLUSHALL']);
      return Response.ok(data.toString());
    });

    router.put('/email', (Request req) async {
      final stopwatch = Stopwatch()..start();

      final payload = await req.readAsString();
      final userInfo = json.decode(payload);
      final email = userInfo['email'];
      final password = userInfo['password'];

      // Ensure email and password fields are present
      if (email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty) {
        return Response(HttpStatus.badRequest,
            body: 'Please provide your email and password');
      }

      final userExist = await _UserExist(
          command: redisService.command, path: '$userEmailPrefix$email');

      if (userExist) {
        logger.i('router.put(/api/users) executed in ${stopwatch.elapsed}');
        return Response(HttpStatus.badRequest, body: 'User already exists');
      }

      // Create user
      final salt = generateSalt();
      final hashedPassword = hashPassword(password, salt);

      final _newUserLogin = UserLogin(
        email: email,
        hashedPassword: hashedPassword,
        salt: salt,
      );

      await RedisFunction.set(
        command: redisService.command,
        path: '$userEmailPrefix${_newUserLogin.email}',
        value: _newUserLogin.id!,
      );

      await RedisFunction.set(
        command: redisService.command,
        path: '$userIDPrefix${_newUserLogin.id}',
        value: _newUserLogin.toJson(),
      );

      final token =
          await createToken(secret: Env.secretKey, userId: _newUserLogin.id!);

      await saveToken(
        command: redisService.command,
        token: token,
        userTokenPath: '$userTokenPrefix${token.signed}',
      );

      var flavorUser = FlavorUser(
        email: _newUserLogin.email,
        displayName: userInfo['displayName'],
        firstName: userInfo['firstName'],
        lastName: userInfo['lastName'],
        phoneNumber: userInfo['phoneNumber'],
        localId: _newUserLogin.id,
        providerId: 'com.flavor.auth.email',
        photoUrl: userInfo['photoUrl'],
        refreshToken: token.signed,
      );

      await RedisFunction.set(
        command: redisService.command,
        path: '$userFlavorUserPrefix${_newUserLogin.id}',
        value: flavorUser.toJson(),
      );

      stopwatch.stop();
      logger.i('router.put executed in ${stopwatch.elapsed}');

      return Response.ok(flavorUser.toJson(), headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      });
    });

    // #Login
    router.post('/email', (Request req) async {
      final stopwatch = Stopwatch()..start();

      final payload = await req.readAsString();
      final userInfo = json.decode(payload);
      final email = userInfo['email'];
      final password = userInfo['password'];

      // Ensure email and password fields are present
      if (email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty) {
        return Response(HttpStatus.badRequest,
            body: jsonEncode({
              'error': {
                'message': 'Please provide your email and password',
                'code': 404,
              }
            }),
            headers: {
              HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
            });
      }

      final userExist = await _UserExist(
          command: redisService.command, path: '$userEmailPrefix$email');
      if (!userExist) {
        return Response.notFound(
            jsonEncode({
              'error': {
                'message': 'Incorrect user and/or password',
                'code': 404,
              }
            }),
            headers: {
              HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
            });
      }

      var userLogin = await _UserLoginGet(
        command: redisService.command,
        idPath: '$userEmailPrefix$email',
        dataPrefix: '$userIDPrefix',
      );

      final hashedPassword = hashPassword(password, userLogin.salt);
      if (hashedPassword != userLogin.hashedPassword) {
        return Response.forbidden(
            jsonEncode({
              'error': {
                'message': 'Incorrect user and/or password',
                'code': 404,
              }
            }),
            headers: {
              HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
            });
      }

      try {
        var userLogin = await _UserLoginGet(
          command: redisService.command,
          idPath: '$userEmailPrefix$email',
          dataPrefix: '$userIDPrefix',
        );
        final token =
            await createToken(secret: Env.secretKey, userId: userLogin.id!);

        await saveToken(
          command: redisService.command,
          token: token,
          userTokenPath: '$userTokenPrefix${token.signed}',
        );

        var flavorUserJaon = await RedisFunction.get(
            command: redisService.command,
            path: '$userFlavorUserPrefix${userLogin.id!}');

        var flavorUser = FlavorUser.fromJson(flavorUserJaon);

        stopwatch.stop();
        logger.i('router.post(/email) executed in ${stopwatch.elapsed}');
        return Response.ok(flavorUser.toJson(), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      } catch (e) {
        // logger.e(e);
        return Response.internalServerError(
            body: 'There was a problem logging you in. Please try again.');
      }
    });

    var index = router.get('/', (Request req) async {
      var yea = req.context['authDetails'] as JWT;
      // var data = await redisService.command.send_object(['KEYS', '*']);
      return Response.ok(yea.payload);
    });

    final handler = Pipeline().addHandler(router);
    return handler;
  }
}

Future<bool> _UserExist(
    {required Command command, required String path}) async {
  return await RedisFunction.exist(command: command, path: path);
}

Future<UserLogin> _UserLoginGet({
  required Command command,
  required String idPath,
  required String dataPrefix,
}) async {
  var _id = await RedisFunction.get(command: command, path: idPath);

  var _login =
      await RedisFunction.get(command: command, path: '$dataPrefix$_id');

  var login = UserLogin.fromJson(_login);

  return login;
}

Future<Token> createToken({
  required String userId,
  required String secret,
  String issuer = 'http://localhost',
}) async {
  return Token(
    subject: userId,
    issuer: issuer,
    secret: secret,
  );
}

Future saveToken({
  required Command command,
  required Token token,
  required String userTokenPath,
}) async {
  return await command.multi().then((Transaction trans) {
    // trans.send_object(["SET", userTokenPath, token.toJson()]);
    trans.send_object(['SET', userTokenPath, token.toJson()]);
    trans.send_object(['EXPIRE', userTokenPath, token.expiry.inSeconds]);
    trans.exec();
  });

  // return varr;
}

Middleware handleAuth(String secret) {
  return (Handler innerHandler) {
    return (Request request) async {
      final authHeader = request.headers['authorization'];
      var token, jwt;

      if (authHeader != null && authHeader.startsWith('Bearer ')) {
        token = authHeader.substring(7);
        jwt = verifyJwt(token, secret);
      }

      final updatedRequest = request.change(context: {
        // 'authDetails': jwt,
      });

      logger.i(jwt);
      return await innerHandler(updatedRequest);
    };
  };
}

Middleware isAuthorized() {
  return createMiddleware(
    requestHandler: (Request request) {
      if (request.context['authDetails'] == null) {
        return Response.forbidden('Not authorised to perform this action.');
      }
      return null;
    },
  );
}

dynamic verifyJwt(String token, String secret) {
  try {
    final jwt = JWT.verify(token, SecretKey(secret));
    return jwt;
  } on JWTExpiredError {
    // TODO Handle error
  } on JWTError catch (err) {
    // TODO Handle error
  }
}
