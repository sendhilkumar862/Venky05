// import 'dart:io';
//
// import 'package:get/get.dart';
// import 'package:mirrorfly_plugin/mirrorfly.dart';
//
// class MirrorFlyAuthController extends GetxController {
//   String? userJid;
//
//
//  // ignore: always_declare_return_types
//  getUserJID(String username) {
//     if(!Mirrorfly.isChatHistoryEnabled && Platform.isAndroid) {
//       Mirrorfly.getAllGroups(true); // chat history enabled so this no longer need
//     }
//     Mirrorfly.getJid(username).then((String? value) {
//       if (value != null) {
//         userJid=value;
//       }
//     // ignore: always_specify_types
//     }).catchError((error) {
//
//     });
//   }
//
//
//   Future<void> registerAccount(String user) async {
//       Mirrorfly.registerUser(
//           user)
//           // ignore: always_specify_types
//           .then((value) {
//         // ignore: avoid_dynamic_calls
//         if (value.contains('data')) {
//
//         }
//       // ignore: always_specify_types
//       }).catchError((error) {
//
//       });
//     }
//
// // ignore: always_declare_return_types, non_constant_identifier_names
//   sendMessage(Profile profile) async {
//     removeUnreadSeparator();
//     var busyStatus = !profile.isGroupProfile.checkNull()
//         ? await Mirrorfly.isBusyStatusEnabled()
//         : false;
//     if (!busyStatus.checkNull()) {
//       var replyMessageId = "";
//
//       if (isReplying.value) {
//         replyMessageId = replyChatMessage.messageId;
//       }
//       isReplying(false);
//       if (messageController.text.trim().isNotEmpty) {
//         Mirrorfly.sendTextMessage(messageController.text.trim(),
//             profile.jid.toString(),replyMessageId,topicId: topicId)
//             .then((value) {
//           mirrorFlyLog("text message", value);
//           messageController.text = "";
//           isUserTyping(false);
//           clearMessage();
//           ChatMessageModel chatMessageModel = sendMessageModelFromJson(value);
//           mirrorFlyLog(
//               "inserting chat message",
//               chatMessageModel.replyParentChatMessage?.messageType ??
//                   "value is null");
//           // chatList.insert(0, chatMessageModel);
//           scrollToBottom();
//           updateLastMessage(value);
//         });
//       }
//     } else {
//       //show busy status popup
//       messageObject = MessageObject(
//           toJid: profile.jid.toString(),
//           replyMessageId: (isReplying.value) ? replyChatMessage.messageId : "",
//           messageType: Constants.mText,
//           textMessage: messageController.text.trim());
//       showBusyStatusAlert(disableBusyChatAndSend);
//     }
//   }
// }