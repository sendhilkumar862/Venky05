import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_model.freezed.dart';

part 'country_model.g.dart';

@freezed
abstract class Country with _$Country {
  const factory Country({
    required String name,
    required String flag_url,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}
