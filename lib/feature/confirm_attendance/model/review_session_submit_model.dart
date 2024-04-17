class ClassAttendancePostModel {

  ClassAttendancePostModel(
      {this.isSelectAll, this.type, this.sessions, this.users});

  ClassAttendancePostModel.fromJson(Map<String, dynamic> json) {
    isSelectAll = json['isSelectAll'];
    type = json['type'];
    sessions = json['sessions'].cast<String>();
    users = json['users'].cast<String>();
  }
  bool? isSelectAll;
  String? type;
  List<String>? sessions;
  List<String>? users;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSelectAll'] = isSelectAll;
    data['type'] = type;
    data['sessions'] = sessions;
    data['users'] = users;
    return data;
  }
}
