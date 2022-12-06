import 'package:cloud_firestore/cloud_firestore.dart';

class CloudStorages {
  FirebaseFirestore storage = FirebaseFirestore.instance;
  Future userinfo({
    required String name,
    required String email,
  }) async {
    var user = await storage.collection('user').doc(name);
    await user.set({
      'name':name,
      'email':email
    });
  }
}
