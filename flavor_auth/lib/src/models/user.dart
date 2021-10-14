import 'dart:convert';

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

  final bool? isAnonymous;

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
  final String? phoneNumber;

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

  FlavorUser({
    // this.rawUserInfo,
    this.isAnonymous = false,
    this.federatedId,
    this.providerId,
    this.emailVerified,
    this.oauthAccessToken,
    this.firstName,
    this.lastName,
    this.displayName,
    this.photoUrl,
    this.idToken,
    this.email,
    this.phoneNumber,
    this.refreshToken,
    this.expiresIn,
    this.localId,
    this.rawJson,
  });

  FlavorUser copyWith({
    bool? isAnonymous,
    String? federatedId,
    String? providerId,
    bool? emailVerified,
    String? oauthAccessToken,
    String? firstName,
    String? lastName,
    String? displayName,
    String? photoUrl,
    String? idToken,
    String? email,
    String? phoneNumber,
    String? refreshToken,
    String? expiresIn,
    String? localId,
    String? rawJson,
  }) {
    return FlavorUser(
      isAnonymous: isAnonymous ?? this.isAnonymous,
      federatedId: federatedId ?? this.federatedId,
      providerId: providerId ?? this.providerId,
      emailVerified: emailVerified ?? this.emailVerified,
      oauthAccessToken: oauthAccessToken ?? this.oauthAccessToken,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      idToken: idToken ?? this.idToken,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
      localId: localId ?? this.localId,
      rawJson: rawJson ?? this.rawJson,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isAnonymous': isAnonymous,
      'federatedId': federatedId,
      'providerId': providerId,
      'emailVerified': emailVerified,
      'oauthAccessToken': oauthAccessToken,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'idToken': idToken,
      'email': email,
      'phoneNumber': phoneNumber,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'localId': localId,
      'rawJson': rawJson,
    };
  }

  factory FlavorUser.fromMap(Map<String, dynamic> map) {
    return FlavorUser(
      isAnonymous: map['isAnonymous'],
      federatedId: map['federatedId'],
      providerId: map['providerId'],
      emailVerified: map['emailVerified'],
      oauthAccessToken: map['oauthAccessToken'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      idToken: map['idToken'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      refreshToken: map['refreshToken'],
      expiresIn: map['expiresIn'],
      localId: map['localId'],
      rawJson: map['rawJson'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlavorUser.fromJson(String source) =>
      FlavorUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlavorUser(isAnonymous: $isAnonymous, federatedId: $federatedId, providerId: $providerId, emailVerified: $emailVerified, oauthAccessToken: $oauthAccessToken, firstName: $firstName, lastName: $lastName, displayName: $displayName, photoUrl: $photoUrl, idToken: $idToken, email: $email, phoneNumber: $phoneNumber, refreshToken: $refreshToken, expiresIn: $expiresIn, localId: $localId, rawJson: $rawJson)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlavorUser &&
        other.isAnonymous == isAnonymous &&
        other.federatedId == federatedId &&
        other.providerId == providerId &&
        other.emailVerified == emailVerified &&
        other.oauthAccessToken == oauthAccessToken &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.displayName == displayName &&
        other.photoUrl == photoUrl &&
        other.idToken == idToken &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.refreshToken == refreshToken &&
        other.expiresIn == expiresIn &&
        other.localId == localId &&
        other.rawJson == rawJson;
  }

  @override
  int get hashCode {
    return isAnonymous.hashCode ^
        federatedId.hashCode ^
        providerId.hashCode ^
        emailVerified.hashCode ^
        oauthAccessToken.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        displayName.hashCode ^
        photoUrl.hashCode ^
        idToken.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        refreshToken.hashCode ^
        expiresIn.hashCode ^
        localId.hashCode ^
        rawJson.hashCode;
  }
}
