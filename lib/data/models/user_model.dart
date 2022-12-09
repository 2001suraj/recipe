import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? userName;
  final String? email;
  final String? photoUrl;
  final String? bio;
  final String? lastMessage;
  final DateTime? messageSent;
  final List? followers;
  final List? following;
  UserModel({
    this.userName,
    this.email,
    this.photoUrl,
    this.bio,
    this.lastMessage,
    this.messageSent,
    this.followers,
    this.following,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
      'lastMessage': lastMessage,
      'messageSent': messageSent?.millisecondsSinceEpoch,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
      bio: map['bio'] as String,
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
