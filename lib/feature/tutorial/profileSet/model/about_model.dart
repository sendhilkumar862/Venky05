import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_model.freezed.dart';
part 'about_model.g.dart';

@freezed
class AboutModel with _$AboutModel {
  factory AboutModel({
     int? id,
     String? title,
     String? content,
     String? role,
  }) = _AboutModel;

  factory AboutModel.fromJson(Map<String, dynamic> json) => _$AboutModelFromJson(json);
}
