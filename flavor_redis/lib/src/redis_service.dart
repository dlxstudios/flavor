import 'package:flavor_dartis/flavor_dartis.dart';

class RedisService {
  RedisService();

  late Client client;

  Future<void> start({
    String? host = 'localhost',
    int? port = 6379,
    String? username,
    String? password,
    RedisAuth? auth,
  }) async {
    client = await Client.connect('redis://$host:$port')
        .then((Client _client) async {
      if (auth != null) {
        await _client.run<String>(Command([
          'AUTH',
          auth.username,
          auth.password,
        ]));
      }
      return _client;
    });
  }
}

class RedisAuth {
  final String username, password;

  RedisAuth({required this.username, required this.password});
}
