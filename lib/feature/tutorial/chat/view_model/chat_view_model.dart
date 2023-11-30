import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'chat_view_model.g.dart';

class ChatViewModel = _ChatViewModelBase with _$ChatViewModel;

abstract class _ChatViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  TextEditingController chatController = TextEditingController();

  @observable
  bool isOnTapMic = false;

  @observable
  bool isOnTapPause = false;

  @observable
  File? selectedImage;

  @observable
  List<Chat> message = <Chat>[];

  @action
  getChatTimeFormate(int time) {
    final int millisecondsSinceEpoch = time; // Example timestamp

    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final String formattedTime = DateFormat('HH:mm').format(dateTime);

    return formattedTime;
  }

  @action
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
