import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mirrorfly_plugin/flychat.dart';
import 'package:mirrorfly_plugin/model/available_features.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../mirrorfly/mirrorFlyController/mirrorfly_chat_view_controller.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/extension/string_extension.dart';
import '../../messages/model/chat_message_model.dart';

class ImageMessageView extends StatelessWidget {
  ImageMessageView(
      {super.key,
      required this.chatMessage,
      this.search = '',
      required this.isSelected});

  final ChatMessageModel chatMessage;
  final String search;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var mediaMessage = chatMessage.mediaChatMessage!;
    // var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.60,
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: getImage(
                    mediaMessage.mediaLocalStoragePath,
                    mediaMessage.mediaThumbImage,
                    context,
                    mediaMessage.mediaFileName,
                    isSelected),
              ),
              getImageOverlay(chatMessage),
              if (mediaMessage.mediaCaptionText.checkNull().isEmpty)
                Positioned(
                  bottom: 8,
                  right: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      getMessageIndicator(
                          chatMessage.messageStatus.value,
                          chatMessage.isMessageSentByMe,
                          chatMessage.messageType,
                          chatMessage.isMessageRecalled.value),
                      const SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  getImage(String mediaLocalStoragePath, String mediaThumbImage,
      BuildContext context, String mediaFileName, bool isSelected) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    if (checkFile(mediaLocalStoragePath)) {
      return InkWell(
          onTap: () {},
          child: Image(
            image: FileImage(File(mediaLocalStoragePath)),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return FutureBuilder(
                    future: null,
                    builder: (context, d) {
                      return child;
                    });
              }
              return const Center(child: CircularProgressIndicator());
            },
            width: screenWidth * 0.60,
            height: screenHeight * 0.4,
            fit: BoxFit.cover,
          ) /*Image.file(
            File(mediaLocalStoragePath),
            width: controller.screenWidth * 0.60,
            height: controller.screenHeight * 0.4,
            fit: BoxFit.cover,
          )*/
          );
    } else {
      return imageFromBase64String(mediaThumbImage, context, null, null);
    }
  }
}

Widget getImageOverlay(ChatMessageModel chatMessage,
    {Function()? onAudio, Function()? onVideo}) {
  // debugPrint(
  //     "getImageOverlay checkFile ${checkFile(chatMessage.mediaChatMessage!.mediaLocalStoragePath)}");
  // debugPrint("getImageOverlay messageStatus ${chatMessage.messageStatus}");
  // debugPrint(
  //     "getImageOverlay ${(checkFile(chatMessage.mediaChatMessage!.mediaLocalStoragePath) && chatMessage.messageStatus != 'N')}");
  if (checkFile(chatMessage.mediaChatMessage!.mediaLocalStoragePath) &&
      chatMessage.messageStatus.value != 'N') {
    if (chatMessage.messageType.toUpperCase() == 'VIDEO') {
      return FloatingActionButton.small(
        onPressed: onVideo,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.play_arrow_rounded,
          color: Colors.red,
        ),
      );
    } else if (chatMessage.messageType.toUpperCase() == 'AUDIO') {
      return InkWell(
        onTap: onAudio,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: chatMessage.mediaChatMessage!.isPlaying
              ? Image.asset(
                  ImageConstants.pauseIcon,
                  height: 17,
                ) //const Icon(Icons.pause)
              : Image.asset(
                  ImageConstants.playIcon,
                  height: 17,
                ),
        ),
      ); //const Icon(Icons.play_arrow_sharp);
    } else {
      return const SizedBox.shrink();
    }
  } else {
    // debugPrint(
    //     "overlay status-->${chatMessage.isMessageSentByMe ? chatMessage.mediaChatMessage!.mediaUploadStatus : chatMessage.mediaChatMessage!.mediaDownloadStatus}");
    switch (chatMessage.isMessageSentByMe
        ? chatMessage.mediaChatMessage!.mediaUploadStatus
        : chatMessage.mediaChatMessage!.mediaDownloadStatus) {
      case ApplicationConstants.mediaDownloaded:
      case ApplicationConstants.mediaUploaded:
      case ApplicationConstants.mediaDownloadedNotAvailable:
      case ApplicationConstants.mediaUploadedNotAvailable:
        return const SizedBox.shrink();
      case ApplicationConstants.mediaNotDownloaded:
        return InkWell(
          child: downloadView(
              chatMessage.mediaChatMessage!.mediaDownloadStatus,
              chatMessage.mediaChatMessage!.mediaFileSize,
              chatMessage.messageType.toUpperCase()),
          onTap: () {
            downloadMedia(chatMessage.messageId);
          },
        );
      case ApplicationConstants.mediaNotUploaded:
        return InkWell(
            onTap: () {
              uploadMedia(chatMessage.messageId);
            },
            child: uploadView(
                chatMessage.mediaChatMessage!.mediaDownloadStatus,
                chatMessage.mediaChatMessage!.mediaFileSize,
                chatMessage.messageType.toUpperCase()));

      case ApplicationConstants.mediaDownloading:
      case ApplicationConstants.mediaUploading:
        return InkWell(onTap: () {
          cancelMediaUploadOrDownload(chatMessage.messageId);
        }, child: Obx(() {
          return downloadingOrUploadingView(chatMessage.messageType,
              chatMessage.mediaChatMessage!.mediaProgressStatus.value);
        }));
      default:
        return const SizedBox.shrink();
    }
  }
}

