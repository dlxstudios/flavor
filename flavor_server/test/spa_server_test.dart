import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flavor_server/src/config.dart';
import 'package:test/test.dart';

void main() {
  test('it should return a 200 response', () async {
    final response =
        await http.get(Uri.parse('http://localhost:${Env.serverPort}/_status'));
    expect(response.statusCode, HttpStatus.ok);
  });
}
