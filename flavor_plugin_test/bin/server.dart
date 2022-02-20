import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:flavor_dartis/flavor_dartis.dart';

late final Client client;
const String userLocation = 'user';

Future<void> main(List args) async {
  client = await Client.connect('redis://localhost:6379');

  final commands = client.asCommands<String, String>();
// String title = await strings.get('book:24902:title');
// List<int> cover = await bytes.get('book:24902:cover');

  Future<Response> jsonResponse(Object ret) {
    return Future.value(
      Response.ok(
        jsonEncode(ret),
        headers: {'Content-Type': 'application/json'},
        context: {
          'context': 'flavor_server',
        },
      ),
    );
  }

  if (args.isNotEmpty) {
    for (var i = 0; i < args.length; i++) {
      var arg = (args[i] as String).toLowerCase();

      if (arg == 'flushall') {
        commands.flushall();
        print("Flushed all keys!");
        exit(0);
      }

      if (arg == 'keys') {
        var resp = await commands.keys('*');
        print(resp);
        exit(0);
      }

      if (arg == 'init') {
        print('createUser::$userLocation::0/1');
        commands.set('$userLocation::0', 'megan');
        commands.set('$userLocation::0:currentBalance', 1000.toString());
        commands.set('$userLocation::1', 'victor');
        commands.set('$userLocation::0:currentBalance', 1000.toString());

        exit(0);
      }

      if (arg == 'money') {
        Random random = new Random();

        var fomrUid = random.nextInt(2);
        var toUid = fomrUid == 1 ? 0 : 1;
        var transactionType = random.nextInt(2);
        var transactionAmount = random.nextInt(200);
        print(
            'Money::XADD mystream * type $transactionType amount $transactionAmount from_account $userLocation::$fomrUid');
        // _comm.send_object(["SET", '$userLocation::0', "0"]);
        commands.xadd('mystream', fields: {
          'type': transactionType.toString(),
          'amount': transactionAmount.toString(),
          'from_account': '$userLocation::$fomrUid',
          'to_account': '$userLocation::$toUid'
        });
        exit(0);
      }
    }
  }
  // final cpus = Platform.numberOfProcessors;
  // final cpus = 4;
  // for (int i = 0; i < cpus; i++) {
  //   Isolate.spawn(_startServer, {i.toString(): _comm});
  // }

// Configure routes.

  Future<Response> _rootHandler(Request request) async {
    List ret = await client.asCommands().keys("*");
    List allStreams = await client.asCommands().xrange('mystream', '-', '+');
    int streamLen = await client.asCommands().xlen('mystream');

    // return Response.ok('{"title" : "Hello, World!"}\n');
    return jsonResponse(
        {'keys': ret, 'streams': allStreams, 'streams::len': streamLen});
  }

  Future<Response> _echoHandler(Request request) async {
    final key = request.params['key'];

    Map<dynamic, List<StreamEntry?>>? message = await client.asCommands().xread(
          key: key!,
          count: 0,
          timeout: 0,
        );
    return jsonResponse(message!);
  }

  Future<Response> _readHandler(Request request) async {
    final Map<dynamic, List<StreamEntry?>>? message =
        await client.asCommands().xread(
      keys: ['mystream'],
      count: 0,
      timeout: 0,
    );
    return jsonResponse(message!);
  }

  Router _router = Router()
    ..get('/', _rootHandler)
    ..get('/echo/<message>', _echoHandler)
    ..get('/stream/read', _readHandler);

  void _startServer(Client client) async {
    // Use any available host or container IP (usually `0.0.0.0`).
    final ip = InternetAddress.anyIPv6;

    // Configure a pipeline that logs requests.
    final _handler = Pipeline().addMiddleware(logRequests(
      logger: (message, isError) {
        if (message.isNotEmpty) {
          print('Client#${client.hashCode} :: $message');
        }
      },
    )).addHandler(_router);

    // For running in containers, we respect the PORT environment variable.
    final port = int.parse(Platform.environment['PORT'] ?? '8080');
    final server = await serve(_handler, ip, port, shared: true);
    print('Server Client#${client.hashCode} listening on port ${server.port}');
  }

  _startServer(client);
}

extension on String {
  List<String> toRedisCommand() {
    return this.split(' ');
  }
}
