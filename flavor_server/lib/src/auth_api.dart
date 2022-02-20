import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flavor_dartis/flavor_dartis.dart';
import 'package:flavor_server/auth_server.dart';
import 'package:flavor_server/src/logger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:flavor_redis/flavor_redis.dart';

import './utils.dart';

const String userEmailPrefix = 'auth::userLogin::byEmail::';
const String userIDPrefix = 'auth::userLogin::byId::';
const String userTokenPrefix = 'auth::token::';
const String userFlavorUserPrefix = 'auth::flavorUser::';

class AuthApi {
  RedisService redisService;

  AuthApi(this.redisService);

  Handler get router {
    final router = Router();

    final strings = redisService.client.asCommands<String, String>();
    final bytes = redisService.client.asCommands<String, List<int>>();
    router.get('/list/<path>', (Request req, String path) async {
      var data = await strings.keys(path);
      return Response.ok(data.toString());
    });

    router.get('/keys', (Request req) async {
      var data = await strings.keys('*');
      return jsonResponse({'items': data});
    });

    router.get('/keys/<path>', (Request req, String path) async {
      var data = await strings.get(path);
      // var data = await redisService.client.send_object(['FLUSHALL']);
      return Response.ok(data.toString());
    });

    router.delete('/keys', (Request req) async {
      var data = await strings.flushall();
      return Response.ok(true.toString());
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
          client: redisService.client, path: '$userEmailPrefix$email');

      if (userExist == true) {
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
        client: redisService.client,
        path: '$userEmailPrefix${_newUserLogin.email}',
        value: _newUserLogin.id!,
      );

      // await strings.set(
      //     '$userEmailPrefix${_newUserLogin.email}', _newUserLogin.id!);

      await RedisFunction.set(
        client: redisService.client,
        path: '$userIDPrefix${_newUserLogin.id}',
        value: _newUserLogin.toJson(),
      );

      // await strings.set(
      //     '$userIDPrefix${_newUserLogin.id}', _newUserLogin.toJson());

      final token =
          await createToken(secret: Env.secretKey, userId: _newUserLogin.id!);

      await saveToken(
        client: redisService.client,
        token: token,
        userTokenPath: '$userTokenPrefix${token.signed}',
      );

      // await strings.set('$userTokenPrefix${token.signed}', token.toJson());
      // await strings.expire(
      //     '$userTokenPrefix${token.signed}', token.expiry.inSeconds);

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
        client: redisService.client,
        path: '$userFlavorUserPrefix${_newUserLogin.id}',
        value: flavorUser.toJson(),
      );

      // await strings.set(
      //     '$userFlavorUserPrefix${_newUserLogin.id}', flavorUser.toJson());

      stopwatch.stop();
      logger.i('router.put executed in ${stopwatch.elapsed}');

      return Response.ok(flavorUser.toJson(), headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      });
    });

    // #Login
    router.post('/email', (Request req) async {
      // final stopwatch = Stopwatch()..start();

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
          client: redisService.client, path: '$userEmailPrefix$email');

      // final userExist = await strings.exists(key: '$userEmailPrefix$email');

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
        client: redisService.client,
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
          client: redisService.client,
          idPath: '$userEmailPrefix$email',
          dataPrefix: '$userIDPrefix',
        );
        final token =
            await createToken(secret: Env.secretKey, userId: userLogin.id!);

        await saveToken(
          client: redisService.client,
          token: token,
          userTokenPath: '$userTokenPrefix${token.signed}',
        );

        var flavorUserJson = await RedisFunction.get(
            client: redisService.client,
            path: '$userFlavorUserPrefix${userLogin.id!}');

        var flavorUser = FlavorUser.fromJson(flavorUserJson);

        // stopwatch.stop();
        // logger.i('router.post(/email) executed in ${stopwatch.elapsed}');
        return Response.ok(flavorUser.toJson(), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      } catch (e) {
        // logger.e(e);
        return Response.internalServerError(
            body: 'There was a problem logging you in. Please try again.');
      }
    });

    router.get('/user', (Request req) async {
      var yea = req.context['authDetails'] as JWT?;

      if (yea == null) {
        return Response.notFound({'error': 'not auth'}.toString());
      }

      var userId = yea.subject;

      var userLoginJson = await RedisFunction.get(
        client: redisService.client,
        path: '$userIDPrefix$userId',
      );
      var userLogin = UserLogin.fromJson(userLoginJson);

      var userJson = await RedisFunction.get(
        client: redisService.client,
        path: '$userFlavorUserPrefix${userLogin.id}',
      );

      var user = FlavorUser.fromJson(userJson);

      return jsonResponse(user.toMap());
    });

    final handler = Pipeline().addHandler(router);
    return handler;
  }
}

Future<bool> _UserExist({required Client client, required String path}) async {
  return await RedisFunction.exist(client: client, path: path);
}

Future<UserLogin> _UserLoginGet({
  required Client client,
  required String idPath,
  required String dataPrefix,
}) async {
  var _id = await RedisFunction.get(client: client, path: idPath);

  var _login = await RedisFunction.get(client: client, path: '$dataPrefix$_id');

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
  required Client client,
  required Token token,
  required String userTokenPath,
}) async {
  var commands = client.asCommands<String, String>();
  // await commands.multi();
  // await commands.set(userTokenPath, token.toJson());
  // await commands.expire(userTokenPath, token.expiry.inSeconds);
  // return await commands.exec();

  await commands.set('$userTokenPath${token.signed}', token.toJson());
  await commands.expire(
      '$userTokenPath${token.signed}', token.expiry.inSeconds);
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
        'authDetails': jwt,
      });

      // logger.i(jwt);
      return await innerHandler(updatedRequest);
      // return innerHandler(request);
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

JWT? verifyJwt(String token, String secret) {
  try {
    final jwt = JWT.verify(token, SecretKey(secret));
    return jwt;
  } on JWTExpiredError {
    // TODO Handle error
  } on JWTError catch (err) {
    // TODO Handle error
  }
}
