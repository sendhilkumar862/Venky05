import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  Future<void> init() async {}

  @observable
  bool isTeacherView = true;

  @observable
  TextEditingController dateController = TextEditingController();

  @observable
  bool isFavorite = false;

  @action
  void setFavorite() {
    isFavorite = !isFavorite;
  }
}
