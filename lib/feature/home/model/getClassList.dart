



class GetClassListModel {

  GetClassListModel(
      {this.displayId,
        this.classNumber,
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
        this.name,
        this.imageId,
        this.country});

  GetClassListModel.fromJson(Map<String, dynamic> json) {
    displayId = json['displayId'];
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
    imageId = json['imageId'];
    country = json['country'];
  }
  String? displayId;
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
 String? imageId;
  String? country;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayId'] = displayId;
    data['classNumber'] = classNumber;
    data['subject'] = subject;
    data['school'] = school;
    data['curriculum'] = curriculum;
    data['grade'] = grade;
    data['minParticipants'] = minParticipants;
    data['maxParticipants'] = maxParticipants;
    data['duration'] = duration;
    data['classTime'] = classTime;
    data['cost'] = cost;
    data['currency'] = currency;
    data['status'] = status;
    data['name'] = name;
    data['imageId'] = imageId;
    data['country'] = country;
    return data;
  }
}