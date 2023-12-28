class PreferenceModel {

  PreferenceModel({this.grade, this.schoolType, this.curriculum, this.subject});

  PreferenceModel.fromJson(Map<String, dynamic> json) {
    if (json['grade'] != null) {
      grade = <Grade>[];
      json['grade'].forEach((v) {
        grade!.add(Grade.fromJson(v));
      });
    }
    if (json['schoolType'] != null) {
      schoolType = <Grade>[];
      json['schoolType'].forEach((v) {
        schoolType!.add(Grade.fromJson(v));
      });
    }
    if (json['curriculum'] != null) {
      curriculum = <Grade>[];
      json['curriculum'].forEach((v) {
        curriculum!.add(Grade.fromJson(v));
      });
    }
    if (json['subject'] != null) {
      subject = <Grade>[];
      json['subject'].forEach((v) {
        subject!.add(Grade.fromJson(v));
      });
    }
  }
  List<Grade>? grade;
  List<Grade>? schoolType;
  List<Grade>? curriculum;
  List<Grade>? subject;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (grade != null) {
      data['grade'] = grade!.map((v) => v.toJson()).toList();
    }
    if (schoolType != null) {
      data['schoolType'] = schoolType!.map((v) => v.toJson()).toList();
    }
    if (curriculum != null) {
      data['curriculum'] = curriculum!.map((v) => v.toJson()).toList();
    }
    if (subject != null) {
      data['subject'] = subject!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Grade {

  Grade({this.id, this.value, this.isEnabled});

  Grade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    isEnabled = json['isEnabled'];
  }
  int? id;
  String? value;
  bool? isEnabled;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['isEnabled'] = isEnabled;
    return data;
  }
}