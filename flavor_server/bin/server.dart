import 'dart:convert';

import 'package:flavor_redis/flavor_redis.dart';
import 'package:flavor_server/auth_server.dart';

import 'package:flavor_server/src/logger.dart';

void main(List<String> arguments) async {
  final app = Router();

  final authServer = AuthServer(app);

  await serve(await authServer.start(), 'localhost', authServer.port);

  logger.v('HTTP Service running on http://0.0.0.0:${authServer.port}');
}

class AuthServer {
  final secret = Env.secretKey;
  final port = Env.serverPort;
  final Router app;
  AuthServer(this.app);

  Future<Handler> start() async {
    final redisService = RedisService();

    await redisService.start(Env.redisHost, Env.redisPort);

    app.mount(
      '/auth/',
      AuthApi(redisService).router,
    );

    app.mount('/assets/', StaticAssetsApi('public').router);

    // app.all('/<name|.*>', fallback('public/index.html'));
    app.all('/<name|.*>', (req, res) {
      return Response.notFound(jsonEncode({
        'error': {'message': 'Unable to find path'}
      }));
    });

    final handler = Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(handleCors())
        .addMiddleware(handleAuth(secret))
        .addHandler(app);

    return handler;
  }
}
