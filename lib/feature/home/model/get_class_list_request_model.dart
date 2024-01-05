

class GetClassRequestModel {
  String? limit;
  String? startIndex;
  String? sortColumn;
  String? sortDirection;

  GetClassRequestModel(
      {this.limit, this.startIndex, this.sortColumn, this.sortDirection});

  GetClassRequestModel.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    startIndex = json['startIndex'];
    sortColumn = json['sortColumn'];
    sortDirection = json['sortDirection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['startIndex'] = this.startIndex;
    data['sortColumn'] = this.sortColumn;
    data['sortDirection'] = this.sortDirection;
    return data;
  }
}