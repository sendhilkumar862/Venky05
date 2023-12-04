// ignore_for_file: constant_identifier_names

enum RegistrationStatus {
  EMAIL,
  MOBILE,
  PROFILE_INCOMPLETE,
  PROFILE_PENDING,
  PROFILE_SUSPENDED,
  PROFILE_REJECTED,
  PROFILE_ACTIVE,
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
      case RegistrationStatus.PROFILE_PENDING:
        return '4';
      case RegistrationStatus.PROFILE_SUSPENDED:
        return '5';
      case RegistrationStatus.PROFILE_REJECTED:
        return '6';
      case RegistrationStatus.PROFILE_ACTIVE:
        return '7';
    }
  }
}
