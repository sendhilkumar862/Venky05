// Models

// Helpers

// Services
import 'key_value_storage_base.dart';

/// A service class for providing methods to store and retrieve key-value data
/// from common or secure storage.
class KeyValueStorageService {
  /// The name of auth token key
  static const String _authTokenKey = 'authToken';
  static const String _authBiometric = 'biometricStatus';

  /// The name of user password key
  static const String _authPasswordKey = 'authPasswordKey';

  /// The name of user password key

  static String profile = 'profile';
  static String country = 'country';
  static String countryCodeAndIDD = 'countryCode';
  static String language = 'language';
  static String token = 'token';
  static String setPreference = 'setPreference';
  static String userInfoStatus ='userInfoStatus';

  /// The name of user model key
  static const String _authUserKey = 'authUserKey';

  /// Instance of key-value storage base class
  final KeyValueStorageBase _keyValueStorage = KeyValueStorageBase();

  /// Returns logged in user password
  Future<String> getAuthPassword() async {
    return await _keyValueStorage.getEncrypted(_authPasswordKey) ?? '';
  }

  /// Returns last authentication token
  Future<String> getAuthToken() async {
    return await _keyValueStorage.getEncrypted(_authTokenKey) ?? '';
  }
  /// Returns last authentication token
  Future<String> getBioMetricStatus() async {
    return await _keyValueStorage.getEncrypted(_authBiometric) ?? '';
  }
  /// Remove authentication token
  Future<void> removeAuthToken() async {
    return await _keyValueStorage.removeEncrypted(_authTokenKey);
  }
  /// Sets the authentication password to this value. Even though this method is
  /// asynchronous, we don't care about it's completion which is why we don't
  /// use `await` and let it execute in the background.
  void setAuthPassword(String password) {
    _keyValueStorage.setEncrypted(_authPasswordKey, password);
  }

  /// Sets the authentication token to this value. Even though this method is
  /// asynchronous, we don't care about it's completion which is why we don't
  /// use `await` and let it execute in the background.
  Future<void> setAuthToken(String token) async {
    await _keyValueStorage.setEncrypted(_authTokenKey, token);
  }

  void setAuthBiometric(String status) {
    _keyValueStorage.setEncrypted(_authBiometric, status);
  }
  /// Resets the authentication. Even though these methods are asynchronous, we
  /// don't care about their completion which is why we don't use `await` and
  /// let them execute in the background.
  void resetKeys() {
    _keyValueStorage
      ..clearCommon()
      ..clearEncrypted();
  }
}
