
class RegisterRequest {

  RegisterRequest(
      {this.userId,
        this.password,
        this.firstName,
        this.lastName,
        this.isTermsAccepted,
        this.country,
        this.hideUserName});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    isTermsAccepted = json['isTermsAccepted'];
    country = json['country'];
    hideUserName = json['hideUserName'];
  }
  String? userId;
  String? password;
  String? firstName;
  String? lastName;
  bool? isTermsAccepted;
  String? country;
  bool? hideUserName;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['password'] = password;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['isTermsAccepted'] = isTermsAccepted;
    data['country'] = country;
    data['hideUserName'] = hideUserName;
    return data;
  }
}