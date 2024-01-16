import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_model.freezed.dart';
part 'home_model.g.dart';

@freezed
class HomeModel with _$HomeModel {
  const factory HomeModel(
      {String? firstName,
      String? lastName,
      String? email,
      String? countryCode,
      String? mobile,
      String? country,
      String? userStatus,
      String? userId,
      String? imageId,
        String? username }) = _HomeModel;

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
}
