

class MasterDataModel {
  MasterDataModel(
      {this.grades,
        this.classTypes,
        this.schoolTypes,
        this.curriculum,
        this.sessionDurations,
        this.subjects,
        this.gender});
  MasterDataModel.fromJson(Map<String, dynamic> json) {
    // ignore: avoid_dynamic_calls
    grades = json['grades'].cast<String>();
    // ignore: avoid_dynamic_calls
    classTypes = json['classTypes'].cast<String>();
    // ignore: avoid_dynamic_calls
    schoolTypes = json['schoolTypes'].cast<String>();
    // ignore: avoid_dynamic_calls
    curriculum = json['curriculum'].cast<String>();
    // ignore: avoid_dynamic_calls
    sessionDurations = json['sessionDurations'].cast<int>();
    // ignore: avoid_dynamic_calls
    subjects = json['subjects'].cast<String>();
    // ignore: avoid_dynamic_calls
    gender = json['gender'].cast<String>();
  }
  List<String>? grades;
  List<String>? classTypes;
  List<String>? schoolTypes;
  List<String>? curriculum;
  List<int>? sessionDurations;
  List<String>? subjects;
  List<String>? gender;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grades'] = grades;
    data['classTypes'] = classTypes;
    data['schoolTypes'] = schoolTypes;
    data['curriculum'] = curriculum;
    data['sessionDurations'] = sessionDurations;
    data['subjects'] = subjects;
    data['gender'] = gender;
    return data;
  }
}
