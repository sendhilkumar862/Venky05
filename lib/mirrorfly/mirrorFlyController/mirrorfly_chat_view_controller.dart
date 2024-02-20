import 'package:get/get.dart';
import 'package:mirrorfly_plugin/flychat.dart';
import '../../custom/loader/easy_loader.dart';
import '../../feature/tutorial/messages/model/chat_message_model.dart';


class MirrorFlyChatViewController extends GetxController {
  String userJid='';
  RxString message=''.obs;
  RxList<ChatMessageModel> chatMessageModel=<ChatMessageModel>[].obs;

  @override
  onInit() async{
    super.onInit();
     userJid = Get.arguments;
    getMessage();

  }

  // ignore: always_declare_return_types
  sendMessage() async {
    // ignore: avoid_dynamic_calls, always_specify_types
    Mirrorfly.sendTextMessage(message.value, userJid, '').then((value) {
      var data = sendMessageModelFromJson(value);
      // you will get the message sent success response
      getMessage();
    });
  }

  // ignore: always_declare_return_types
  getMessage() async {
    showLoading();
    // ignore: avoid_dynamic_calls, always_specify_types
    Mirrorfly.getMessagesOfJid(userJid).then((value) {
       chatMessageModel.value = chatMessageModelFromJson(value);
       hideLoading();
    });

  }
}