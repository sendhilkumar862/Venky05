import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_model.freezed.dart';

part 'country_model.g.dart';

@freezed
abstract class Country with _$Country {
  const factory Country({
     String? name,
     String? flag_url,
     String? code,
     String? idd_code,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}
