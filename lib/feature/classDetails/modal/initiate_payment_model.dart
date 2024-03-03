class InitiatePaymentModel {

  InitiatePaymentModel(
      {this.id,
        this.balance,
        this.classCost,
        this.maxParticipants,
        this.sessions,
        this.fees,
        this.totalAmount,
      this.totalClassCost});

  InitiatePaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
    classCost = json['classCost'];
    maxParticipants = json['max_participants'];
    sessions = json['sessions'];
    // ignore: avoid_dynamic_calls, prefer_null_aware_operators
    fees = json['fees']!=null?json['fees'].toDouble():null;
    // ignore: avoid_dynamic_calls
    totalAmount =json['totalAmount'].toDouble();
    totalClassCost = json['totalClassCost'];
  }
  String? id;
  String? balance;
  String? classCost;
  int? maxParticipants;
  int? sessions;
  double? fees;
  double? totalAmount;
  int? totalClassCost;
}