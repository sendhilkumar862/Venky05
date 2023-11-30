import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/utils/validators.dart';

part 'message_view_model.g.dart';

class MessageViewModel = _MessageViewModelBase with _$MessageViewModel;

abstract class _MessageViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  TextEditingController searchTeacherController = TextEditingController();

  @observable
  int selectedIndex = 1;

  @observable
  List<bool> isSelectReadStatus = [false, false];

  @observable
  List<bool> isSelectNewStatus = [false, false];

  @observable
  List readStatus = <String>['Read', 'Unread'];

  @observable
  List newStatus = <String>['New to Old', 'Old to View'];

  @observable
  bool teacherLongPress = false;

  @observable
  bool isSelect = false;

  @observable
  bool selectAll = false;

  @observable
  int? formattedDate;

  @observable
  List selectedItems = [];

  @observable
  List isSelected = List.filled(50, false);

  @action
  void onSelected(int index) {
    isSelected[index] = !isSelected[index];
  }

  @action
  void onSelectAll(Function setState) {
    selectAll = !selectAll;
    if (selectAll) {
      isSelected = List.filled(50, true);
    } else {
      isSelected = List.filled(50, false);
    }
    setState(() {});
  }
}
