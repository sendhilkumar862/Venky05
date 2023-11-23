import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'student_profile_view_model.g.dart';


class StudentProfileViewModel = StudentProfileViewModelBase with _$StudentProfileViewModel;

abstract class StudentProfileViewModelBase  with Store {

@observable
  int b = 0;

@action
  void incre()
  {
    b++;
  }
  @observable
  TextEditingController dateController = TextEditingController();

}