getMessageIndicator(
    String? messageStatus, bool isSender, String messageType, bool isRecalled) {
  // debugPrint("Message Status ==>");
  // debugPrint("Message Status ==> $messageStatus");
  if (messageType.toUpperCase() != ApplicationConstants.mNotification) {
    if (isSender && !isRecalled) {
      if (messageStatus == 'A') {
        return SvgPicture.asset(ImageConstants.acknowledgedIcon);
      } else if (messageStatus == 'D') {
        return SvgPicture.asset(ImageConstants.deliveredIcon);
      } else if (messageStatus == 'S') {
        return SvgPicture.asset(ImageConstants.seenIcon);
      } else if (messageStatus == 'N') {
        return SvgPicture.asset(ImageConstants.unSendIcon);
      } else {
        return const SizedBox.shrink();
      }
    } else {
      return const SizedBox.shrink();
    }
  } else {
    return const SizedBox.shrink();
  }
}

bool checkFile(String mediaLocalStoragePath) {
  return mediaLocalStoragePath.isNotEmpty &&
      File(mediaLocalStoragePath).existsSync();
}

Image imageFromBase64String(
    String base64String, BuildContext context, double? width, double? height) {
  var decodedBase64 = base64String.replaceAll("\n", "");
  Uint8List image = const Base64Decoder().convert(decodedBase64);
  return Image.memory(
    image,
    width: width ?? MediaQuery.of(context).size.width * 0.60,
    height: height ?? MediaQuery.of(context).size.height * 0.4,
    fit: BoxFit.cover,
  );
}

void downloadMedia(String messageId) async {
  var permission = await getStoragePermission();
  if (permission) {
    debugPrint("media permission granted");
    final MirrorFlyChatViewController _mirrorFlyChatViewController = Get.find();
    _mirrorFlyChatViewController.downloadMedia(messageId);
  } else {
    debugPrint("storage permission not granted");
  }
}

Future<bool> getStoragePermission() async {
  var sdkVersion = 0;
  if (Platform.isAndroid) {
    var sdk = await DeviceInfoPlugin().androidInfo;
    sdkVersion = sdk.version.sdkInt;
  } else {
    sdkVersion = 0;
  }
  if (sdkVersion < 33) {
    final permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      const newPermission = Permission.storage;
      var deniedPopupValue = await mirrorFlyPermissionDialog(
          icon: ImageConstants.filePermission,
          content: ApplicationConstants.filePermission);
      if (deniedPopupValue) {
        var newp = await newPermission.request();
        if (newp.isGranted) {
          return true;
        } else {
          return false;
        }
      } else {
        return newPermission.status.isGranted;
      }
    } else {
      return permission.isGranted;
    }
  } else {
    return getAndroid13Permission();
  }
}

Future<bool> getAndroid13Permission() async {
  final photos = await Permission.photos.status;
  final videos = await Permission.videos.status;
  final mediaLibrary = await Permission.mediaLibrary.status;
// final audio = await Permission.audio.status;
  const newPermission = [
    Permission.photos,
    Permission.videos,
    Permission.mediaLibrary,
    // Permission.audio
  ];
  if ((photos != PermissionStatus.granted &&
          photos != PermissionStatus.permanentlyDenied) ||
      (videos != PermissionStatus.granted &&
          videos != PermissionStatus.permanentlyDenied) ||
      (mediaLibrary != PermissionStatus.granted &&
          mediaLibrary != PermissionStatus.permanentlyDenied)) {

    var deniedPopupValue = await mirrorFlyPermissionDialog(
        icon: ImageConstants.filePermission, content: ApplicationConstants.filePermission);
    if (deniedPopupValue) {
      var newp = await newPermission.request();
      PermissionStatus? photo = newp[Permission.photos];
      PermissionStatus? video = newp[Permission.videos];
      PermissionStatus? mediaLibrary = newp[Permission.mediaLibrary];
// var audio = await newPermission[2].isGranted;
      if (photo!.isGranted && video!.isGranted && mediaLibrary!.isGranted) {
        return true;
      } else if (photo.isPermanentlyDenied ||
          video!.isPermanentlyDenied ||
          mediaLibrary!.isPermanentlyDenied) {

          return false;
      } else {
        return false;
      }
    } else {
      return false; //PermissionStatus.denied;
    }
  } else {
    return (photos.isGranted && videos.isGranted && mediaLibrary.isGranted);
// ? photos
// : photos;
  }
}

