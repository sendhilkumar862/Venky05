class GetWalletBalanceStatsModel {

  GetWalletBalanceStatsModel({this.stats, this.transactions});

  GetWalletBalanceStatsModel.fromJson(Map<String, dynamic> json) {
    if (json['stats'] != null) {
      stats = <Stats>[];
      // ignore: avoid_dynamic_calls
      json['stats'].forEach((v) {
        stats!.add( Stats.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      // ignore: avoid_dynamic_calls
      json['transactions'].forEach((v) {
        transactions!.add( Transactions.fromJson(v));
      });
    }
  }
  List<Stats>? stats;
  List<Transactions>? transactions;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stats != null) {
      data['stats'] = stats!.map((v) => v.toJson()).toList();
    }
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stats {

  Stats(
      {this.month,
        this.totalAmount,
        this.previousMonthAmount,
        this.percentageChange});

  Stats.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    totalAmount = json['total_amount'];
    previousMonthAmount = json['previous_month_amount'];
    percentageChange = json['percentage_change'];
  }
  String? month;
  String? totalAmount;
  String? previousMonthAmount;
  String? percentageChange;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['total_amount'] = totalAmount;
    data['previous_month_amount'] = previousMonthAmount;
    data['percentage_change'] = percentageChange;
    return data;
  }
}

class Transactions {

  Transactions(
      {this.id,
        this.walletId,
        this.userId,
        this.amount,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.description});

  Transactions.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data =  <String, dynamic>{};
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