import 'dart:convert';
import 'dart:io';

import 'package:flavor_media/flavor_media.dart';
import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/material.dart' show CircularProgressIndicator;

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:regex_router/regex_router.dart';

import 'package:flavor_app/features/app/app.dart';
import 'package:flavor_app/features/page/page_error.dart';
import 'package:flavor_app/src/net_store_model.dart';
import 'package:flavor_app/src/net_storeage.dart';

class StoreTestApp extends StatelessWidget {
  const StoreTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return startFlavorMedia(
      FlavorApp(
        onGenerateRoute: RegexRouter.create({
          '': (_, a) => ScreenStoreHome(),
        }).generateRoute,
      ),
    );
  }
}

class ScreenStoreHome extends StatelessWidget {
  ScreenStoreHome({Key? key}) : super(key: key);

  final nstore = NetStore();

  @override
  Widget build(BuildContext context) {
    return FlavorScaffold(
      child: FutureBuilder<Map<String, dynamic>>(
          future: nstore.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return loading();
            }

            print('user ::${snapshot.error} ');

            return Container();

            // print('snapshot.hasError::${snapshot.hasError}');
            // writeObjects(snapshot.data);

            if (snapshot.hasError || snapshot.data!.containsKey('error')) {
              return error(snapshot.error ?? snapshot.data);
            }
            return ScreenStoreHomeBody(data: snapshot.data!);
          }),
    );
  }
}

Widget error(Object? error) {
  return FlavorPageError(message: error.toString(), code: '');
}

Widget loading() => Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );

class ScreenStoreHomeBody extends StatelessWidget {
  final Map<String, dynamic> data;
  const ScreenStoreHomeBody({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data.containsKey('items'));
    List dataItems = data['items'] as List;
    print(dataItems.length);
    List<StoreObjectModel> items = dataItems
        .map((a) => StoreObjectModel.fromMap(a as Map<String, dynamic>))
        .toList();
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: CardBox(
        borderRadius: 16,
        child: FlavorList(
          itemCount: items.length,
          builder: (context, index) {
            var item = items[index];
            return SizedBox(
              height: 200,
              child: FlavorContainerTile(
                headerTitle: item.name!,
                headerSubtitle: item.name!,
                footerTitle: item.name!,
                footerSubtitle: item.name!,
                body: Container(
                  color: FlavorColor(colorValue: FlavorColors.darkKhaki).value,
                  height: 200,
                  width: 200,
                ),
              ),
            );
          },
        ),
      ),
    );
    // print(iss.length);
    return Container();
    // return ListView.builder(
    //   itemBuilder: (context, index) => SizedBox(
    //     height: 60,
    //     child: ListTile(
    //       title: Text(items[index].name!),
    //     ),
    //   ),
    // );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/bucket.json');
}

Future<File> writeObjects(data) async {
  final file = await _localFile;
  print('file.path::${file.path}');
  return file.writeAsString(jsonEncode(data));
}
