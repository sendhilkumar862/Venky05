import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

  RxBool isTeacherView = true.obs;


  TextEditingController dateController = TextEditingController();


  RxBool isFavorite = false.obs;


  void setFavorite() {
    isFavorite.value = !isFavorite.value;
  }
}
