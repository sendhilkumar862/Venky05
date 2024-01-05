class ProposalModel {

  ProposalModel(
      {this.cost, this.currency, this.country, this.name, this.proposalId});

  ProposalModel.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    currency = json['currency'];
    country = json['country'];
    name = json['name'];
    proposalId = json['proposalId'];
  }
  String? cost;
  String? currency;
  String? country;
  String? name;
  String? proposalId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cost'] = cost;
    data['currency'] = currency;
    data['country'] = country;
    data['name'] = name;
    data['proposalId'] = proposalId;
    return data;
  }
}