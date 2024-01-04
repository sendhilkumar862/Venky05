class ClassDetailsModel {
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
  List<OtherParticipants>? otherParticipants;

  ClassDetailsModel(
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
        this.otherParticipants});

  ClassDetailsModel.fromJson(Map<String, dynamic> json) {
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
    if (json['other_participants'] != null) {
      otherParticipants = <OtherParticipants>[];
      json['other_participants'].forEach((v) {
        otherParticipants!.add(new OtherParticipants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grade'] = this.grade;
    data['school'] = this.school;
    data['subject'] = this.subject;
    data['summary'] = this.summary;
    data['curriculum'] = this.curriculum;
    data['min_participants'] = this.minParticipants;
    data['max_participants'] = this.maxParticipants;
    data['cost'] = this.cost;
    data['currency'] = this.currency;
    data['sessions'] = this.sessions;
    data['duration'] = this.duration;
    data['class_time'] = this.classTime;
    data['location'] = this.location;
    if (this.otherParticipants != null) {
      data['other_participants'] =
          this.otherParticipants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OtherParticipants {
  String? email;

  OtherParticipants({this.email});

  OtherParticipants.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}