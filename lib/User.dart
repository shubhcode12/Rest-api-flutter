// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
class User {
  bool isLoggedIn;
  String authToken;

  User(this.isLoggedIn, this.authToken);

  factory User.fromJson(dynamic json) {
    return User(json['isLoggedIn'] as bool, json['authToken'] as String);
  }

  @override
  String toString() {
    return '{ ${this.isLoggedIn}, ${this.authToken} }';
  }
}