Future<bool> customPermissionDialog(
    {required String icon, required String content}) async {
  return await Get.dialog(AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: WillPopScope(
      onWillPop: () {
        Get.back(result: false);
        return Future.value(true);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 35.0),
            color: Colors.deepOrange,
            child: Center(child: SvgPicture.asset(icon)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {
            Get.back(result: false);
// notNowBtn();
          },
          child: const Text(
            "NOT NOW",
            style: TextStyle(color: Colors.green),
          )),
      TextButton(
          onPressed: () {
            Get.back(result: true);
// continueBtn();
          },
          child: const Text(
            "CONTINUE",
            style: TextStyle(color: Colors.deepOrange),
          ))
    ],
  ));
}

Future<bool> mirrorFlyPermissionDialog(
    {required String icon, required String content}) async {
  return await Get.dialog(AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: WillPopScope(
      onWillPop: () {
        Get.back(result: false);
        return Future.value(false);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 35.0),
            color: Colors.deepOrange,
            child: Center(child: SvgPicture.asset(icon)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(fontSize: 14, color: Colors.deepOrange),
            ),
          )
        ],
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {
            Get.back(result: false);
// notNowBtn();
          },
          child: const Text(
            "NOT NOW",
            style: TextStyle(color: Colors.deepOrange),
          )),
      TextButton(
          onPressed: () {
            Get.back(result: true);
// continueBtn();
          },
          child: const Text(
            "CONTINUE",
            style: TextStyle(color: Colors.deepOrange),
          ))
    ],
  ));
}

Widget downloadView(
    int mediaDownloadStatus, int mediaFileSize, String messageType) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: messageType == 'AUDIO' || messageType == 'DOCUMENT'
        ? Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(3)),
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              ImageConstants.downloadIcon,
              color: Colors.white,
            ))
        : Container(
            width: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: Colors.black.withOpacity(.2),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  ImageConstants.downloadIcon,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  formatBytes(mediaFileSize, 0),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            )),
  );
}

void uploadMedia(String messageId) async {
  Mirrorfly.uploadMedia(messageId);
}

uploadView(int mediaDownloadStatus, int mediaFileSize, String messageType) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: messageType == 'AUDIO' || messageType == 'DOCUMENT'
        ? Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(3)),
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              ImageConstants.uploadIcon,
              color: Colors.grey,
            ))
        : Container(
            width: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.black45,
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(ImageConstants.uploadIcon),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "RETRY",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            )),
  );
}

void cancelMediaUploadOrDownload(String messageId) {
  Mirrorfly.cancelMediaUploadOrDownload(messageId);
}

downloadingOrUploadingView(String messageType, int progress) {
  // debugPrint('downloadingOrUploadingView progress $progress');
  if (messageType == "AUDIO" || messageType == "DOCUMENT") {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            // color: Colors.black45,
          ),
          child: Stack(
              alignment: Alignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageConstants.downloading,
                  fit: BoxFit.contain,
                  color: Colors.grey,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 2,
                    child: LinearProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      ),
                      value: progress == 0 || progress == 100
                          ? null
                          : (progress / 100),
                      backgroundColor: Colors.transparent,
                      // minHeight: 1,
                    ),
                  ),
                ),
              ])),
    );
  } else {
    return Container(
        height: 30,
        width: 70,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.black45,
        ),
        child: Stack(
            alignment: Alignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImageConstants.downloading,
                fit: BoxFit.contain,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 2,
                  child: LinearProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                    value: progress == 0 || progress == 100
                        ? null
                        : (progress / 100),
                    backgroundColor: Colors.transparent,
                    // minHeight: 1,
                  ),
                ),
              ),
            ]));
  }
}

