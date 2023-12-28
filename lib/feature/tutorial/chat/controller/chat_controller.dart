import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import '../../../../product/network/local/key_value_storage_service.dart';


class ChatController extends GetxController{
  final KeyValueStorageService keyValueStorageService =
  KeyValueStorageService();
  TextEditingController chatController = TextEditingController();
  RxBool isOnTapMic = false.obs;
  RxBool isOnTapPause = false.obs;
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