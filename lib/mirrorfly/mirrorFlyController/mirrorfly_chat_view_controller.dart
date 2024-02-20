import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mirrorfly_plugin/flychat.dart';
import 'package:mirrorfly_plugin/model/user_list_model.dart';

import '../../custom/loader/easy_loader.dart';


class MirrorFlyChatViewController extends GetxController {

  @override
  void onInit() async{
    showLoading();
    //  TODO: implement onInit
    super.onInit();
    getChatList();
    var userJid = await Mirrorfly.getJid('');
    hideLoading();
  }


  RxList<Profile> chatList = <Profile>[].obs;

  getChatList() async {
    // Mirrorfly.getUserList(1, '',).then((data) {
    //   var list = userListFromJson(data);
    //   if (list.data != null) {
    //     chatList.addAll(list.data!);
    //   }
    // });
  }
}