class AttachmentsSheetView extends StatelessWidget {
  const AttachmentsSheetView(
      {Key? key,
      required this.availableFeatures,
      required this.attachments,
      required this.onDocument,
      required this.onCamera,
      required this.onGallery,
      required this.onAudio,
      required this.onContact,
      required this.onLocation})
      : super(key: key);
  final Rx<AvailableFeatures> availableFeatures;
  final RxList<AttachmentIcon> attachments;
  final Function() onDocument;
  final Function() onCamera;
  final Function() onGallery;
  final Function() onAudio;
  final Function() onContact;
  final Function() onLocation;

  @override
  Widget build(BuildContext context) {
    // final attachments = [AttachmentIcon(documentImg, "Document", onDocument),AttachmentIcon(cameraImg, "Camera", onCamera),AttachmentIcon(galleryImg, "Gallery", onGallery),AttachmentIcon(audioImg, "Audio", onAudio),AttachmentIcon(contactImg, "Contact", onContact),AttachmentIcon(locationImg, "Location", onLocation)];
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Obx(() {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1),
              itemCount: attachments.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctx, index) {
                return iconCreation(
                    attachments[index].iconPath,
                    attachments[index].text,
                    (attachments[index].text == "Document")
                        ? onDocument
                        : (attachments[index].text == "Camera")
                            ? onCamera
                            : (attachments[index].text == "Gallery")
                                ? onGallery
                                : (attachments[index].text == "Audio")
                                    ? onAudio
                                    : (attachments[index].text == "Contact")
                                        ? onContact
                                        : (attachments[index].text ==
                                                "Location")
                                            ? onLocation
                                            : () {});
              });
        }),
        /*Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  availableFeatures.value.isDocumentAttachmentAvailable.checkNull() ? iconCreation(
                      documentImg, "Document", onDocument) : const SizedBox.shrink(),
                  (availableFeatures.value.isImageAttachmentAvailable.checkNull() ||
                      availableFeatures.value.isVideoAttachmentAvailable.checkNull()) ? iconCreation(
                      cameraImg, "Camera", onCamera) : const SizedBox.shrink(),
                  (availableFeatures.value.isImageAttachmentAvailable.checkNull() ||
                      availableFeatures.value.isVideoAttachmentAvailable.checkNull()) ? iconCreation(
                      galleryImg, "Gallery", onGallery) : const SizedBox.shrink(),
                ],
              );
            }),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                availableFeatures.value.isAudioAttachmentAvailable.checkNull() ? iconCreation(
                    audioImg, "Audio", onAudio) : const SizedBox.shrink(),
                availableFeatures.value.isContactAttachmentAvailable.checkNull() ? iconCreation(
                    contactImg, "Contact", onContact) : const SizedBox.shrink(),
                availableFeatures.value.isLocationAttachmentAvailable.checkNull() ? iconCreation(
                    locationImg, "Location", onLocation) : const SizedBox.shrink(),
              ],
            ),
          ],
        ),*/
      ),
    );
  }
}

class AttachmentIcon {
  String iconPath;
  String text;

  AttachmentIcon(this.iconPath, this.text);
}

Widget iconCreation(String iconPath, String text, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        SvgPicture.asset(iconPath),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        )
      ],
    ),
  );
}

