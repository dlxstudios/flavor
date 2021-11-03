import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:uuid/uuid.dart';

class Token {
  String? id;

  JWT? _jwt;
  late String? jwt;
  late String? signed;

  Token({
    String? tId,
    this.jwt,
    this.signed,
    this.subject,
    required this.issuer,
    required this.secret,
    this.expiry = const Duration(seconds: 60000),
  }) {
    id = tId ?? Uuid().v4();

    _jwt = JWT(
      {
        'iat': DateTime.now().millisecondsSinceEpoch,
      },
      subject: subject,
      issuer: issuer,
      jwtId: tId,
    );
    signed = _jwt!.sign(SecretKey(secret), expiresIn: expiry);
  }
  final String? subject;
  final String issuer;
  final String secret;
  final Duration expiry;

  Token copyWith({
    String? jwt,
    String? signed,
    String? subject,
    String? issuer,
    String? secret,
    String? jwtId,
    Duration? expiry,
  }) {
    return Token(
      jwt: jwt ?? this.jwt,
      signed: signed ?? this.signed,
      subject: subject ?? this.subject,
      issuer: issuer ?? this.issuer,
      secret: secret ?? this.secret,
      // expiry: expiry ?? this.expiry,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jwt': jwt,
      'signed': signed,
      'subject': subject,
      'issuer': issuer,
      'secret': secret,
      'id': id,
      'expiry': expiry.inSeconds,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      jwt: map['jwt'],
      signed: map['signed'],
      subject: map['subject'],
      issuer: map['issuer'],
      secret: map['secret'],
      tId: map['id'],
      expiry: map.containsKey('expiry')
          ? Duration(seconds: map['expiry'])
          : Duration(
              seconds: 60000,
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) => Token.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Token(_id: $id, jwt: $jwt, signed: $signed, subject: $subject, issuer: $issuer, secret: $secret, expiry: $expiry)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Token &&
        other.id == id &&
        other.jwt == jwt &&
        other.signed == signed &&
        other.subject == subject &&
        other.issuer == issuer &&
        other.secret == secret &&
        other.expiry == expiry;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        jwt.hashCode ^
        signed.hashCode ^
        subject.hashCode ^
        issuer.hashCode ^
        secret.hashCode ^
        expiry.hashCode;
  }
}
