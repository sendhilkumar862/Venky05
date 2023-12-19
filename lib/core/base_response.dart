class BaseResponse {
  BaseResponse({this.data, this.status});
  BaseResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    status =
    json['status'] != null ?  Status.fromJson(json['status']) : null;
  }
  Data? data;
  Status? status;
}

class Data {
  Data({this.item});
  Data.fromJson(Map<String, dynamic> json) {
    item = json['item'] ?? json['items'];
  }
  Object? item;

}

class Status {
  Status({this.type, this.message});
  Status.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
  }
  String? type;
  String? message;
}