// ignore_for_file: constant_identifier_names
// DO NOT USE 'dartfmt' on this file for formatting

import 'package:flutter/material.dart';

import '../../../config/config.dart';

// Config

/// A utility class for getting paths for API endpoints.
/// This class has no constructor and all methods are `static`.
@immutable
class ApiEndpoint {
  const ApiEndpoint._();

  /// The base url of our REST API, to which all the requests will be sent.
  /// It is supplied at the time of building the apk or running the app:
  /// ```
  /// flutter build apk --debug --dart-define=BASE_URL=www.some_url.com
  /// ```
  /// OR
  /// ```
  /// flutter run --dart-define=BASE_URL=www.some_url.com
  /// ```
  static const String baseUrl = 'http://167.99.93.83/api/v1/';

  static const String profileSet = 'content/role/common/type/about_us';
  static const String countryGet = 'public/countries/idd';

  /// Returns the path for an authentication [endpoint].
  static String auth(AuthEndpoint endpoint) {
    const String path = 'users';
    switch (endpoint) {
      case AuthEndpoint.REGISTER:
        return '$path/register';
      case AuthEndpoint.LOGIN:
        return '$path/login';
      case AuthEndpoint.REFRESH_TOKEN:
        return '$path/refresh-token';
      case AuthEndpoint.CHANGE_PASSWORD:
        return '$path/changePassword';
      case AuthEndpoint.CHANGE_NAME:
        return '$path/changeName';
      case AuthEndpoint.FORGOT_PW_SEND_OTP:
        return '$path/forgot/send-otp';
      case AuthEndpoint.FORGOT_PW_VERIFY_OTP:
        return '$path/forgot/verify-otp';
      case AuthEndpoint.FORGOT_PW_RESET_PASSWORD:
        return '$path/forgot/reset-password';
      case AuthEndpoint.UPDATE_COUNTRY:
        return '$path/changeCountry/';
      case AuthEndpoint.UPLOAD_PROFILE:
        return '$path/profile/photo/upload';
      case AuthEndpoint.USER_ADDRESS:
        return '$path/:userId/address/';
      case AuthEndpoint.ADD_NUMBER:
        return '$path/mobile/addNumber';
      case AuthEndpoint.CHANGE_NUMBER:
        return '$path/mobile/changeNumber';
      case AuthEndpoint.PERSONAL_INFO:
        return '$path/profile/personal';
      case AuthEndpoint.TEACHING_INFO:
        return '$path/profile/teaching';
      case AuthEndpoint.EXPERIENCE_INFO:
        return '$path/profile/experience';
      case AuthEndpoint.FINANCE_INFO:
        return '$path/profile/iban/';
      case AuthEndpoint.CERTIFICATE:
        return '$path/profile/certificates';
      case AuthEndpoint.PREFERENCE:
        return '$path/preference';
      case AuthEndpoint.DASHBOARD_DETAIL:
        return '$path/dashboard/details';
    }
  }

  static String school(SchoolEndpoint endpoint) {
    const String path = 'school';
    switch (endpoint) {
      case SchoolEndpoint.GRADES:
        return '$path/grades';
      case SchoolEndpoint.CLASS_TYPE:
        return '$path/classtype';
      case SchoolEndpoint.SUBJECTS:
        return '$path/subjects';
      case SchoolEndpoint.TYPES:
        return '$path/types';
      case SchoolEndpoint.CURRICULUM:
        return '$path/curriculum';
    }
  }

  static String country(Public endpoint) {
    const String path = 'public';
    switch (endpoint) {
      case Public.COUNTRY:
        return '$path/countries';
      case Public.COUNTRY_ID:
        return '$path/countries/idd';
    }
  }

  /// Returns the path for a student [endpoint].
  ///
  /// Specify student [erp] to get the path for a specific student.
  ///
  /// Specify secondary [extendedResourceId] to get the path for a specific secondary resource.
  static String students(StudentEndpoint endpoint,
      {String? erp, int? extendedResourceId}) {
    const String path = '/students';
    switch (endpoint) {
      case StudentEndpoint.BASE:
        return path;
    }
  }

  /// Returns the path for teachers [endpoint].
  static String teachers(TeacherEndpoint endpoint) {
    const String path = '/teachers';
    switch (endpoint) {
      case TeacherEndpoint.BASE:
        return path;
    }
  }

  /// Returns the path for Downloader [endpoint].
  static String downloader(DownloaderEndPoint endPoint) {
    const String path = '${baseUrl}file';
    switch (endPoint) {
      case DownloaderEndPoint.BASE:
        return path;
      case DownloaderEndPoint.DOWNLOAD:
        return '$path/download';
    }
  }
}

/// A collection of endpoints used for authentication purposes.
enum AuthEndpoint {
  /// An endpoint for registration requests.
  REGISTER,

  /// An endpoint for login requests.
  LOGIN,

  /// An endpoint for token refresh requests.
  REFRESH_TOKEN,

  /// An endpoint for change password requests.
  CHANGE_PASSWORD,

  /// An endpoint for reset password requests.
  FORGOT_PW_RESET_PASSWORD,

  /// An endpoint for update country requests.
  UPDATE_COUNTRY,

  /// An endpoint for upload profile requests.
  UPLOAD_PROFILE,

  /// An endpoint for user address requests.
  USER_ADDRESS,

  /// An endpoint for forget password otp requests.
  FORGOT_PW_SEND_OTP,

  /// An endpoint for verifying forgot password otp code.
  FORGOT_PW_VERIFY_OTP,

  /// An endpoint for change Name.
  CHANGE_NAME,

  /// An endpoint for add mobile Number.
  ADD_NUMBER,

  /// An endpoint for add mobile Number.
  CHANGE_NUMBER,

  /// An endpoint for update personal.
  PERSONAL_INFO,

  /// An endpoint for update teaching.
  ///
  TEACHING_INFO,

  /// An endpoint for update experience
  EXPERIENCE_INFO,

  /// An endpoint for update finance
  FINANCE_INFO,

  /// An endpoint for update certificate
  CERTIFICATE,

  /// An endpoint for get preference
  PREFERENCE,

  /// An endpoint for get dashboard detail
  DASHBOARD_DETAIL,
}

/// A collection of endpoints used for authentication purposes.
enum SchoolEndpoint {
  /// An endpoint for grades requests.
  GRADES,

  /// An endpoint for subjects requests.
  SUBJECTS,

  /// An endpoint for types requests.
  TYPES,

  /// An endpoint for curriculum requests.
  CURRICULUM,

  /// An endpoint for class type requests.
  CLASS_TYPE,
}

/// A collection of endpoints used for students.
enum StudentEndpoint {
  /// An endpoint for students' collection requests.
  BASE,
}

/// A collection of endpoints used for teachers.
enum TeacherEndpoint {
  /// An endpoint for teacgers' collection requests.
  BASE,
}

enum Public {
  /// An endpoint for teacgers' collection requests.
  COUNTRY,
  COUNTRY_ID
}

/// A collection of endpoints used for Download.
enum DownloaderEndPoint {
  /// An endpoint for teacgers' collection requests.
  BASE,
  DOWNLOAD,
}
