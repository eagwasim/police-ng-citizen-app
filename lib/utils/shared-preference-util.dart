import 'dart:convert';

import 'package:police_citizen_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static const _CURRENT_USER_KEY = "CURRENT_USER_KEY";
  static const _CURRENT_PHONE_NUMBER_FOR_VERIFICATION = "CURRENT_PHONE_NUMBER_FOR_VERIFICATION";
  static const _USER_AUTHENTICATION_TOKEN = "USER_AUTHENTICATION_TOKEN";

  static const TERMS_AND_CONDITIONS_ACCEPTED_KEY = "TERMS_AND_CONDITIONS_ACCEPTED_KEY";
  static const LATEST_SOS_ID_KEY = "LATEST_SOS_ID_KEY";

  static Future<User> currentUser() async {
    final prefs = await SharedPreferences.getInstance();

    final currentUser = prefs.getString(_CURRENT_USER_KEY) ?? null;

    if (currentUser == null) {
      return null;
    }

    return User.fromJson(jsonDecode(currentUser));
  }

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_CURRENT_USER_KEY, jsonEncode(user.toJson()));
  }

  static Future<int> getInt(String key, int defaultValue) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? defaultValue;
  }

  static Future<void> setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<bool> getBool(String key, bool defaultValue) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultValue;
  }

  static Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<void> savePhoneNumberForVerification(String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_CURRENT_PHONE_NUMBER_FOR_VERIFICATION, phoneNumber);
  }

  static Future<String> getPhoneNumberForVerification() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_CURRENT_PHONE_NUMBER_FOR_VERIFICATION);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_USER_AUTHENTICATION_TOKEN, token);
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_USER_AUTHENTICATION_TOKEN);
  }
}
