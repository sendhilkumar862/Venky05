// ignore_for_file: constant_identifier_names

enum RegistrationStatus {
  EMAIL,
  MOBILE,
  PROFILE_INCOMPLETE,
}

extension RegistrationStatusValue on RegistrationStatus {
  String get value {
    switch (this) {
      case RegistrationStatus.EMAIL:
        return '1';
      case RegistrationStatus.MOBILE:
        return '2';
      case RegistrationStatus.PROFILE_INCOMPLETE:
        return '3';
    }
  }
}
