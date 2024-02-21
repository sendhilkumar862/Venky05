import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../mirrorfly/mirrorFlyController/mirrorfly_chat_view_controller.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/validators.dart';
import '../../messages/model/chat_message_model.dart';
import '../controller/chat_controller.dart';


class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}
final ChatController _chatController=Get.put(ChatController());
class _ChatViewState extends State<ChatView> {
  final MirrorFlyChatViewController _mirrorFlyChatViewController=Get.put(MirrorFlyChatViewController());
  @override
  Widget build(BuildContext context) {
    logs('Current Screen--> $runtimeType');

    return Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        title: 'Mr.User Name',
        trailingWidget: const AppImageAsset(
          image: ImageConstants.phoneCall,
          color: AppColors.black,
          height: 20,
        ),
      ),
      body: Obx((){
        final List<ChatMessageModel> data=_mirrorFlyChatViewController.chatMessageModel.reversed.toList();
       return  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount:data.length,
              reverse: true,
                //chatViewModel.message.length,
                itemBuilder: (BuildContext context, int index) {
                  return (true)
                      ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.px),
                              decoration: BoxDecoration(
                                color: AppColors.isDisableColor,
                                borderRadius: BorderRadius.circular(10.px),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 14),
                                    child: AppImageAsset(
                                      image: ImageConstants.teacherAvtar,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(data[index].messageTextContent??''),
                                  ),

                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.end,
                                  //   children: <Widget>[
                                  //     SwipeTo(
                                  //       onLeftSwipe: (details) {
                                  //         logs('swipe to reply left------>');
                                  //         setState(() {});
                                  //       },
                                  //       child: Container(
                                  //           padding:
                                  //           EdgeInsets.symmetric(vertical: 8.px, horizontal: 15.px),
                                  //           decoration: BoxDecoration(
                                  //             color: AppColors.appBlue,
                                  //             borderRadius: BorderRadius.only(
                                  //               topLeft: Radius.circular(20.px),
                                  //               topRight: Radius.circular(20.px),
                                  //               bottomLeft: Radius.circular(20.px),
                                  //             ),
                                  //           ),
                                  //           child: const SenderAudioCardView()
                                  //         // const DocumentCardView()
                                  //         // SenderTextCardView(
                                  //         //     text: chatViewModel.message[index].message),
                                  //         //ImageCardView()
                                  //         ///we will manage views later as per API//
                                  //       ),
                                  //     ),
                                  //     const SizedBox(height: 3),
                                  //     const Row(
                                  //       children: <Widget>[
                                  //         AppText('12:24 AM', fontSize: 10, color: AppColors.appGrey),
                                  //         SizedBox(
                                  //           width: 5,
                                  //         ),
                                  //         AppImageAsset(image: ImageConstants.doneMessage),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(width: 2),
                                  // const Padding(
                                  //   padding: EdgeInsets.only(bottom: 14),
                                  //   child: AppImageAsset(
                                  //     image: ImageConstants.avtar,
                                  //     height: 20,
                                  //     width: 20,
                                  //   ),
                                  // )
                                ],
                              ),
                            ),

                          ],
                        ),

                        // const SizedBox(height: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: <Widget>[
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.end,
                        //       children: <Widget>[
                        //         SwipeTo(
                        //           onRightSwipe: (details) {
                        //             _chatController.isSwipeRight.value = !_chatController.isSwipeRight.value;
                        //             logs('swipe to reply------>');
                        //             setState(() {});
                        //           },
                        //           child: Row(
                        //             children: [
                        //               if (_chatController.isSwipeRight.value)
                        //                 Row(
                        //                   children: [
                        //                     InkWell(
                        //                       onTap: () {},
                        //                       child: Container(
                        //                           padding: const EdgeInsets.all(5),
                        //                           decoration: BoxDecoration(
                        //                             color: AppColors.red.withOpacity(0.2),
                        //                             shape: BoxShape.circle,
                        //                           ),
                        //                           child: const AppImageAsset(
                        //                               image: ImageConstants.messageDelete)),
                        //                     ),
                        //                     InkWell(
                        //                       onTap: () {},
                        //                       child: Container(
                        //                           padding: const EdgeInsets.all(5),
                        //                           decoration: const BoxDecoration(
                        //                             color: AppColors.isDisableColor,
                        //                             shape: BoxShape.circle,
                        //                           ),
                        //                           child: const AppImageAsset(
                        //                               image: ImageConstants.messageEdit)),
                        //                     ),
                        //                     InkWell(
                        //                       onTap: () {},
                        //                       child: Container(
                        //                           padding: const EdgeInsets.all(5),
                        //                           decoration: const BoxDecoration(
                        //                             color: AppColors.isDisableColor,
                        //                             shape: BoxShape.circle,
                        //                           ),
                        //                           child: const AppImageAsset(
                        //                               image: ImageConstants.replyMessage)),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               Container(
                        //                   padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 15.px),
                        //                   decoration: BoxDecoration(
                        //                     color: AppColors.appBlue,
                        //                     borderRadius: BorderRadius.only(
                        //                       topLeft: Radius.circular(20.px),
                        //                       topRight: Radius.circular(20.px),
                        //                       bottomLeft: Radius.circular(20.px),
                        //                     ),
                        //                   ),
                        //                   child:
                        //                   //SenderTextCardView(text: chatViewModel.message[index].message),
                        //                   // const DocumentCardView()
                        //                   const SenderAudioCardView()
                        //                 //ImageCardView()
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         const SizedBox(height: 3),
                        //         const Row(
                        //           children: <Widget>[
                        //             AppText('12:24 AM', fontSize: 10, color: AppColors.appGrey),
                        //             SizedBox(
                        //               width: 5,
                        //             ),
                        //             AppImageAsset(image: ImageConstants.doneMessage),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //     const SizedBox(width: 2),
                        //     const Padding(
                        //       padding: EdgeInsets.only(bottom: 14),
                        //       child: AppImageAsset(
                        //         image: ImageConstants.avtar,
                        //         height: 20,
                        //         width: 20,
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  )
                      : SwipeTo(
                    onRightSwipe: (DragUpdateDetails details) {
                      logs('swipe to reply------>');
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.px),
                                decoration: BoxDecoration(
                                  color: AppColors.isDisableColor,
                                  borderRadius: BorderRadius.circular(10.px),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 14),
                                      child: AppImageAsset(
                                        image: ImageConstants.teacherAvtar,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SwipeTo(
                                          onRightSwipe: (DragUpdateDetails details) {
                                            logs('swipe to reply------>');
                                            setState(() {});
                                          },
                                          child: Container(
                                              padding:
                                              EdgeInsets.symmetric(vertical: 8.px, horizontal: 15.px),
                                              decoration: BoxDecoration(
                                                color: AppColors.tabColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20.px),
                                                  topRight: Radius.circular(20.px),
                                                  bottomRight: Radius.circular(20.px),
                                                ),
                                              ),
                                              child: const DocumentCardView()
                                            //     ReceiveTextCardView(
                                            //   text: chatViewModel.message[index].message,
                                            // ),
                                            // ImageCardView()
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Row(
                                          children: <Widget>[
                                            AppText('12:24 AM', fontSize: 10.px, color: AppColors.appGrey),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 16.px),
                                      height: 20.px,
                                      child: const AppImageAsset(image: ImageConstants.avtar),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.px),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 16.px),
                                height: 20.px,
                                child: const AppImageAsset(image: ImageConstants.teacherAvtar),
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SwipeTo(
                                      onRightSwipe: (DragUpdateDetails details) {
                                        logs('swipe to reply------>');
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 15.px),
                                        decoration: BoxDecoration(
                                          color: AppColors.tabColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.px),
                                            topRight: Radius.circular(20.px),
                                            bottomRight: Radius.circular(20.px),
                                          ),
                                        ),
                                        child:
                                        //DocumentCardView()
                                        ReceiveTextCardView(text: _chatController.message[index].message),
                                        // ImageCardView()
                                      )),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: <Widget>[
                                      AppText('12:24 AM', fontSize: 10.px, color: AppColors.appGrey),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 4),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // GroupedListView(
            //   itemBuilder: (context, element) {
            //     int index = chatViewModel.message.indexOf(element);
            //     return Container(
            //       height: 20,
            //       width: 20,
            //       color: Colors.red,
            //     );
            //   },
            //   reverse: true,
            //   physics: const BouncingScrollPhysics(),
            //   clipBehavior: Clip.antiAliasWithSaveLayer,
            //   order: GroupedListOrder.DESC,
            //   useStickyGroupSeparators: true,
            //   floatingHeader: true,
            //   elements: chatViewModel.message,
            //   groupBy: (element) {
            //     String formatDate(DateTime dateTime) {
            //       return DateFormat('MMM d, y').format(dateTime);
            //     }
            //
            //         int timestamp = element['messageTimestamp'];
            //     DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
            //     return formatDate(date);
            //   },
            //   groupHeaderBuilder: (value) {
            //     //  var timestamp = value['messageTimestamp'];
            //     // String formatDate = DateFormation()
            //     //     .headerTimestamp(timestamp);
            //     return Container(
            //       margin: EdgeInsets.all(15.px),
            //       alignment: Alignment.center,
            //       height: 25.px,
            //       child: Container(
            //         padding: EdgeInsets.all(5.px),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(5.px),
            //           color: AppColors.appGrey.withOpacity(0.3),
            //         ),
            //         alignment: Alignment.center,
            //         height: 25.px,
            //         width: 100.px,
            //         child: Text(
            //           '',
            //           style: const TextStyle(
            //             color: AppColors.black,
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  if (_chatController.isOnTapMic.value)
                    InkWell(
                      onTap: () {
                        _chatController.isOnTapMic.value = false;
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration:
                          BoxDecoration(color: AppColors.red.withOpacity(0.2), shape: BoxShape.circle),
                          child: const AppImageAsset(image: ImageConstants.messageDelete)),
                    ),
                  const SizedBox(width: 5),
                  if (!_chatController.isOnTapMic.value)
                    Flexible(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                          maxWidth: MediaQuery.of(context).size.width,
                          minHeight: 25.0,
                          maxHeight: 135.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.px),
                            border: Border.all(color: AppColors.lightPurple),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: _chatController.chatController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                              const EdgeInsets.only(top: 2.0, left: 13.0, right: 13.0, bottom: 2.0),
                              hintText: 'Write your message',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.px),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _mirrorFlyChatViewController.message.value=value;
                              });

                            },
                          ),
                        ),
                      ),
                    )
                  else
                    buildAudioSendView(),
                  const SizedBox(width: 5),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(color: AppColors.appBlue.withOpacity(0.2), shape: BoxShape.circle),
                    child: (_chatController.chatController.text.isNotEmpty)
                        ? InkWell(
                      onTap: () {
                        // _chatController.message.add(Chat(_chatController.chatController.text, true));
                        _mirrorFlyChatViewController.sendMessage();
                        logs(
                          'message length-->${_chatController.message.length}',
                        );
                        _chatController.chatController.clear();
                        setState(() {});
                      },
                      child: const AppImageAsset(image: ImageConstants.sendMessage),
                    )
                        : InkWell(
                      onTap: () {
                        _chatController.isOnTapMic.value = !_chatController.isOnTapMic.value;
                        setState(() {});
                        logs('isOnatap-->${_chatController.isOnTapMic}');
                      },
                      child: AppImageAsset(
                        image: (_chatController.isOnTapMic.value)
                            ? ImageConstants.sendMessage
                            : ImageConstants.microPhone,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  if (!_chatController.isOnTapMic.value)
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.only(left: 15.px, right: 15.px),
                              height: MediaQuery.of(context).size.height * 0.40.px,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.px),
                                  topRight: Radius.circular(30.px),
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 14.px),
                                      alignment: Alignment.center,
                                      height: 25.px,
                                      width: 25.px,
                                      decoration: const BoxDecoration(
                                          color: AppColors.appLightGrey, shape: BoxShape.circle),
                                      child: AppImageAsset(
                                        image: ImageConstants.closeIcon,
                                        height: 20.px,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 28.px,
                                      ),
                                      AppText(
                                        'Add Image',
                                        fontSize: 14.px,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      SizedBox(height: 23.px),
                                      SizedBox(
                                        height: 50,
                                        child: InkWell(
                                          onTap: () {
                                            final Future<XFile?> imagepick =
                                            ImagePicker().pickImage(source: ImageSource.camera);
                                            logs('imagepick-->$imagepick');
                                            if (imagepick != null) {
                                              logs('imagepick123-->${imagepick.toString()}');
                                              setState(() {});
                                            }
                                          },
                                          child: const Row(
                                            children: <Widget>[
                                              AppImageAsset(image: ImageConstants.cameraIcon),
                                              SizedBox(width: 20),
                                              AppText('Take Photo'),
                                              Spacer(),
                                              AppImageAsset(image: ImageConstants.forwardIcon)
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                      SizedBox(
                                        height: 50,
                                        child: InkWell(
                                          onTap: () {
                                            final Future<XFile?> imagepick =
                                            ImagePicker().pickImage(source: ImageSource.gallery);
                                            logs('image gallery-->$imagepick');
                                            if (imagepick != null) {
                                              logs('imagegellery123-->${imagepick.toString()}');
                                              setState(() {});
                                            }
                                          },
                                          child: const Row(
                                            children: <Widget>[
                                              AppImageAsset(image: ImageConstants.imageIcon),
                                              SizedBox(width: 20),
                                              AppText('Add Image'),
                                              Spacer(),
                                              AppImageAsset(image: ImageConstants.forwardIcon),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                      SizedBox(
                                        height: 50,
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(
                                                  top: Radius.circular(25.0),
                                                ),
                                              ),
                                              builder: (BuildContext context) {
                                                return const SizedBox();
                                              },
                                            );
                                          },
                                          child: const Row(
                                            children: <Widget>[
                                              AppImageAsset(image: ImageConstants.documentFileClip),
                                              SizedBox(width: 20),
                                              AppText('Add File'),
                                              Spacer(),
                                              AppImageAsset(image: ImageConstants.forwardIcon)
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration:
                        BoxDecoration(color: AppColors.appBlue.withOpacity(0.2), shape: BoxShape.circle),
                        child: const AppImageAsset(
                          image: ImageConstants.plusIcon,
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        );}
      ),
    );

  }
}

class DocumentCardView extends StatelessWidget {
  const DocumentCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.px),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget>[
              fileCardView(),
              fileCardView(),
            ],
          ),
          Row(
            children: <Widget>[
              fileCardView(),
              fileCardView(),
            ],
          ),
        ],
      ),
    );
  }

  Widget fileCardView() {
    return Container(
      margin: EdgeInsets.all(1.5.px),
      padding: EdgeInsets.all(10.px),
      height: 50.px,
      width: 50.px,
      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(8.px),
      ),
      child: const AppImageAsset(
        image: ImageConstants.document,
      ),
    );
  }
}

