import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'teaching_info_view_model.g.dart';

class TeachingInfoViewModel = _TeachingInfoViewModelBase
    with _$TeachingInfoViewModel;

abstract class _TeachingInfoViewModelBase extends BaseViewModel with Store {
  ObservableList<String> selectedGrade = ObservableList<String>();
  ObservableList<String> selectedSubject = ObservableList<String>();
  ObservableList<String> selectedSchoolType = ObservableList<String>();
  ObservableList<String> selectedCurriculum = ObservableList<String>();
  ObservableList<String> selectedClassType = ObservableList<String>();

  void addGrade(String item) {
    runInAction(() {
      if (selectedGrade.contains(item)) {
        selectedGrade.remove(item);
      } else {
        selectedGrade.add(item);
      }
    });
  }

  void addSubject(String item) {
    runInAction(() {
      if (selectedSubject.contains(item)) {
        selectedSubject.remove(item);
      } else {
        selectedSubject.add(item);
      }
    });
  }

  void addSchoolType(String item) {
    runInAction(() {
      if (selectedSchoolType.contains(item)) {
        selectedSchoolType.remove(item);
      } else {
        selectedSchoolType.add(item);
      }
    });
  }

  void addCurriculum(String item) {
    runInAction(() {
      if (selectedCurriculum.contains(item)) {
        selectedCurriculum.remove(item);
      } else {
        selectedCurriculum.add(item);
      }
    });
  }

  void addClassType(String item) {
    runInAction(() {
      if (selectedClassType.contains(item)) {
        selectedClassType.remove(item);
      } else {
        selectedClassType.add(item);
      }
    });
  }

  String listToCommaSeparatedString(List<String> list) {
    String commaSeparatedString;
    return commaSeparatedString = list.join(', ');
  }

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
