class FavouritesTeacherModel {

  FavouritesTeacherModel(
      {this.bookmarkId,
        this.userId,
        this.firstName,
        this.lastName,
        this.country,
        this.flagUrl,
        this.rating,
        this.subscription,
        this.createdAt,
      this.isBookmarked,
      this.imageId});

  FavouritesTeacherModel.fromJson(Map<String, dynamic> json) {
    bookmarkId = json['bookmarkId'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    country = json['country'];
    flagUrl = json['flagUrl'];
    rating = json['rating'];
    subscription = json['subscription'];
    createdAt=json['createdAt'];
    isBookmarked=json['isBookmarked'];
    imageId=json['imageId'];
  }
  int? bookmarkId;
  int? userId;
  String? firstName;
  String? lastName;
  String? country;
  String? flagUrl;
  num? rating;
  String? subscription;
  int? createdAt;
  int?isBookmarked;
  String? imageId;


}