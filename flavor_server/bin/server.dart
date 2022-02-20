import 'dart:convert';

import 'package:flavor_dartis/flavor_dartis.dart';
import 'package:flavor_redis/flavor_redis.dart';
import 'package:flavor_server/auth_server.dart';

import 'package:flavor_server/src/logger.dart';

void main(List<String> arguments) async {
  final app = Router();

  final authServer = AuthServer(app);
  await authServer.init();
  await serve(authServer.serverHandler(), 'localhost', authServer.port);

  logger.v('HTTP Service running on http://localhost:${authServer.port}');
}

class KeysDecoder extends Decoder<ArrayReply, List<String>> {
  @override
  List<String> convert(ArrayReply value, [RedisCodec? codec]) => [];
}

class AuthServer {
  final secret = Env.secretKey;
  final port = Env.serverPort;
  final Router app;
  AuthServer(this.app);
  final redisService = RedisService();

  Future<void> init() async {
    await redisService
        .start(
      host: Env.redisHost,
      port: Env.redisPort,
      auth: RedisAuth(
        username: Env.redisUsername,
        password: Env.redisPassword,
      ),
    )
        .then((value) {
      print('Redis is connected to ${Env.redisHost}');
    });
    // final commands = redisService.client.asCommands<String, String>();
    // await commands.flushall();
    // await commands.set('one', 'abc');
    // redisService.client.codec.register(decoder: KeysDecoder());
    // final commandsList = redisService.client.asCommands<String, List<String>>();
    // var keys = await commandsList.keys2('*');
    // print(keys);

    // var magic = await commands.get('one');
    // print(magic);

    // var allStreams = await commands.xrange('racks', '-', '+', count: 5,);
    // print('allStreams::$allStreams');

    // var ss = await commands.set('magic', 'yessirskii');
    // var magic = await commands.get('magic');
    // print(magic);

    // var fif = await commands.xadd(
    //   'player::1::account::0',
    //   fields: {'amount': '100'},
    // );
    // print(fif);

    // await commands.xadd('player::1::account::0', fields: {'amount': '600'});

    // var fif2 = await commands.xrange('player::1::account::0', '-', '+');
    // print(fif2.last!.fields['amount']);
    // var stream = await commands.xread(key: 'player::1::account::0', id: '0-0');

    // if (stream != null) {
    // print(stream);
    // }

    final commandsList =
        redisService.client.asCommands<String, List<String?>>();
    var ret = await commandsList.keys('*');
    print(ret);
  }

  Handler serverHandler() {
    final commands = redisService.client.asCommands<String, String>();

    app.mount(
      '/auth/',
      AuthApi(redisService).router,
    );

    app.mount('/assets/', StaticAssetsApi('public').router);

    app.get('/', (Request req) async {
      final commandsList =
          redisService.client.asCommands<String, List<String>>();
      var streams = await commandsList.keys('*');
      return jsonResponse({'streams': streams});
    });

    // app.all('/<name|.*>', fallback('public/index.html'));
    app.all('/<name|.*>', (req, res) {
      return Response.notFound(jsonEncode({
        'error': {'message': 'Unable to find path'}
      }));
    });

    final handler = Pipeline()
        // .addMiddleware(logRequests())
        .addMiddleware(handleCors())
        .addMiddleware(handleAuth(secret))
        .addHandler(app);

    return handler;
  }
}
