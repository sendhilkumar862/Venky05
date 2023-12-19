import 'dart:core';

import '../product/network/local/key_value_storage_service.dart';




final KeyValueStorageService keyValueStorageService = KeyValueStorageService();
abstract class BaseRequest{
  Map<String, dynamic> header = <String, dynamic>{
  'Content-Type': 'application/json',
  };
  String get endPoint;
  Map<String, dynamic> get body;
}
