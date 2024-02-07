class GetWalletBalanceTransModel {

  GetWalletBalanceTransModel(
      {this.id,
        this.walletId,
        this.userId,
        this.amount,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.description});

  GetWalletBalanceTransModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletId = json['wallet_id'];
    userId = json['user_id'];
    amount = json['amount'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
  }
  String? id;
  String? walletId;
  int? userId;
  String? amount;
  String? type;
  String? status;
  int? createdAt;
  int? updatedAt;
  String? description;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wallet_id'] = walletId;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['description'] = description;
    return data;
  }
}