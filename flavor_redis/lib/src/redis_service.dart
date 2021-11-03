import 'package:redis/redis.dart';

class RedisService {
  RedisService();

  final RedisConnection redis = RedisConnection();
  late Command command;

  Future<void> start(String host,
      [int? port, String? username, String? password]) async {
    await redis.connect(host, port).then((_command) async {
      await _command.send_object([
        'AUTH',
        'flavor_server',
        'dlxOne1!',
      ]);
      command = _command;
    });
  }
}
