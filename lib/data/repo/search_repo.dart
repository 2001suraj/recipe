import 'package:cloud_firestore/cloud_firestore.dart';

class SearchRepo {
  searchuser(String searchfield) {
    return FirebaseFirestore.instance
        .collection('fav')
        .where('searchkey',
            isEqualTo: searchfield.substring(0, 1).toLowerCase())
        .get();
  }
}
