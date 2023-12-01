import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'student_profile_view_model.g.dart';

class StudentProfileViewModel = StudentProfileViewModelBase with _$StudentProfileViewModel;

abstract class StudentProfileViewModelBase  with Store {

  @observable
  TextEditingController dateController = TextEditingController();

@observable
  bool isTeacherView = true;

}


