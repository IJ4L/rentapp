// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel? userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel? data) => json.encode(data!.toJson());

class UserModel {
  UserModel({
    this.uid,
    this.username,
    this.email,
    this.photoUrl,
    this.lastSignIn,
    this.kota,
    this.chats,
  });

  String? uid;
  String? username;
  String? email;
  String? photoUrl;
  String? lastSignIn;
  String? kota;
  List<ChatUser>? chats;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["Uid"],
        username: json["Username"],
        email: json["Email"],
        photoUrl: json["PhotoUrl"],
        lastSignIn: json["lastSignIn"],
        kota: json["kota"],
      );

  Map<String, dynamic> toJson() => {
        "Uid": uid,
        "Username": username,
        "Email": email,
        "PhotoUrl": photoUrl,
        "lastSignIn": lastSignIn,
        "kota" : kota,
      };
}

class ChatUser {
  ChatUser({
    this.connection,
    this.chatId,
    this.lastTime,
    this.total_unread,
  });

  String? connection;
  String? chatId;
  String? lastTime;
  int? total_unread;

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        connection: json["connection"],
        chatId: json["chat_id"],
        lastTime: json["lastTime"],
        total_unread: json["total_unread"],
      );

  Map<String, dynamic> toJson() => {
        "connection": connection,
        "chat_id": chatId,
        "lastTime": lastTime,
        "total_unread": total_unread,
      };
}
