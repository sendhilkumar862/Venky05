class ClassAttendanceModel {

  ClassAttendanceModel({this.items, this.count});

  ClassAttendanceModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    count = json['count'];
  }
  List<Items>? items;
  int? count;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Items {

  Items({this.sessionId, this.sessionNo, this.status, this.attendance});

  Items.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    sessionNo = json['session_no'];
    status = json['status'];
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(Attendance.fromJson(v));
      });
    }
  }
  int? sessionId;
  int? sessionNo;
  int? status;
  List<Attendance>? attendance;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['session_id'] = sessionId;
    data['session_no'] = sessionNo;
    data['status'] = status;
    if (attendance != null) {
      data['attendance'] = attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendance {

  Attendance.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    subject = json['subject'].cast<String>();
    school = json['school'].cast<String>();
    curriculum = json['curriculum'].cast<String>();
    grade = json['grade'].cast<String>();
    name = json['name'];
    imageId = json['imageId'];
    status = json['status'];
    isBookmarked = json['isBookmarked'];
  }

  Attendance(
      {this.userId,
      this.subject,
      this.school,
      this.curriculum,
      this.grade,
      this.name,
      this.imageId,
      this.status,
      this.isBookmarked});
  int? userId;
  List<String>? subject;
  List<String>? school;
  List<String>? curriculum;
  List<String>? grade;
  String? name;
  int? imageId;
  int? status;
  int? isBookmarked;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['subject'] = subject;
    data['school'] = school;
    data['curriculum'] = curriculum;
    data['grade'] = grade;
    data['name'] = name;
    data['imageId'] = imageId;
    data['status'] = status;
    data['isBookmarked'] = isBookmarked;
    return data;
  }
}
