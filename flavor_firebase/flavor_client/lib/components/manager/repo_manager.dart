import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

// ignore: implementation_imports
import 'package:flavor_auth/src/models/user.dart';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

String defaultStorageRef = '_testMediaUpload';

late FlavorFileManager fileManagerInstance;

ChangeNotifierProvider<FlavorFileManager> fileManagerProvider(
        FlavorUser user) =>
    ChangeNotifierProvider((_) {
      return FlavorFileManager(user);
    });

class FlavorFileManager extends ChangeNotifier {
  final FlavorUser user;

  FlavorFileManager(this.user) {
    print('FlavorFileManager for ${user.email}');
  }
//
  late List<FlavorLocalFile> _filesQueue;

  List<FlavorLocalFile> get filesUploadQueue => _filesQueue;
  set filesUploadQueue(List<FlavorLocalFile> newFiles) {
    _filesQueue = newFiles;
    print('newFiles ${newFiles.length}');
    notifyListeners();
  }

  bool pause = false;
//
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
//
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
//
  Future<void> getUserFiles() async {
    String link = '/$defaultStorageRef/${user.email}';
    // print(link);
    var result = await firebase_storage.FirebaseStorage.instance;
    // print('^GETMEDIA::result.items.length ');
    // print('^ -  ${result.items.length}');

    // result.items.forEach((Reference ref) {
    //   print('Found file: $ref');
    // });

    // result.prefixes.forEach((Reference ref) {
    //   print('Found directory: $ref');
    // });
    // return result;
  }
  //

  beginUploads() async {
    print('FlavorFileManager::beginUploads - Starting uploads....');

    if (pause) return;

    if (filesUploadQueue.length > 0) {
      for (var i = 0; i < filesUploadQueue.length; i++) {
        filesUploadQueue[i].uploadProcess(user.email!);
        notifyListeners();
      }
    }
  }
}

class FlavorLocalFile {
  late final PlatformFile fileInfo;
  late FutureOr<UploadTask> uploadtask;
  late UploadTask ref;
  late DocumentReference doc;

  FlavorLocalFile({required this.fileInfo});

  Future<UploadTask>? uploadProcess(String userID) async {
    //
    // Upload the raw data with custom Meta tags
    //
    uploadtask = uploadData(
      '/$defaultStorageRef/$userID/${fileInfo.name}',
      fileInfo.bytes!,
    )
        //
        // Then, get meta data, and the download URL and create an entry in the the data base under 'media_uploaded'
        //
        // ignore: missing_return
        .then((value) async {
      var meta = await value.then((value) => value.metadata!.customMetadata);
      var url = await value.then((value) => value.ref.fullPath);
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference firebaseObject =
          await firestore.collection('media_uploaded').add({
        'meta': meta,
        'url': url,
        'owner': userID,
        'published': false,
        'publishedId': null,
        'title': fileInfo.name,
        'fileName': fileInfo.name,
        'sizeInBytes': fileInfo.size,
      });
      doc = firebaseObject;
      throw '';
    });

    return Future.value(uploadtask);
  }
}

// customMetadata: {
//           'owner_id': userID,
//           'size': this.fileInfo.size.toString(),
//         },

Future<UploadTask> uploadData(String path, List<int> encoded,
    [FullMetadata? metaData]) async {
  Uint8List data = Uint8List.fromList(encoded);
  // firebase_storage.StorageReference ref = firebase_storage.StorageReference;
  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child('playground');

  try {
    print('- starting upload of ${ref.fullPath}');
    // Upload raw data.
    return Future.value(
        ref.putData(data, SettableMetadata(customMetadata: {})));
  } on FirebaseException catch (e) {
    // e.g, e.code == 'canceled'
    print('- Error uploading ${ref.fullPath}');
    print(e);
    return Future.error(e);
    //
  }
}
