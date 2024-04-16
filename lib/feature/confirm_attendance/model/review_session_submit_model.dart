class ReviewSessionSubmitModal {

  ReviewSessionSubmitModal(
      {this.educationalSkills,
      this.friendliness,
      this.ontimeArrival,
      this.overallRating,
      this.sessionId});

  ReviewSessionSubmitModal.fromJson(Map<String, dynamic> json) {
    educationalSkills = json['educational_skills'];
    friendliness = json['friendliness'];
    ontimeArrival = json['ontime_arrival'];
    overallRating = json['overall_rating'];
    sessionId = json['session_id'];
  }
  int? educationalSkills;
  int? friendliness;
  int? ontimeArrival;
  int? overallRating;
  int? sessionId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['educational_skills'] = educationalSkills;
    data['friendliness'] = friendliness;
    data['ontime_arrival'] = ontimeArrival;
    data['overall_rating'] = overallRating;
    data['session_id'] = sessionId;
    return data;
  }
}
