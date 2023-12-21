import 'package:freezed_annotation/freezed_annotation.dart';

part 'enter_mobile_model.freezed.dart';
part 'enter_mobile_model.g.dart';

@freezed
class EnterMobileModel with _$EnterMobileModel {
  const factory EnterMobileModel({
      int? otpId,
  }) = _EnterMobileModel;

  factory EnterMobileModel.fromJson(Map<String, dynamic> json) =>
      _$EnterMobileModelFromJson(json);
}
