
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../mirrorfly/mirrorFlyController/mirrorfly_chat_view_controller.dart';

class ChatMediaFile extends StatefulWidget {
  String mediaId;
   ChatMediaFile({Key? key,required this.mediaId}) : super(key: key);

  @override
  State<ChatMediaFile> createState() => _ChatMediaFileState();
}

class _ChatMediaFileState extends State<ChatMediaFile> {
  final MirrorFlyChatViewController _mirrorFlyChatViewController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mirrorFlyChatViewController.downloadMedia(widget.mediaId);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
