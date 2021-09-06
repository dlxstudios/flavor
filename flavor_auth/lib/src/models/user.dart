import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(
  nullable: false,
  createFactory: true,
  createToJson: true,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class FlavorUser {
  Map<String, String> get authHeaders {
    return <String, String>{
      'Authorization': 'Bearer $refreshToken',
      'X-Goog-AuthUser': '0',
    };
  }
  // {"""federatedId": "http://facebook.com/1234567890",
  // "providerId": "facebook.com",
  // "localId": "5xwsPCWYo...",
  // "emailVerified": true,
  // "email": "user@example.com",
  // "oauthAccessToken": "[FACEBOOK_ACCESS_TOKEN]",
  // "firstName": "John",
  // "lastName": "Doe",
  // "fullName": "John Doe",
  // "displayName": "John Doe",
  // "idToken": "[ID_TOKEN]",
  // "photoUrl": "https://scontent.xx.fbcdn.net/v/...",
  // "refreshToken": "[REFRESH_TOKEN]",
  // "expiresIn": "3600",
  // "rawUserInfo": "{\"updated_time\":\"2017-02-22T01:10:57+0000\",\"gender\":\"male\"}"""}

  final String? federatedId;
  final String? providerId;

  final bool? emailVerified;

  final String? oauthAccessToken;

  final String? firstName;
  final String? lastName;
  final String? displayName;
  final String? photoUrl;

  ///
  /// [idToken]	string
  /// An Identity Platform ID token for the newly created user.
  final String? idToken;

  /// [email]	string
  /// The email for the newly created user.
  final String? email;

  /// [refreshToken]	string
  /// An Identity Platform refresh token for the newly created user.
  final String? refreshToken;

  /// [expiresIn]	string
  /// The number of seconds in which the ID token expires.
  final String? expiresIn;

  /// [localId]	string
  /// The uid of the newly created user.
  final String? localId;

  final String? rawJson;

  final String? rawUserInfo;

  final bool? isAdmin;
  factory FlavorUser.fromJson(Map<dynamic, dynamic> json) =>
      _$FlavorUserFromJson(json);
  Map<String, Object?> toJson() => _$FlavorUserToJson(this);
  FlavorUser({
    this.isAdmin = false,
    this.rawJson,
    this.federatedId,
    this.providerId,
    this.localId,
    this.emailVerified,
    this.email,
    this.oauthAccessToken,
    this.firstName,
    this.lastName,
    this.displayName,
    this.idToken,
    this.photoUrl,
    this.refreshToken,
    this.expiresIn,
    this.rawUserInfo,
  });

  @override
  String toString() {
    return super.toString();
    // return json.decode(rawJson.toString())?.toString();
    // return rawJson.toString();
  }

  // static Future<FlavorUser> fromJson(dynamic json) {
  //   var data;
  //   try {
  //     data = json.decode(json);
  //   } catch (e) {
  //     return Future.error(e);
  //   }

  //   return Future.value(
  //     FlavorUser(
  //       email: data['email'],
  //       idToken: data['idToken'],
  //       expiresIn: data['expiresIn'],
  //       localId: data['localId'],
  //       refreshToken: data['refreshToken'],
  //       rawJson: data,
  //     ),
  //   );
  // }
}
