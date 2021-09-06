import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class FlavorFirestoreRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference list(String path) =>
      FirebaseFirestore.instance.collection(path);
  void getDoc(path) => FirebaseFirestore.instance.doc(path);
  void setDoc(path, data) => {FirebaseFirestore.instance.doc(path).set(data)};

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

  // Future<List<Map<String, dynamic>>> getCollection(String collection) {
  //   print('***_ getCollection _***');

  //   CollectionReference ref = FirebaseFirestore.instance.collection(collection);

  //   return ref.get().then((QuerySnapshot value) {
  //     print(
  //         "Get collection : $collection \n docs.length : ' ${value.docs.length} ' ");
  //     List<Map<String, dynamic>> _tmp = [];
  //     for (var i = 0; i < value.docs.length; i++) {
  //       // _tmp.add({"id": value.docs[i].id, ...value.docs[i].data()});
  //       _tmp.add(value.docs[i].data() as Map<String, dynamic>);
  //     }
  //     return _tmp;
  //   }).catchError((error) {
  //     print("Get collection : $collection");

  //     return Future.error({
  //       "message": "Failed to get data from collection : $collection",
  //       error: error
  //     });
  //   });
  // }

  Future<Map<String, dynamic>> getCollection(String collection) {
    print('***_ getCollection _***');

    CollectionReference ref = FirebaseFirestore.instance.collection(collection);

    return ref.get().then((QuerySnapshot value) {
      print(
          "Get collection : $collection \n docs.length : ' ${value.docs.length} ' ");
      List<Map<String, dynamic>> _tmp = [];
      for (var i = 0; i < value.docs.length; i++) {
        // _tmp.add({"id": value.docs[i].id, ...value.docs[i].data()});
        _tmp.add(value.docs[i].data() as Map<String, dynamic>);
      }
      return {'items': _tmp};
    }).catchError((error) {
      print("Get collection : $collection");

      return Future.error({
        "message": "Failed to get data from collection : $collection",
        error: error
      });
    });
  }

  Future<Map<String, dynamic>> getDocument(String collection, {String? path}) {
    print('***_ SKII _***');
    print('$collection \n $path');
    print('***_ SKII _***');

    CollectionReference ref = FirebaseFirestore.instance.collection(collection);

    return ref.doc(path).get().then((value) {
      print(
          "Get path : $path from collection : $collection \n data : ' ${value.data()} ' ");
      // return Future.value({"id": value.id, ...?value.data()});
      return Future.value(value.data() as Map<String, dynamic>);
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

  Stream<DocumentSnapshot> streamDocument(String collection, String path,
      {bool? includeMetadataChanges}) {
    CollectionReference ref = FirebaseFirestore.instance.collection(collection);
    return ref
        .doc(path)
        .snapshots(includeMetadataChanges: includeMetadataChanges!);
  }

  Stream streamCollection(
    String collection, {
    bool? includeMetadataChanges,
    String? orderBy,
    int? limit,
    dynamic where,
    dynamic isEqualTo,
    dynamic isNotEqualTo,
    dynamic isLessThan,
    dynamic isLessThanOrEqualTo,
    dynamic isGreaterThan,
    dynamic isGreaterThanOrEqualTo,
    dynamic arrayContains,
    List<dynamic>? arrayContainsAny,
    List<dynamic>? whereIn,
    List<dynamic>? whereNotIn,
    bool? isNull,
  }) {
    CollectionReference ref = FirebaseFirestore.instance.collection(collection);
    // if (orderBy != null) {
    //   ref.orderBy(orderBy);
    // }
    // if (limit != null) {
    //   ref.limit(limit);
    // }
    // if (limit != null) {
    //   ref.where(where);
    // }
    return ref.snapshots(includeMetadataChanges: includeMetadataChanges!);
  }
}
