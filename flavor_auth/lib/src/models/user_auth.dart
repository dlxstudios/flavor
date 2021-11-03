import 'dart:convert';

import 'package:flavor_auth/flavor_auth.dart';
import 'package:uuid/uuid.dart';

class UserLogin {
  final String email;
  final String hashedPassword;
  final String salt;

  late String? id;

  UserLogin({
    String? uid,
    required this.email,
    required this.hashedPassword,
    required this.salt,
  }) {
    id = uid ?? Uuid().v4();
  }

  UserLogin copyWith({
    String? email,
    String? hashedPassword,
    String? salt,
    String? id,
  }) {
    return UserLogin(
      email: email ?? this.email,
      hashedPassword: hashedPassword ?? this.hashedPassword,
      salt: salt ?? this.salt,
      uid: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'hashedPassword': hashedPassword,
      'salt': salt,
      'id': id,
    };
  }

  factory UserLogin.fromMap(Map<String, dynamic> map) {
    return UserLogin(
      email: map['email'],
      hashedPassword: map['hashedPassword'],
      salt: map['salt'],
      uid: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLogin.fromJson(String source) =>
      UserLogin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserLogin(email: $email, hashedPassword: $hashedPassword, salt: $salt, _id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserLogin &&
        other.email == email &&
        other.hashedPassword == hashedPassword &&
        other.salt == salt &&
        other.id == id;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        hashedPassword.hashCode ^
        salt.hashCode ^
        id.hashCode;
  }
}

class UserLoginAuth {
  final Token token;
  final UserLogin userlogin;

  UserLoginAuth({required this.token, required this.userlogin});
}
