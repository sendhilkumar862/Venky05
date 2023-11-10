// Helpers

import '../../constants/app/app_utils.dart';
import '../../constants/typedefs.dart';

class ResponseModel<T> {
  const ResponseModel({
    this.headers,
    required this.body,
  });

  factory ResponseModel.fromJson(JSON json) {
    return ResponseModel(
      headers: json.containsKey('headers')
          ? ResponseHeadersModel.fromJson(json['headers'] as JSON)
          : null,
      body: json['data']['items'] as T,
    );
  }

  final ResponseHeadersModel? headers;
  final T body;
}

class ResponseHeadersModel {
  const ResponseHeadersModel({
    required this.error,
    required this.message,
    this.code,
  });

  factory ResponseHeadersModel.fromJson(JSON json) {
    return ResponseHeadersModel(
      error: AppUtils.boolFromInt(json['error'] as int),
      message: json['message'] as String,
      code: json['code'] as String?,
    );
  }

  final bool error;
  final String message;
  final String? code;
}
