

import 'package:get_storage/get_storage.dart';

import 'key_value_storeage.dart';

class LocaleManager {
  LocaleManager._();
  static final GetStorage localeManager = GetStorage();
  static void setAuthToken(dynamic value)  {
    localeManager.write(StorageKeys.authTokenKey, value);
  }

  static String getAuthToken()  {
    return localeManager.read(StorageKeys.authTokenKey)??'';
  }

  static void removeAuthToken()  {
    localeManager.remove(StorageKeys.authTokenKey);
  }
  static void setValue(String key,  dynamic value)  {
     localeManager.write(key, value);
  }
  static dynamic getValue(String key) => localeManager.read(key);
  static void removeValue(String key) => localeManager.remove(key);
}
