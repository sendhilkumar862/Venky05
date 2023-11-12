import 'package:shared_preferences/shared_preferences.dart';

import '../constants/enums/locale_keys_enum.dart';

class LocaleManager {
  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  static final LocaleManager _instance = LocaleManager._init();

  SharedPreferences? _preferences;

  static LocaleManager get instance => _instance;

  // keyys
  static String profile = 'profile';
  static String country = 'country';
  static String language = 'language';
  static String isLoggedIn = 'is_logged_in';
  static String userId = 'user_id';
  static String accessToken = 'access_token';
  static String refreshToken = 'refresh_token';
  static String email = 'email';
  static String password = 'password';

  static Future prefrencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  void setString(PreferencesKeys key, String value) async {
    await _preferences?.setString(key.toString(), value);
  }

  Future<void> setStringValue(String key, String value) async {
    await _preferences!.setString(key, value);
  }

  Future<void> setBoolValue(String key, bool value) async {
    await _preferences!.setBool(key, value);
  }

  Future<void> setIntValue(String key, int value) async {
    await _preferences!.setInt(key, value);
  }

  String getStringValue(String key) =>
      _preferences?.getString(key.toString()) ?? '';

  bool getBoolValue(String key) => _preferences?.getBool(key) ?? false;

  int getIntValue(String key) => _preferences?.getInt(key) ?? 0;
}
