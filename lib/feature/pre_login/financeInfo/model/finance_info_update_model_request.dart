class FinanceInfoUpdateRequest {

  FinanceInfoUpdateRequest.fromJson(Map<String, dynamic> json) {
    iban = json['iban'];
    isDefault = json['isDefault'];
    nickName = json['nickName'];
  }

  FinanceInfoUpdateRequest({this.iban, this.isDefault, this.nickName});
  String? iban;
  bool? isDefault;
  String? nickName;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iban'] = iban;
    data['isDefault'] = isDefault;
    data['nickName'] = nickName;
    return data;
  }
}