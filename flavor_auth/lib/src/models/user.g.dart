// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlavorUser _$FlavorUserFromJson(Map json) {
  return $checkedNew('FlavorUser', json, () {
    final val = FlavorUser(
      rawJson: $checkedConvert(json, 'rawJson', (v) => v as String),
      federatedId: $checkedConvert(json, 'federatedId', (v) => v as String),
      providerId: $checkedConvert(json, 'providerId', (v) => v as String),
      localId: $checkedConvert(json, 'localId', (v) => v as String),
      emailVerified: $checkedConvert(json, 'emailVerified', (v) => v as bool),
      email: $checkedConvert(json, 'email', (v) => v as String),
      oauthAccessToken:
          $checkedConvert(json, 'oauthAccessToken', (v) => v as String),
      firstName: $checkedConvert(json, 'firstName', (v) => v as String),
      lastName: $checkedConvert(json, 'lastName', (v) => v as String),
      displayName: $checkedConvert(json, 'displayName', (v) => v as String),
      idToken: $checkedConvert(json, 'idToken', (v) => v as String),
      photoUrl: $checkedConvert(json, 'photoUrl', (v) => v as String),
      refreshToken: $checkedConvert(json, 'refreshToken', (v) => v as String),
      expiresIn: $checkedConvert(json, 'expiresIn', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$FlavorUserToJson(FlavorUser instance) =>
    <String, dynamic>{
      'federatedId': instance.federatedId,
      'providerId': instance.providerId,
      'emailVerified': instance.emailVerified,
      'oauthAccessToken': instance.oauthAccessToken,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'idToken': instance.idToken,
      'email': instance.email,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'localId': instance.localId,
      'rawJson': instance.rawJson,
    };
