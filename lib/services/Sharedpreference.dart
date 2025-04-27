import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sharedpreference {
  Future writeCache({required String key, required String value}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    bool isSaved = await pref.setString(key, value);
    // debugPrint(isSaved.toString());
  }

  Future<String?> readCache({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? value = pref.getString(key);
    if (value != null) {
      return value;
    }
    return null;
  }

  Future<bool> removeCache({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    bool isCleared = await pref.clear();
    return isCleared;
  }
}
