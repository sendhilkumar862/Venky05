

class GetClassRequestModel {

  GetClassRequestModel(
      {this.limit, this.startIndex, this.sortColumn, this.sortDirection});

  GetClassRequestModel.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    startIndex = json['startIndex'];
    sortColumn = json['sortColumn'];
    sortDirection = json['sortDirection'];
  }
  String? limit;
  String? startIndex;
  String? sortColumn;
  String? sortDirection;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['startIndex'] = startIndex;
    data['sortColumn'] = sortColumn;
    data['sortDirection'] = sortDirection;
    return data;
  }
}