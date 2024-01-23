import 'package:flutter/foundation.dart';

/// A utility class that holds constants for exposing loaded
/// dart environment variables.
/// This class has no constructor and all variables are `static`.
@immutable
class Config {
  const Config._();

  /// The base url of our REST API, to which all the requests will be sent.
  /// It is supplied at the time of building the apk or running the app:
  /// ```
  /// flutter build apk --debug --dart-define=BASE_URL=www.some_url.com
  /// ```
  /// OR
  /// ```
  /// flutter run --dart-define=BASE_URL=www.some_url.com
  /// ```
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://167.99.93.83/api/v1/',
  );
  static const String mirrorFlyBaseURL =
      'https://api-preprod-sandbox.mirrorfly.com/api/v1/';
  static const String mirrorFlyLicenceKey = 'UaUTo9l1D2rGy6rCHZJhjcOiAXu1hJ';
  static const String bundleId = 'group.test.hessah';
}