Widget chatSpannedText(String text, String spannableText, TextStyle? style,
    {int? maxLines}) {
  var startIndex = text.toLowerCase().contains(spannableText.toLowerCase())
      ? text.toLowerCase().indexOf(spannableText.toLowerCase())
      : -1;
  var endIndex = startIndex + spannableText.length;
  if (startIndex != -1 && endIndex != -1) {
    var startText = text.substring(0, startIndex);
    var colorText = text.substring(startIndex, endIndex);
    var endText = text.substring(endIndex, text.length);
    return Text.rich(
      TextSpan(
          text: startText,
          children: [
            TextSpan(
                text: colorText, style: const TextStyle(color: Colors.orange)),
            TextSpan(text: endText)
          ],
          style: style),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  } else {
    return const SizedBox.shrink(); //Text(text, style: style);
  }
}

class AudioMessagePlayerController extends GetxController {
  final _obj = ''.obs;

  set obj(value) => _obj.value = value;

  get obj => _obj.value;
  var maxDuration = 100.obs;
  var currentPos = 0.obs;
  var currentPlayingPosId = "0".obs;
  String currentPostLabel = "00:00";
  var audioPlayed = false.obs;
  AudioPlayer player = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    player.onPlayerComplete.listen((event) {
      playingChat!.mediaChatMessage!.isPlaying = false;
      playingChat!.mediaChatMessage!.currentPos = 0;
      player.stop();
      //chatList.refresh();
    });

    player.onPositionChanged.listen((Duration p) {
      playingChat?.mediaChatMessage!.currentPos = (p.inMilliseconds);
      //chatList.refresh();
    });
  }

  ChatMessageModel? playingChat;

  playAudio(ChatMessageModel chatMessage, String filePath) async {
    if (playingChat != null) {
      if (playingChat?.mediaChatMessage!.messageId != chatMessage.messageId) {
        player.stop();
        playingChat?.mediaChatMessage!.isPlaying = false;
        playingChat = chatMessage;
      }
    } else {
      playingChat = chatMessage;
    }
    if (!playingChat!.mediaChatMessage!.isPlaying) {
      // player.play(
      //       playingChat!.mediaChatMessage!.mediaLocalStoragePath ,
      //       position:
      //       Duration(milliseconds: playingChat!.mediaChatMessage!.currentPos),
      //       );

      playingChat!.mediaChatMessage!.isPlaying = true;
    } else if (!playingChat!.mediaChatMessage!.isPlaying) {
      await player.resume();

      playingChat!.mediaChatMessage!.isPlaying = true;
    } else {
      player.pause();

      playingChat!.mediaChatMessage!.isPlaying = false;
    }
  }
}

/// Checks the current header id with previous header id
/// @param position Position of the current item
/// @return boolean True if header changed, else false
bool isDateChanged(int position, List<ChatMessageModel> mChatData) {
  // try {
  var prePosition = position + 1;
  var size = mChatData.length - 1;
  if (position == size) {
    return true;
  } else {
    if (prePosition <= size && position <= size) {
      // debugPrint("position $position $size");
      // debugPrint("sentTime ${mChatData[position].messageSentTime}");
      // debugPrint("pre sentTime ${mChatData[prePosition].messageSentTime}");
      var currentHeaderId = mChatData[position].messageSentTime.toInt();
      var previousHeaderId = mChatData[prePosition].messageSentTime.toInt();
      return currentHeaderId != previousHeaderId;
    }
  }
  // }catch(e){
  //   return false;
  // }
  return false; //currentHeaderId != previousHeaderId;
}

String? groupedDateMessage(int index, List<ChatMessageModel> chatList) {
  if (index == chatList.length - 1) {
    return addDateHeaderMessage(chatList.last);
  } else {
    return (isDateChanged(index, chatList) &&
            (addDateHeaderMessage(chatList[index + 1]) !=
                addDateHeaderMessage(chatList[index])))
        ? addDateHeaderMessage(chatList[index])
        : null;
  }
}

String getDateFromTimestamp(int convertedTime, String format) {
  var calendar = DateTime.fromMicrosecondsSinceEpoch(convertedTime);
  return DateFormat(format).format(calendar);
}

String addDateHeaderMessage(ChatMessageModel item) {
  var calendar = DateTime.now();
  var messageDate = getDateFromTimestamp(item.messageSentTime, "MMMM dd, yyyy");
  var monthNumber = calendar.month - 1;
  var month = getMonthForInt(monthNumber);
  var yesterdayDate = DateTime.now().subtract(const Duration(days: 1)).day;
  var today = "$month ${checkTwoDigitsForDate(calendar.day)}, ${calendar.year}";
  var yesterday =
      "$month ${checkTwoDigitsForDate(yesterdayDate)}, ${calendar.year}";
  // var dateHeaderMessage = ChatMessage()
  // debugPrint("messageDate $messageDate");
  // debugPrint("today $today");
  // debugPrint("yesterday $yesterday");
  if (messageDate.toString() == (today).toString()) {
    return "Today";
    //dateHeaderMessage = createDateHeaderMessageWithDate(date, item)
  } else if (messageDate == yesterday) {
    return "Yesterday";
    //dateHeaderMessage = createDateHeaderMessageWithDate(date, item)
  } else if (!messageDate.contains("1970")) {
    //dateHeaderMessage = createDateHeaderMessageWithDate(messageDate, item)
    return messageDate;
  }
  return "";
}

String checkTwoDigitsForDate(int date) {
  if (date.toString().length != 2) {
    return "0$date";
  } else {
    return date.toString();
  }
}

String getMonthForInt(int num) {
  var month = "";
  var dateFormatSymbols = DateFormat().dateSymbols.STANDALONEMONTHS;
  var months = dateFormatSymbols;
  if (num <= 11) {
    month = months[num];
  }
  return month;
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}
