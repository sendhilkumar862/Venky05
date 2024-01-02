import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;


class MessageController extends GetxController{

  TextEditingController searchTeacherController = TextEditingController();
  RxInt selectedIndex = 1.obs;
  RxList<bool> isSelectReadStatus = [false, false].obs;
  RxList<bool> isSelectNewStatus = [false, false].obs;


  RxList readStatus = <String>['Read', 'Unread'].obs;
  RxList newStatus = <String>['New to Old', 'Old to View'].obs;
  RxBool teacherLongPress = false.obs;
  RxBool isSelect = false.obs;
  RxBool selectAll = false.obs;
  int? formattedDate;
  RxList selectedItems = [].obs;
  RxList isSelected = List.filled(50, false).obs;


  void onSelected(int index) {
    isSelected[index] = !isSelected[index];
  }


  void onSelectAll(Function setState) {
    selectAll.value = !selectAll.value;
    if (selectAll.value) {
      isSelected.value = List.filled(50, true);
    } else {
      isSelected.value = List.filled(50, false);
    }
  }



}
