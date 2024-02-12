class ProposalDetailModel {

  ProposalDetailModel({this.originalDetails, this.proposalDetails});

  ProposalDetailModel.fromJson(Map<String, dynamic> json) {
    originalDetails = json['original_details'] != null
        ?  OriginalDetails.fromJson(json['original_details'])
        : null;
    proposalDetails = json['proposal_details'] != null
        ?  OriginalDetails.fromJson(json['proposal_details'])
        : null;
  }
  OriginalDetails? originalDetails;
  OriginalDetails? proposalDetails;
}

class OriginalDetails {

  OriginalDetails({this.duration, this.classTime, this.cost, this.currency, this.session});

  OriginalDetails.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    classTime = json['classTime'];
    cost = json['cost'];
    currency = json['currency'];
    session = json['session'];
  }
  int? duration;
  int? classTime;
  String? cost;
  String? currency;
  int? session;

}


