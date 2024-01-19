import 'dart:io';

import 'package:get/get.dart';
import 'package:mirrorfly_plugin/mirrorfly.dart';

class MirrorFlyAuthController extends GetxController {
  String? userJid;


 // ignore: always_declare_return_types
 getUserJID(String username) {
    if(!Mirrorfly.isChatHistoryEnabled && Platform.isAndroid) {
      Mirrorfly.getAllGroups(true); // chat history enabled so this no longer need
    }
    Mirrorfly.getJid(username).then((String? value) {
      if (value != null) {
        userJid=value;
      }
    // ignore: always_specify_types
    }).catchError((error) {

    });
  }


  Future<void> registerAccount(String user) async {
      Mirrorfly.registerUser(user.replaceFirst(RegExp('@'), ''))
          // ignore: always_specify_types
          .then((value) {
        // ignore: avoid_dynamic_calls
        if (value.contains('data')) {
             print(value['data']);
        }
      // ignore: always_specify_types
      }).catchError((error) {
     print(error);
      });
    }

// ignore: always_declare_return_types, non_constant_identifier_names
  sendMessage(Profile profile, String message) async {
    Mirrorfly.sendTextMessage(message, profile.jid??'','').then((value) {
      // you will get the message sent success response
      var chatMessage = sendMessageModelFromJson(value);
    });
  }
}