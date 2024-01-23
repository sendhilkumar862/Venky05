class ClassDetailsModel {
  ClassDetailsModel(
      {this.classNumber,
      this.subject,
      this.school,
      this.curriculum,
      this.grade,
      this.description,
      this.sessions,
      this.minParticipants,
      this.maxParticipants,
      this.duration,
      this.classTime,
      this.cost,
      this.currency,
      this.status,
      this.address,
      this.location,
      this.displayId,
      this.isOwner});

  ClassDetailsModel.fromJson(Map<String, dynamic> json) {
    classNumber = json['classNumber'];
    subject = json['subject'];
    school = json['school'];
    curriculum = json['curriculum'];
    grade = json['grade'];
    description = json['description'];
    sessions = json['sessions'];
    minParticipants = json['minParticipants'];
    maxParticipants = json['maxParticipants'];
    duration = json['duration'];
    classTime = json['classTime'];
    cost = json['cost'];
    currency = json['currency'];
    status = json['status'];
    address = json['address'];
    displayId = json['displayId'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    isOwner = json['isOwner'];
  }
  String? classNumber;
  String? subject;
  String? school;
  String? curriculum;
  String? grade;
  String? description;
  int? sessions;
  int? minParticipants;
  int? maxParticipants;
  int? duration;
  int? classTime;
  String? cost;
  String? currency;
  String? status;
  String? address;
  Location? location;
  int? isOwner;
  String? displayId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['classNumber'] = classNumber;
    data['subject'] = subject;
    data['school'] = school;
    data['curriculum'] = curriculum;
    data['grade'] = grade;
    data['description'] = description;
    data['sessions'] = sessions;
    data['minParticipants'] = minParticipants;
    data['maxParticipants'] = maxParticipants;
    data['duration'] = duration;
    data['classTime'] = classTime;
    data['cost'] = cost;
    data['currency'] = currency;
    data['status'] = status;
    data['address'] = address;
    data['displayId'] = displayId;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['isOwner'] = isOwner;
    return data;
  }
}

class Location {
  Location({this.lat, this.long});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'].toString();
    long = json['long'].toString();
  }
  String? lat;
  String? long;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
