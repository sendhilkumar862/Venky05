class GetWalletBalanceListModel {
  String? id;
  String? walletId;
  int? userId;
  String? amount;
  String? type;
  String? status;
  int? createdAt;
  int? updatedAt;
  String? description;

  GetWalletBalanceListModel(
      {this.id,
        this.walletId,
        this.userId,
        this.amount,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.description});

  GetWalletBalanceListModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wallet_id'] = this.walletId;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['description'] = this.description;
    return data;
  }
}