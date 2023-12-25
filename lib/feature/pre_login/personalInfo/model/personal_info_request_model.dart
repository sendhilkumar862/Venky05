class PersonalInfoRequest {

  PersonalInfoRequest(
      {this.nationality,
        this.languages,
        this.dob,
        this.dobIsPublic,
        this.gender,
        this.civilIds});

  PersonalInfoRequest.fromJson(Map<String, dynamic> json) {
    nationality = json['nationality'];
    languages = json['languages'].cast<String>();
    dob = json['dob'];
    dobIsPublic = json['dobIsPublic'];
    gender = json['gender'];
    civilIds = json['civilIds'].cast<String>();
  }
  String? nationality;
  List<String>? languages;
  String? dob;
  bool? dobIsPublic;
  String? gender;
  List<String>? civilIds;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nationality'] = nationality;
    data['languages'] = languages;
    data['dob'] = dob;
    data['dobIsPublic'] = dobIsPublic;
    data['gender'] = gender;
    data['civilIds'] = civilIds;
    return data;
  }
}