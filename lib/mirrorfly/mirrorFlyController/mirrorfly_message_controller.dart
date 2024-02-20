import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mirrorfly_plugin/flychat.dart';
import 'package:mirrorfly_plugin/model/user_list_model.dart';

import '../../custom/loader/easy_loader.dart';


class MirrorFlyMessageController extends GetxController {

  @override
  void onInit() {
    showLoading();
    // TODO: implement onInit
    super.onInit();
    getUsersList();
    hideLoading();
  }

  RxList<Profile> userList = <Profile>[].obs;

  getUsersList() async {
    Mirrorfly.getUserList(1, '',).then((data) {
      var list = userListFromJson(data);
      if (list.data != null) {
        userList.addAll(list.data!);
      }
    });
  }
}