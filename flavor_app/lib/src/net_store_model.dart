import 'dart:convert';

class StoreObjectModel {
  String get kind => "storage#object";
  final String? id;
  final String? selfLink;
  final String? name;
  final String? bucket;
  final String? generation;
  final String? metageneration;
  final String? contentType;
  final String? timeCreated;
  final String? updated;
  final String? customTime;
  final String? timeDeleted;
  final String? temporaryHold;
  final String? eventBasedHold;
  final String? retentionExpirationTime;
  final String? storageClass;
  final String? timeStorageClassUpdated;
  final String? size;
  final String? md5Hash;
  final String? mediaLink;
  final String? contentEncoding;
  final String? contentDisposition;
  final String? contentLanguage;
  final String? cacheControl;
  final String? metadata;
  final String? acl;

  final String? etag;

  StoreObjectModel(
      {this.id,
      this.selfLink,
      this.name,
      this.bucket,
      this.generation,
      this.metageneration,
      this.contentType,
      this.timeCreated,
      this.updated,
      this.customTime,
      this.timeDeleted,
      this.temporaryHold,
      this.eventBasedHold,
      this.retentionExpirationTime,
      this.storageClass,
      this.timeStorageClassUpdated,
      this.size,
      this.md5Hash,
      this.mediaLink,
      this.contentEncoding,
      this.contentDisposition,
      this.contentLanguage,
      this.cacheControl,
      this.metadata,
      this.acl,
      this.etag});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'selfLink': selfLink,
      'name': name,
      'bucket': bucket,
      'generation': generation,
      'metageneration': metageneration,
      'contentType': contentType,
      'timeCreated': timeCreated,
      'updated': updated,
      'customTime': customTime,
      'timeDeleted': timeDeleted,
      'temporaryHold': temporaryHold,
      'eventBasedHold': eventBasedHold,
      'retentionExpirationTime': retentionExpirationTime,
      'storageClass': storageClass,
      'timeStorageClassUpdated': timeStorageClassUpdated,
      'size': size,
      'md5Hash': md5Hash,
      'mediaLink': mediaLink,
      'contentEncoding': contentEncoding,
      'contentDisposition': contentDisposition,
      'contentLanguage': contentLanguage,
      'cacheControl': cacheControl,
      'metadata': metadata,
      'acl': acl,
      'etag': etag,
    };
  }

  factory StoreObjectModel.fromMap(Map<String, dynamic> map) {
    // print(map);
    return StoreObjectModel(
      id: map['id'],
      selfLink: map['selfLink'],
      name: map['name'],
      // bucket: map['bucket'],
      // generation: map['generation'],
      // metageneration: map['metageneration'],
      // contentType: map['contentType'],
      // timeCreated: map['timeCreated'],
      // updated: map['updated'],
      // customTime: map['customTime'],
      // timeDeleted: map['timeDeleted'],
      // temporaryHold: map['temporaryHold'],
      // eventBasedHold: map['eventBasedHold'],
      // retentionExpirationTime: map['retentionExpirationTime'],
      // storageClass: map['storageClass'],
      // timeStorageClassUpdated: map['timeStorageClassUpdated'],
      // size: map['size'],
      // md5Hash: map['md5Hash'],
      // mediaLink: map['mediaLink'],
      // contentEncoding: map['contentEncoding'],
      // contentDisposition: map['contentDisposition'],
      // contentLanguage: map['contentLanguage'],
      // cacheControl: map['cacheControl'],
      // metadata: map['metadata'],
      // acl: map['acl'],
      // etag: map['etag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreObjectModel.fromJson(String source) =>
      StoreObjectModel.fromMap(json.decode(source));
}

  

//  {
//   "kind": "storage#object",
//   "id": String,
//   "selfLink": String,
//   "name": String,
//   "bucket": String,
//   "generation,
//   "metageneration,
//   "contentType": String,
//   "timeCreated": "datetime",
//   "updated": "datetime",
//   "customTime": "datetime",
//   "timeDeleted": "datetime",
//   "temporaryHold": bool,
//   "eventBasedHold": bool,
//   "retentionExpirationTime": "datetime",
//   "storageClass": String,
//   "timeStorageClassUpdated": "datetime",
//   "size": "unsigned long",
//   "md5Hash": String,
//   "mediaLink": String,
//   "contentEncoding": String,
//   "contentDisposition": String,
//   "contentLanguage": String,
//   "cacheControl": String,
//   "metadata": {},
//   "acl": [],
//   "owner": {"entity": String, "entityId": String},
//   "crc32c": String,
//   "componentCount": int,
//   "etag": String,
//   "customerEncryption": {"encryptionAlgorithm": String, "keySha256": String},
//   "kmsKeyName": String
// }
