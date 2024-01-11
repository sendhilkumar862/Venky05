class GetTicketsRequestModel {

  GetTicketsRequestModel({this.searchTerm='', this.filters, this.pagination});


  String searchTerm;
  List<Filters>? filters=[];
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['searchTerm'] = searchTerm;
    if (filters != null) {
      data['filters'] = filters!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Filters {
  Filters({this.key='status', this.value, this.condition='equal'});
  String key;
  String? value;
  String condition;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    data['condition'] = condition;
    return data;
  }
}

class Pagination {
  Pagination({this.pageIndex=1, this.pageSize=10, this.sort});
  int pageIndex;
  int pageSize;
  Sort? sort;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    return data;
  }
}

class Sort {
  Sort({this.direction, this.column='created_at'});

  String? direction;
  String column;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['direction'] = direction;
    data['column'] = column;
    return data;
  }
}