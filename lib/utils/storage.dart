import 'dart:convert';

import 'package:graphql_bloc/models/User.dart';
import 'package:graphql_bloc/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final Storage _singleton = new Storage._internal();

  factory Storage() {
    return _singleton;
  }

  Storage._internal();

  Future<void> setUserInfo(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(Preference.USER_INFO, jsonEncode(user.toJson()));
  }

  Future<User> getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("userinfo in pref ===== ${pref.get(Preference.USER_INFO)}");
    return pref.containsKey(Preference.USER_INFO)
        ? User.fromJson(jsonDecode(pref.get(Preference.USER_INFO)))
        : null;
  }

  Future<bool> clearAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }
}
