import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mirrorfly_plugin/flychat.dart';
import '../../custom/loader/easy_loader.dart';
import '../../feature/tutorial/messages/model/chat_message_model.dart';


class MirrorFlyChatViewController extends GetxController {
  String userJid='';
  RxString message=''.obs;
  String userName='';
  String croppedFilePath = '';
  RxList<ChatMessageModel> chatMessageModel=<ChatMessageModel>[].obs;
  @override
  onInit() async{
    super.onInit();

     userJid = Get.arguments['JID'];
     userName=Get.arguments['UserName'];
    getMessage();
    Mirrorfly.onMessageReceived.listen((event) {
      final ChatMessageModel chatData = sendMessageModelFromJson(event);
      chatMessageModel.add(chatData);
    });
  }

  // ignore: always_declare_return_types
  sendMessage() async {
    // ignore: avoid_dynamic_calls
    Mirrorfly.sendTextMessage(message.value, userJid, '').then((value) {
      final ChatMessageModel data = sendMessageModelFromJson(value);
      chatMessageModel.add(data);
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
  // ignore: always_declare_return_types
  sendImageMessage(String imageFile,String replyMessageId,String caption){
    // ignore: avoid_dynamic_calls, always_specify_types
    Mirrorfly.sendImageMessage(userJid, imageFile,caption, replyMessageId).then((value) {
      final ChatMessageModel data = sendMessageModelFromJson(value);
      chatMessageModel.add(data);
    });
  }



  // ignore: always_declare_return_types
  sendDocumentMessage(String documentFile,String replyMessageId,String caption){
    // ignore: avoid_dynamic_calls, always_specify_types
    Mirrorfly.sendDocumentMessage(userJid, documentFile, replyMessageId).then((value) {
      final ChatMessageModel data = sendMessageModelFromJson(value);
      chatMessageModel.add(data);
    });
  }

}