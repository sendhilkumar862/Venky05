class ReviewSessionModal {

  ReviewSessionModal({this.sessionId, this.sessionNo, this.status});

  ReviewSessionModal.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    sessionNo = json['session_no'];
    status = json['status'];
  }
  int? sessionId;
  int? sessionNo;
  int? status;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['session_id'] = sessionId;
    data['session_no'] = sessionNo;
    data['status'] = status;
    return data;
  }
}
