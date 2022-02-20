import 'package:flavor_dartis/flavor_dartis.dart';

class RedisFunction {
  static Future<bool> exist(
      {required Client client,
      required String path,
      List args = const []}) async {
    return await client.asCommands<String, String>().exists(key: path).then(
          (value) => value == 1 ? true : false,
        );
  }

  static Future get(
      {required Client client,
      required String path,
      List args = const []}) async {
    return await client.asCommands<String, String>().get(path);
  }

  static Future set(
      {required Client client,
      required String path,
      required String value}) async {
    return await client.asCommands<String, String>().set(path, value);
  }

// ignore: todo
//TODO:: impliment EXPIRE
  static Future expire(
      {required Client client,
      required String path,
      required Duration duration}) async {
    return await client
        .asCommands<String, String>()
        .expire(path, duration.inSeconds);
  }

  static Future add(
      {required Client client,
      required String path,
      required String value}) async {
    return await client.asCommands<String, String>().lpush(path, value: value);
  }

  static Future list({
    required Client client,
    required String path,
    int start = 0,
    int end = -1,
  }) async {
    return await client.asCommands<String, String>().lrange(path, start, end);
  }
}
