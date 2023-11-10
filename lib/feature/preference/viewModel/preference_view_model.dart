import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../data/repo/repo.dart';
import '../../../models/response_model/error_response_model.dart';
import '../model/preference_model.dart';

part 'preference_view_model.g.dart';

class PreferenceViewModel = _PreferenceViewModelBase with _$PreferenceViewModel;

abstract class _PreferenceViewModelBase extends BaseViewModel with Store {
  @observable
  List<Curriculum>? grade;

  @observable
  List<Curriculum>? schoolType;

  @observable
  List<Curriculum>? curriculum;

  @observable
  List<Curriculum>? subject;

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    UserRepo.getInstance()
        .getUserPreference()
        .then((Either<ErrorResponseModel, PreferenceModel> response) {
      response.fold((ErrorResponseModel l) {}, (PreferenceModel r) {
        runInAction(() {
          grade = r.data?.item?.grade;
          schoolType = r.data?.item?.schoolType;
          curriculum = r.data?.item?.curriculum;
          subject = r.data?.item?.subject;
        });
      });
    });
  }
}
