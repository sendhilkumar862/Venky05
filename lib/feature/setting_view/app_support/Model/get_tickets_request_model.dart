class GetTicketsRequestModel {
  String? searchTerm;
  List<Filters>? filters;
  Pagination? pagination;

  GetTicketsRequestModel({this.searchTerm, this.filters, this.pagination});

  GetTicketsRequestModel.fromJson(Map<String, dynamic> json) {
    searchTerm = json['searchTerm'];
    if (json['filters'] != null) {
      filters = <Filters>[];
      json['filters'].forEach((v) {
        filters!.add(new Filters.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchTerm'] = this.searchTerm;
    if (this.filters != null) {
      data['filters'] = this.filters!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Filters {
  String? key;
  String? value;
  String? condition;

  Filters({this.key, this.value, this.condition});

  Filters.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['condition'] = this.condition;
    return data;
  }
}

class Pagination {
  int? pageIndex;
  int? pageSize;
  Sort? sort;

  Pagination({this.pageIndex, this.pageSize, this.sort});

  Pagination.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    return data;
  }
}

class Sort {
  String? direction;
  String? column;

  Sort({this.direction, this.column});

  Sort.fromJson(Map<String, dynamic> json) {
    direction = json['direction'];
    column = json['column'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['direction'] = this.direction;
    data['column'] = this.column;
    return data;
  }
}