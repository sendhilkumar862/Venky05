
import 'dart:io';

import 'package:flutter/material.dart';

import '../../messages/model/chat_message_model.dart';
import 'chat_widget.dart';


class ImageMedia extends StatefulWidget {
  ImageMedia({super.key,
  required this.chatMessage,
  this.search = "",
  required this.isSelected});
  final ChatMessageModel chatMessage;
  final String search;
  final bool isSelected;

  @override
  State<ImageMedia> createState() => _ChatMediaFileState();
}

class _ChatMediaFileState extends State<ImageMedia> {

  @override
  Widget build(BuildContext context) {
    var mediaMessage = widget.chatMessage.mediaChatMessage!;
    // var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.60,
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: getImage(
                    mediaMessage.mediaLocalStoragePath,
                    mediaMessage.mediaThumbImage,
                    context,
                    mediaMessage.mediaFileName),
              ),
            ],
          ),
        ],
      ),
    );
  }
  getImage(String mediaLocalStoragePath, String mediaThumbImage,
      BuildContext context, String mediaFileName) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    if (checkFile(mediaLocalStoragePath)) {
      return Image(
        image: FileImage(File(mediaLocalStoragePath)),
        width: screenWidth * 0.60,
        height: screenHeight * 0.4,
        fit: BoxFit.cover,
      );
    } else {
      return imageFromBase64String(mediaThumbImage, context, null, null);
    }
  }
}
