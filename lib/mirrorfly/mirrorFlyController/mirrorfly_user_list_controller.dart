import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mirrorfly_plugin/flychat.dart';
import 'package:mirrorfly_plugin/model/user_list_model.dart';

import '../../custom/loader/easy_loader.dart';
import '../../feature/tutorial/messages/model/chat_message_model.dart';


class MirrorFlyMessageController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getUsersList();



  }

  RxList<Profile> userList = <Profile>[].obs;

  getUsersList() async {
    showLoading();
    Mirrorfly.getUserList(1, '',200).then((data) {
      var list = userListFromJson(data);
      if (list.data != null) {
        userList.addAll(list.data!);
      }
      hideLoading();
    });

  }



}