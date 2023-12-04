import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_enter_model.freezed.dart';
part 'email_enter_model.g.dart';

@freezed
abstract class EmailEnterModel with _$EmailEnterModel {
  const factory EmailEnterModel({
     int? userId,
     String? status,
  }) = _EmailEnterModel;

  factory EmailEnterModel.fromJson(Map<String, dynamic> json) => _$EmailEnterModelFromJson(json);
}

