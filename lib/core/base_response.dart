class BaseResponse {
  BaseResponse({this.data, this.status,this.paginationData});
  BaseResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    status =
    json['status'] != null ?  Status.fromJson(json['status']) : null;
    paginationData=json['pagination']!=null?PaginationData.fromJson(json['pagination']):null ;
  }
  Data? data;
  Status? status;
  PaginationData? paginationData;
}

class Data {
  Data({this.item,this.count});
  Data.fromJson(Map<String, dynamic> json) {
    item = json['item'] ?? json['items'];
    count=json['count'] ?? json['count'];
  }
  Object? item;
  int? count;

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
class PaginationData {
  PaginationData({this.total, this.pageSize, this.pageIndex});
  PaginationData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageIndex = json['pageIndex'];
  }
  int? total;
  int? pageSize;
  int? pageIndex;
}
