import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';



class ChatController extends GetxController{
  TextEditingController chatController = TextEditingController();
  final FlutterContactPicker contactPicker = new FlutterContactPicker();
  List<Contact>? contacts;
  RxBool isOnTapMic = false.obs;
  RxBool isOnTapSend = false.obs;
  File? selectedImage;
  List<Chat> message = <Chat>[];
  RxBool isSwipeRight = false.obs;


  getChatTimeFormate(int time) {
    final int millisecondsSinceEpoch = time; // Example timestamp

    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final String formattedTime = DateFormat('HH:mm').format(dateTime);

    return formattedTime;
  }


  String headerTimestamp(int timestamp) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('MMM d, y').format(dateTime);
  }
}

class Chat {
  Chat(this.message, this.isCheck);

  String? message;
  bool? isCheck;
}