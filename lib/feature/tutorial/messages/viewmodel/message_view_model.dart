import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'message_view_model.g.dart';

class MessageViewModel = _MessageViewModelBase with _$MessageViewModel;

abstract class _MessageViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
  }

  @observable
  TextEditingController searchTeacherController = TextEditingController();

  @observable
  int selectedIndex = 1;

  @observable
  List<bool> isSelectReadStatus = [false,false];

  @observable
  List<bool> isSelectNewStatus = [false,false];

  @observable
  List readStatus = <String>['Read', 'Unread'];

  @observable
  List newStatus = <String>['New to Old', 'Old to View'];
}
