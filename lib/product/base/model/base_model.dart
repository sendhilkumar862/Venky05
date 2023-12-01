import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_model.freezed.dart';
part 'base_model.g.dart';

@freezed
class BaseResponse<T> with _$BaseResponse<T> {
  factory BaseResponse({
    required Data<T> data,
    required Status status,
  }) = _BaseResponse<T>;

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonItem) {
    return BaseResponse<T>(
      data: Data<T>.fromJson(json['data'], fromJsonItem),
      status: Status.fromJson(json['status']),
    );
  }
}
@freezed
class Data<T> with _$Data<T> {
  factory Data({
    @Default(null) T? item,
    @Default(null) List<T>? items,
    @Default(1) int count,
  }) = _Data<T>;

  factory Data.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonItem) {
    if (json.containsKey('item')) {
      return Data<T>(item: fromJsonItem(json['item']));
    } else if (json.containsKey('items')) {
      return Data<T>(items: List<T>.from(json['items'].map((item) => fromJsonItem(item))), count: json['count']);
    } else {
      throw Exception('Invalid data structure');
    }
  }
}

@freezed
class Status with _$Status {
  factory Status({
    required String type,
    required String message,
    @Default('') String? description,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
