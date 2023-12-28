class TeacherInfoUpdateRequest {

  TeacherInfoUpdateRequest(
      {this.grades,
        this.subjects,
        this.schoolTypes,
        this.classTypes,
        this.curriculum});

  TeacherInfoUpdateRequest.fromJson(Map<String, dynamic> json) {
    grades = json['grades'].cast<String>();
    subjects = json['subjects'].cast<String>();
    schoolTypes = json['schoolTypes'].cast<String>();
    classTypes = json['classTypes'].cast<String>();
    curriculum = json['curriculum'].cast<String>();
  }
  List<String>? grades;
  List<String>? subjects;
  List<String>? schoolTypes;
  List<String>? classTypes;
  List<String>? curriculum;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grades'] = grades;
    data['subjects'] = subjects;
    data['schoolTypes'] = schoolTypes;
    data['classTypes'] = classTypes;
    data['curriculum'] = curriculum;
    return data;
  }
}