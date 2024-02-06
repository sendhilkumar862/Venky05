class GetWalletBalanceModel {
  Balance? balance;
  int? pendingBalance;
  int? pendingWithdraw;

  GetWalletBalanceModel({this.balance, this.pendingBalance, this.pendingWithdraw});

  GetWalletBalanceModel.fromJson(Map<String, dynamic> json) {
    balance =
    json['balance'] != null ? new Balance.fromJson(json['balance']) : null;
    pendingBalance = json['pendingBalance'];
    pendingWithdraw = json['pendingWithdraw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.balance != null) {
      data['balance'] = this.balance!.toJson();
    }
    data['pendingBalance'] = this.pendingBalance;
    data['pendingWithdraw'] = this.pendingWithdraw;
    return data;
  }
}

class Balance {
  String? id;
  int? userId;
  String? balance;
  String? pendingPayment;
  String? pendingWithdraw;
  int? createdAt;
  int? updatedAt;

  Balance(
      {this.id,
        this.userId,
        this.balance,
        this.pendingPayment,
        this.pendingWithdraw,
        this.createdAt,
        this.updatedAt});

  Balance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    balance = json['balance'];
    pendingPayment = json['pending_payment'];
    pendingWithdraw = json['pending_withdraw'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['balance'] = this.balance;
    data['pending_payment'] = this.pendingPayment;
    data['pending_withdraw'] = this.pendingWithdraw;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}