// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        required this.isLoggedIn,
        required this.authToken,
    });

    bool isLoggedIn;
    String authToken;

    factory User.fromJson(Map<String, dynamic> json) => User(
        isLoggedIn: json["isLoggedIn"],
        authToken: json["authToken"],
    );

    Map<String, dynamic> toJson() => {
        "isLoggedIn": isLoggedIn,
        "authToken": authToken,
    };
}
