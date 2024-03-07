class FavouritesModel {

  FavouritesModel(
      {this.bookmarkId,
        this.userId,
        this.firstName,
        this.lastName,
        this.country,
        this.flagUrl,
        this.rating,
        this.subscription});

  FavouritesModel.fromJson(Map<String, dynamic> json) {
    bookmarkId = json['bookmarkId'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    country = json['country'];
    flagUrl = json['flagUrl'];
    rating = json['rating'];
    subscription = json['subscription'];
  }
  int? bookmarkId;
  int? userId;
  String? firstName;
  String? lastName;
  String? country;
  String? flagUrl;
  int? rating;
  String? subscription;


}