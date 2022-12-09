import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future writedata({required String name}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('name', name);
  }

  Future<String> readdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = preferences.getString('name');
    return data!;
  }

  Future clear({required String key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }
 
  
}
