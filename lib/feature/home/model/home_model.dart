class HomeModel {

  HomeModel(
      {this.lastName,
        this.imageId,
        this.email,
        this.firstName,
        this.country,
        this.username,
        this.userStatus,
        this.mobile,
        this.userId,
        this.countryCode});



  HomeModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    countryCode = json['countryCode'];
    userId = json['userId'];
    imageId = json['imageId'];
    username = json['username'];
  }
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? mobile;
  String? country;
  String? userStatus;
  String? userId;
  String? imageId;
  String? username;


}