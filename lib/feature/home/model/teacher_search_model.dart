

class TeacherSearchModel {

TeacherSearchModel({this.userId, this.firstName, this.lastName, this.nationality,this.rating});

TeacherSearchModel.fromJson(Map<String, dynamic> json) {
userId = json['userId'];
firstName = json['firstName'];
lastName = json['lastName'];
nationality = json['nationality'];
rating = json['rating'];
}
int? userId;
String? firstName;
String? lastName;
String? nationality;
num? rating;
}