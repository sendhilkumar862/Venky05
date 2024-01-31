

class ProposalModel {

  ProposalModel(
      {this.proposalId,
        this.cost,
        this.currency,
        this.name,
        this.imageId,
        this.country,
        this.flagUrl,
        this.rating,
        this.subscription});

  ProposalModel.fromJson(Map<String, dynamic> json) {
    proposalId = json['proposalId'];
    cost = json['cost'];
    currency = json['currency'];
    name = json['name'];
    imageId = json['imageId'];
    country = json['country'];
    flagUrl = json['flagUrl'];
    rating = json['rating'];
    subscription = json['subscription'];
  }
  String? proposalId;
  String? cost;
  String? currency;
  String? name;
  String? imageId;
  String? country;
  String? flagUrl;
  int? rating;
  String? subscription;
}