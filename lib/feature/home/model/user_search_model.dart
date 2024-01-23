

class UserSearchModel {
  UserSearchModel(
      {this.userId,
        this.subject,
        this.school,
        this.curriculum,
        this.grade,
        this.name,
        this.imageId});

  UserSearchModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    // ignore: avoid_dynamic_calls
    subject = json['subject'].cast<String>();
    // ignore: avoid_dynamic_calls
    school = json['school'].cast<String>();
    // ignore: avoid_dynamic_calls
    curriculum = json['curriculum'].cast<String>();
    // ignore: avoid_dynamic_calls
    grade = json['grade'].cast<String>();
    // ignore: avoid_dynamic_calls
    name = json['name'];
    imageId = json['imageId'];
  }
  int? userId;
  List<String>? subject;
  List<String>? school;
  List<String>? curriculum;
  List<String>? grade;
  String? name;
  String? imageId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['subject'] = subject;
    data['school'] = school;
    data['curriculum'] = curriculum;
    data['grade'] = grade;
    data['name'] = name;
    data['imageId'] = imageId;
    return data;
  }
}