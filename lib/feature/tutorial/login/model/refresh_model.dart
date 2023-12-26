class RefreshModelClass {

  RefreshModelClass({this.userId, this.auth});

  RefreshModelClass.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    auth = json['auth'] != null ? Auth.fromJson(json['auth']) : null;
  }
  String? userId;
  Auth? auth;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    if (auth != null) {
      data['auth'] = auth!.toJson();
    }
    return data;
  }
}

class Auth {

  Auth({this.accessToken, this.accessTokenExpiryTime});

  Auth.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    accessTokenExpiryTime = json['accessTokenExpiryTime'];
  }
  String? accessToken;
  int? accessTokenExpiryTime;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['accessTokenExpiryTime'] = accessTokenExpiryTime;
    return data;
  }
}