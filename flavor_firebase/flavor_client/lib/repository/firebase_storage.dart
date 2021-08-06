import 'package:firebase_storage/firebase_storage.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FlavorFirebaseStorageRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  FutureOr<DocumentReference> add(String collection,
      {Map<String, dynamic> data = const {}}) {
    CollectionReference ref = FirebaseFirestore.instance.collection(collection);
    return ref.add(data).then((value) {
      print("Added to $collection \n ' $data ' ");
      return value;
    }).catchError((error) {
      print("Failed to add data: \n ' $error ' ");
      return Future.error({"message": "Failed to add data:  ' ", error: error});
    });
  }

  Future<List<Map<String, dynamic>>> getCollection(String collection) {
    print('***_ getCollection _***');

    CollectionReference ref = FirebaseFirestore.instance.collection(collection);

    return ref.get().then((QuerySnapshot value) {
      print(
          "Get collection : $collection \n docs.length : ' ${value.docs.length} ' ");
      List<Map<String, dynamic>> _tmp = [];
      for (var i = 0; i < value.docs.length; i++) {
        // _tmp.add({"id": value.docs[i].id, ...value.docs[i].data()});
      }
      return _tmp;
    }).catchError((error) {
      print("Get collection : $collection");

      return Future.error({
        "message": "Failed to get data from collection : $collection",
        error: error
      });
    });
  }

  Future<Map<String, dynamic>> getDocument(String? path) {
    print('getDocument from Path :: $path');

    FirebaseFirestore ref = FirebaseFirestore.instance;

    return ref.doc(path!).get().then((value) {
      return Future.value({"id": value.id, ...value.data()!});
    }).catchError((error) {
      print("Failed to get data from collection :  Path: $path \n ' $error ' ");

      return Future.error({
        "message": "Failed to get data from collection :  Path: $path",
        error: error
      });
    });
  }

  Future<bool> delete(String collection, String path) {
    CollectionReference ref = FirebaseFirestore.instance.collection(collection);
    return ref.doc(path).delete().then((_) {
      print("Deleted path : $path from collection : $collection \n ' done ' ");
      return Future.value(true);
    }).catchError((error) {
      print(
          "Failed to get data from collection : $collection \n Path: $path \n ' $error ' ");
      return Future.error({
        "message":
            "Failed to get data from collection : $collection \n Path: $path",
        error: error
      });
    });
  }

  Stream<DocumentSnapshot>? streamDocument(String collection, String path,
      {bool? includeMetadataChanges}) {}
}
