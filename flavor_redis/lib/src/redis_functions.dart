import 'package:redis/redis.dart';

class RedisFunction {
  static Future<bool> exist(
      {required Command command,
      required String path,
      List args = const []}) async {
    return await command.send_object(['EXISTS', path]) == 1 ? true : false;
  }

  static Future get(
      {required Command command,
      required String path,
      List args = const []}) async {
    return await command.send_object(['GET', path, ...args]);
  }

  static Future set(
      {required Command command,
      required String path,
      required String value}) async {
    return await command.set(path, value);
  }

//TODO:: impliment EXPIRE
  static Future expire(
      {required Command command,
      required String path,
      required String value}) async {
    return await command.set(path, value);
  }
}
