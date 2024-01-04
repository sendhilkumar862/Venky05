

class GetClassListModel {
  String? classNumber;
  String? subject;
  String? school;
  String? curriculum;
  String? grade;
  int? minParticipants;
  int? maxParticipants;
  int? duration;
  int? classTime;
  String? cost;
  String? currency;
  String? status;
  String? name;

  GetClassListModel(
      {this.classNumber,
        this.subject,
        this.school,
        this.curriculum,
        this.grade,
        this.minParticipants,
        this.maxParticipants,
        this.duration,
        this.classTime,
        this.cost,
        this.currency,
        this.status,
        this.name});

  GetClassListModel.fromJson(Map<String, dynamic> json) {
    classNumber = json['classNumber'];
    subject = json['subject'];
    school = json['school'];
    curriculum = json['curriculum'];
    grade = json['grade'];
    minParticipants = json['minParticipants'];
    maxParticipants = json['maxParticipants'];
    duration = json['duration'];
    classTime = json['classTime'];
    cost = json['cost'];
    currency = json['currency'];
    status = json['status'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classNumber'] = this.classNumber;
    data['subject'] = this.subject;
    data['school'] = this.school;
    data['curriculum'] = this.curriculum;
    data['grade'] = this.grade;
    data['minParticipants'] = this.minParticipants;
    data['maxParticipants'] = this.maxParticipants;
    data['duration'] = this.duration;
    data['classTime'] = this.classTime;
    data['cost'] = this.cost;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['name'] = this.name;
    return data;
  }
}

