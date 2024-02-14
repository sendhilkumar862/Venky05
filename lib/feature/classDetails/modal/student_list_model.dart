import 'package:hessah/feature/classDetails/modal/students_model.dart';

class StudentsListModel {
  StudentsListModel(
      {this.canAcceptOrRejectStudent,
        this.students,
       });

  StudentsListModel.fromJson(Map<String, dynamic> json) {
    canAcceptOrRejectStudent = json['canAcceptOrRejectStudent'];
    // ignore: avoid_dynamic_calls
    if (json['students'] != null) {
      students = <StudentsModel>[];
      // ignore: avoid_dynamic_calls
      json['students'].forEach((v) {
        students!.add(StudentsModel.fromJson(v));
      });
    };

  }
  bool? canAcceptOrRejectStudent;
  List<StudentsModel>? students;

}