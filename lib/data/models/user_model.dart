import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? name;
  final String? email;
  final String? image;
  final String? about;
  final String? lastMessage;
  final DateTime? messageSent;
  final List? followers;
  final List? following;
  UserModel({
    this.name,
    this.email,
    this.image,
    this.about,
    this.lastMessage,
    this.messageSent,
    this.followers,
    this.following,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'image': image,
      'about': about,
      'lastMessage': lastMessage,
      'messageSent': messageSent?.millisecondsSinceEpoch,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      about: map['about'] as String,
      lastMessage: map['lastMessage'] as String,
      messageSent: map['messageSent'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['messageSent'] as int)
          : null,
      followers: List.from((map['followers'] as List)),
      following: List.from((map['following'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
