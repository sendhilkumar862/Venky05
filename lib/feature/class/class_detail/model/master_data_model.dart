class MasterDataModel {
  MasterDataModel(
      {this.grades,
        this.schoolTypes,
        this.curriculum,
        this.sessionDurations,
        this.subjects});

  MasterDataModel.fromJson(Map<String, dynamic> json) {
    grades = json['grades'].cast<String>();
    schoolTypes = json['schoolTypes'].cast<String>();
    curriculum = json['curriculum'].cast<String>();
    sessionDurations = json['sessionDurations'].cast<int>();
    subjects = json['subjects'].cast<String>();
  }
  List<String>? grades;
  List<String>? schoolTypes;
  List<String>? curriculum;
  List<int>? sessionDurations;
  List<String>? subjects;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grades'] = grades;
    data['schoolTypes'] = schoolTypes;
    data['curriculum'] = curriculum;
    data['sessionDurations'] = sessionDurations;
    data['subjects'] = subjects;
    return data;
  }
}