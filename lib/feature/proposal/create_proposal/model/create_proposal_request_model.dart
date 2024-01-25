class CreateProposalRequestModel {

  CreateProposalRequestModel(
      {this.cost, this.currency, this.sessions, this.duration, this.classTime});

  CreateProposalRequestModel.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    currency = json['currency'];
    sessions = json['sessions'];
    duration = json['duration'];
    classTime = json['classTime'];
  }
  int? cost;
  String? currency;
  int? sessions;
  int? duration;
  int? classTime;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cost'] = cost;
    data['currency'] = currency;
    data['sessions'] = sessions;
    data['duration'] = duration;
    data['classTime'] = classTime;
    return data;
  }
}