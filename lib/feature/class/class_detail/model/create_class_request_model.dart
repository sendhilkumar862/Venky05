class CreateClassRequestModel {
  CreateClassRequestModel(
      {this.grade,
        this.school,
        this.subject,
        this.summary,
        this.curriculum,
        this.minParticipants,
        this.maxParticipants,
        this.cost,
        this.currency,
        this.sessions,
        this.duration,
        this.classTime,
        this.location,
        this.allowAtStudentLoc,
        this.otherParticipants});

  CreateClassRequestModel.fromJson(Map<String, dynamic> json) {
    grade = json['grade'];
    school = json['school'];
    subject = json['subject'];
    summary = json['summary'];
    curriculum = json['curriculum'];
    minParticipants = json['min_participants'];
    maxParticipants = json['max_participants'];
    cost = json['cost'];
    currency = json['currency'];
    sessions = json['sessions'];
    duration = json['duration'];
    classTime = json['class_time'];
    location = json['location'];
    allowAtStudentLoc = json['allow_at_student_loc'];
    if (json['other_participants'] != null) {
      otherParticipants = <OtherParticipants>[];
      // ignore: avoid_dynamic_calls
      json['other_participants'].forEach((v) {
        otherParticipants!.add(OtherParticipants.fromJson(v));
      });
    }
  }
  String? grade;
  String? school;
  String? subject;
  String? summary;
  String? curriculum;
  int? minParticipants;
  int? maxParticipants;
  int? cost;
  String? currency;
  int? sessions;
  int? duration;
  int? classTime;
  int? location;
  bool? allowAtStudentLoc;
  List<OtherParticipants>? otherParticipants;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grade'] = grade;
    data['school'] = school;
    data['subject'] = subject;
    data['summary'] = summary;
    data['curriculum'] = curriculum;
    data['min_participants'] = minParticipants;
    data['max_participants'] = maxParticipants;
    data['cost'] = cost;
    data['currency'] = currency;
    data['sessions'] = sessions;
    data['duration'] = duration;
    data['class_time'] = classTime;
    data['location'] = location;
    data['allow_at_student_loc'] = allowAtStudentLoc;
    if (otherParticipants != null) {
      data['other_participants'] =
          otherParticipants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OtherParticipants {

  OtherParticipants({this.email});

  OtherParticipants.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }
  String? email;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}