class SenderTextCardView extends StatelessWidget {
  SenderTextCardView({this.text, super.key});

  String? text;

  @override
  Widget build(BuildContext context) {
    return AppText(
      maxLines: 100,
      text ?? '',
      color: AppColors.appWhite,
      fontSize: 14.px,
    );
  }
}

class ReceiveTextCardView extends StatelessWidget {
  ReceiveTextCardView({this.text, super.key});

  String? text;

  @override
  Widget build(BuildContext context) {
    return AppText(
      maxLines: 100,
      text ?? '',
      fontSize: 14.px,
    );
  }
}

class ImageCardView extends StatelessWidget {
  const ImageCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.px),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              photoView(),
              photoView(),
            ],
          ),
          Row(
            children: <Widget>[
              photoView(),
              photoView(),
            ],
          ),
        ],
      ),
    );
  }

  Widget photoView() {
    return Container(
      margin: EdgeInsets.all(1.5.px),
      height: 50.px,
      width: 50.px,
      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(8.px),
      ),
      child: const AppImageAsset(
        image: ImageConstants.dummyImage,
      ),
    );
  }
}

class SenderAudioCardView extends StatelessWidget {
  const SenderAudioCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImageAsset(image: ImageConstants.playIcon, height: 25.px),
        const SizedBox(width: 5),
        AppImageAsset(image: ImageConstants.audioWavesPlay, height: 25.px),
        const SizedBox(width: 5),
        AppText('01:04', fontSize: 14.px, color: AppColors.appWhite)
      ],
    );
  }
}

Expanded buildAudioSendView() {
  return Expanded(
    child: Container(
      alignment: Alignment.center,
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.appLightBlack,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          AppText(
            '00:12',
            color: (_chatController.isOnTapPause.value) ? AppColors.red : AppColors.white,
          ),
          if (_chatController.isOnTapPause.value)
            const AppImageAsset(
              height: 20,
              width: 70,
              image: ImageConstants.audioWaves,
              fit: BoxFit.fill,
            )
          else
            const AppText('Paused', color: AppColors.appWhite),
          InkWell(
              onTap: () {
                _chatController.isOnTapPause.value = !_chatController.isOnTapPause.value;
                logs('isOntapPause-->${_chatController.isOnTapPause}');
              },
              child: AppImageAsset(
                  image: (_chatController.isOnTapPause.value) ? ImageConstants.pauseButton : ImageConstants.recordButton))
        ],
      ),
    ),
  );
}


