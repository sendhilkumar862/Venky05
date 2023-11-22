import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_code_model.freezed.dart';
part 'country_code_model.g.dart';

@freezed
class CountryCodeModel with _$CountryCodeModel {
  const factory CountryCodeModel({
    required String? name,
    required String? flag_url,
    required String? code,
    required String? idd_code,
  }) = _CountryCodeModel;

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) =>
      _$CountryCodeModelFromJson(json);
}
