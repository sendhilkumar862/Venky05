class ExperienceInfoUpdateRequest {
  String? education;
  bool? educationIsPublic;
  int? experience;
  String? experienceDetails;
  bool? experienceIsPublic;
  List<String>? certificateIds;
  bool? certificateIsPublic;

  ExperienceInfoUpdateRequest(
      {this.education,
        this.educationIsPublic,
        this.experience,
        this.experienceDetails,
        this.experienceIsPublic,
        this.certificateIds,
        this.certificateIsPublic});

  ExperienceInfoUpdateRequest.fromJson(Map<String, dynamic> json) {
    education = json['education'];
    educationIsPublic = json['educationIsPublic'];
    experience = json['experience'];
    experienceDetails = json['experienceDetails'];
    experienceIsPublic = json['experienceIsPublic'];
    certificateIds = json['certificateIds'].cast<String>();
    certificateIsPublic = json['certificateIsPublic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['education'] = education;
    data['educationIsPublic'] = educationIsPublic;
    data['experience'] = experience;
    data['experienceDetails'] = experienceDetails;
    data['experienceIsPublic'] = experienceIsPublic;
    data['certificateIds'] = certificateIds;
    data['certificateIsPublic'] = certificateIsPublic;
    return data;
  }
}