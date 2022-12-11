// ignore_for_file: await_only_futures, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorages {
  FirebaseFirestore storage = FirebaseFirestore.instance;
  Future userinfo({
    required String name,
    required String email,
    required String about,
    required List followers,

    required List following
  }) async {
    var user = await storage.collection('user').doc(email);
    await user.set({
      'name': name,
      'email': email,
      'about': about,
      'image': 'null',
      'followers': followers,
      'following': following,
    });
  }

  Future userinfo_update({
    required String name,
    required String email,
    required String about,
  }) async {
    var user = await storage.collection('user').doc(email);
    await user.update({
      'name': name,
      'about': about,
    });
  }

  Future profilesetup({
    required File photo,
    required String name,
    required String email,
  }) async {
    try {
      UploadTask? uploadTask;
      var ref = FirebaseStorage.instance.ref().child('user_photo').child(name);
      ref.putFile(photo);
      uploadTask = ref.putFile(photo);
      final snap = await uploadTask.whenComplete(() {});
      final urls = await snap.ref.getDownloadURL();
      var user = await storage.collection('user').doc(email);
      await user.update({'image': urls});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//normal

  Future addrecipephoto({
    required File photo,
    required String title,
    required String email,
  }) async {
    try {
      UploadTask? uploadTask;
      var ref =
          FirebaseStorage.instance.ref().child('recipe_photo').child(title);
      ref.putFile(photo);
      uploadTask = ref.putFile(photo);
      final snap = await uploadTask.whenComplete(() {});
      final urls = await snap.ref.getDownloadURL();
      var user = await storage
          .collection('user')
          .doc(email)
          .collection('recipes')
          .doc(title);
      await user.update({'photourl': urls});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//today

  Future todayrecipephoto({
    required File photo,
    required String title,
    required String email,
  }) async {
    try {
      UploadTask? uploadTask;
      var ref = FirebaseStorage.instance
          .ref()
          .child('today_recipe_photo')
          .child(title);
      ref.putFile(photo);
      uploadTask = ref.putFile(photo);
      final snap = await uploadTask.whenComplete(() {});
      final urls = await snap.ref.getDownloadURL();
      var user = await storage
          .collection('today_recipe')
          // .doc(email)
          // .collection('recipes')
          .doc(title);
      await user.update({'photourl': urls});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //popular
  Future popularrecipephoto({
    required File photo,
    required String title,
    required String email,
  }) async {
    try {
      UploadTask? uploadTask;
      var ref = FirebaseStorage.instance
          .ref()
          .child('popular_recipe_photo')
          .child(title);
      ref.putFile(photo);
      uploadTask = ref.putFile(photo);
      final snap = await uploadTask.whenComplete(() {});
      final urls = await snap.ref.getDownloadURL();
      var user = await storage
          .collection('popular_recipe')
          // .doc(email)
          // .collection('recipes')
          .doc(title);
      await user.update({'photourl': urls});
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
