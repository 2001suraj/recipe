import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CloudStorages {
  FirebaseFirestore storage = FirebaseFirestore.instance;
  Future userinfo({
    required String name,
    required String email,
    required String about,
  }) async {
    var user = await storage.collection('user').doc(email);
    await user
        .set({'name': name, 'email': email, 'about': about, 'image': 'null'});
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
      var user = await storage.collection('user').doc(email).collection('recipes').doc(title);
      await user.update({'photourl': urls});
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
