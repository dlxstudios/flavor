// import 'package:mongo_dart/mongo_dart.dart';
import 'package:flavor_server/src/config.dart';

void main(List<String> args) async {
  // var _uri =
  //     'mongodb://flavorserver:${Env.mongoPassword}@flavorservercluster-shard-00-00.kz5n2.gcp.mongodb.net:27017,flavorservercluster-shard-00-01.kz5n2.gcp.mongodb.net:27017,flavorservercluster-shard-00-02.kz5n2.gcp.mongodb.net:27017/myFirstDatabase?ssl=true&replicaSet=atlas-jejev3-shard-0&authSource=admin&retryWrites=true&w=majority';
  // 'mongodb+srv://${Env.mongoUser}:${Env.mongoPassword}@${Env.mongoUrl}/${Env.mongoDb}?retryWrites=true&w=majority';
  // Db db;
  // db = await Db.create(_uri);
  // // logger.w(db.isConnected);
  // await db.open();
  // var ii = await db.listDatabases();
  // print(ii);

  // logger.w(db.isConnected);
  var _uri =
      // 'mongodb://flavorserver:${Env.mongoPassword}@flavorservercluster-shard-00-00.kz5n2.gcp.mongodb.net:27017,flavorservercluster-shard-00-01.kz5n2.gcp.mongodb.net:27017,flavorservercluster-shard-00-02.kz5n2.gcp.mongodb.net:27017/?ssl=true&replicaSet=atlas-jejev3-shard-0&authSource=admin&retryWrites=true&w=majority';
      'mongodb+srv://${Env.mongoUser}:${Env.mongoPassword}@${Env.mongoUrl}/${Env.mongoDb}?retryWrites=true&w=majority';
  // Db db;
  // db = await Db.create(_uri);

  // await db.open(
  //     // secure: true,
  //     // tlsAllowInvalidCertificates: true,
  //     );
  // await db
  //     .collection('media')
  //     .insert({'title': 'one up'}).then((value) => logger.i('done'));
}
