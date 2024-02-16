class GetWalletBalanceModel {
  GetWalletBalanceModel(
      {this.balance, this.pendingBalance, this.pendingWithdraw});

  GetWalletBalanceModel.fromJson(Map<String, dynamic> json) {
    balance =
        json['balance'] != null ? Balance.fromJson(json['balance']) : null;
    classData =
        json['class'] != null ? ClassData.fromJson(json['class']) : null;
    pendingBalance = json['pendingBalance'];
    pendingWithdraw = json['pendingWithdraw'];
  }

  Balance? balance;
  int? pendingBalance;
  int? pendingWithdraw;
  ClassData? classData;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (balance != null) {
      data['balance'] = balance!.toJson();
    }
    if (classData != null) {
      data['class'] = classData!.toJson();
    }
    data['pendingBalance'] = pendingBalance;
    data['pendingWithdraw'] = pendingWithdraw;
    return data;
  }
}

class Balance {
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

  String? id;
  int? userId;
  String? balance;
  String? pendingPayment;
  String? pendingWithdraw;
  int? createdAt;
  int? updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['balance'] = balance;
    data['pending_payment'] = pendingPayment;
    data['pending_withdraw'] = pendingWithdraw;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ClassData {
  ClassData({this.active, this.newClass});

  ClassData.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    newClass = json['new'];
  }

  int? active;
  int? newClass;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['new'] = newClass;
    return data;
  }
}
