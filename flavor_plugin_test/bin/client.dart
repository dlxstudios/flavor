import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flavor_plugin_test/redisserialise.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Utf8Encoder RedisSerialiseEncoder = Utf8Encoder();

Future<Response> _readHandler(Request request) {
  final message = request.params['message'];
  return jsonResponse({'message': message});
}

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

Future<void> main(List args) async {
  while (true) {}
  // ignore: dead_code
  exit(0);
}

extension on String {
  List<String> toRedisCommand() {
    return this.split(' ');
  }
}
