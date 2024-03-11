class FavouriteStudentModel {

  FavouriteStudentModel(
      {this.userId,
        this.createdAt,
        this.subject,
        this.school,
        this.curriculum,
        this.grade,
        this.name,
        this.imageId,
        this.isBookmarked});

  FavouriteStudentModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    createdAt = json['createdAt'];
    // ignore: avoid_dynamic_calls
    subject = json['subject'].cast<String>();
    // ignore: avoid_dynamic_calls
    school = json['school'].cast<String>();
    // ignore: avoid_dynamic_calls
    curriculum = json['curriculum'].cast<String>();
    // ignore: avoid_dynamic_calls
    grade = json['grade'].cast<String>();
    name = json['name'];
    imageId = json['imageId'];
    isBookmarked = json['isBookmarked'];
  }
  int? userId;
  int? createdAt;
  List<String>? subject;
  List<String>? school;
  List<String>? curriculum;
  List<String>? grade;
  String? name;
  String? imageId;
  int? isBookmarked;
}