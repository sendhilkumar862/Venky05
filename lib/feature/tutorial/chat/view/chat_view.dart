import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/validators.dart';
import 'package:grouped_list/grouped_list.dart';
import '../view_model/chat_view_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    logs('Current Screen--> $runtimeType');

    return BaseView<ChatViewModel>(
        viewModel: ChatViewModel(),
        onModelReady: (ChatViewModel chatViewModel) {
          chatViewModel.setContext(context);
          chatViewModel.init();
        },
        onPageBuilder: (BuildContext context, ChatViewModel chatViewModel) {
          return Observer(builder: (BuildContext context) {
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
              body: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: 1,
                      //chatViewModel.message.length,
                      itemBuilder: (BuildContext context, int index) {
                        logs('chatViewModel.message[index].mess-->${chatViewModel.message[index].message}');
                        return (chatViewModel.message[index].isCheck!)
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                child: Row(
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
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              SwipeTo(
                                                onLeftSwipe: (DragUpdateDetails details) {
                                                  logs('swipe to reply------>');
                                                  setState(() {});
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 15.px),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.appBlue,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(20.px),
                                                        topRight: Radius.circular(20.px),
                                                        bottomLeft: Radius.circular(20.px),
                                                      ),
                                                    ),
                                                    child: SenderAudioCardView()
                                                    //DocumentCardView()
                                                    // SenderTextCardView(text: chatViewModel.message[index].message),
                                                    // ImageCardView()
                                                    ///we will manage views later as per API//
                                                    ),
                                              ),
                                              const SizedBox(height: 3),
                                              const Row(
                                                children: <Widget>[
                                                  AppText('12:24 AM', fontSize: 10, color: AppColors.appGrey),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  AppImageAsset(image: ImageConstants.doneMessage),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 4),
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 16),
                                            height: 20,
                                            child: const AppImageAsset(image: ImageConstants.avtar),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                                        child: // DocumentCardView()
                                                            ReceiveTextCardView(
                                                                text: chatViewModel.message[index].message),
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
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 15.px),
                                        decoration: BoxDecoration(
                                          color: AppColors.tabColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.px),
                                            topRight: Radius.circular(20.px),
                                            bottomRight: Radius.circular(20.px),
                                          ),
                                        ),
                                        child: //DocumentCardView()
                                            ReceiveTextCardView(text: chatViewModel.message[index].message),
                                        //ImageCardView()
                                      )
                                    ],
                                  ),
                                ),
                              );
                      },
                    ),
                    // ChatMessageUi(chatViewModel.message),
                  ),
                  // GroupedListView(
                  //   itemBuilder: (context, element) {
                  //     // int index = message.indexOf(element);
                  //     return Container();
                  //   },
                  //   reverse: true,
                  //   physics: const BouncingScrollPhysics(),
                  //   clipBehavior: Clip.antiAliasWithSaveLayer,
                  //   order: GroupedListOrder.DESC,
                  //   useStickyGroupSeparators: true,
                  //   floatingHeader: true,
                  //   elements: chatViewModel.message,
                  //   groupBy: (element) {
                  //     // String formatDate(DateTime dateTime) {
                  //     //   return DateFormat('MMM d, y').format(dateTime);
                  //     // }
                  //
                  //     //    int timestamp = element['messageTimestamp'];
                  //     // DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
                  //     //return formatDate(date);
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
                        if (chatViewModel.isOnTapMic)
                          InkWell(
                            onTap: () {
                              chatViewModel.isOnTapMic = false;
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
                        if (!chatViewModel.isOnTapMic)
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
                                  controller: chatViewModel.chatController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(top: 2.0, left: 13.0, right: 13.0, bottom: 2.0),
                                    hintText: 'Write your message',
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.px),
                                  ),
                                  onChanged: (String value) {
                                    setState(() {});
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
                          child: (chatViewModel.chatController.text.isNotEmpty)
                              ? InkWell(
                                  onTap: () {
                                    chatViewModel.message.add(Chat(chatViewModel.chatController.text, true));
                                    logs(
                                      'message length-->${chatViewModel.message.length}',
                                    );
                                    chatViewModel.chatController.clear();
                                    setState(() {});
                                  },
                                  child: const AppImageAsset(image: ImageConstants.sendMessage),
                                )
                              : InkWell(
                                  onTap: () {
                                    chatViewModel.isOnTapMic = !chatViewModel.isOnTapMic;
                                    setState(() {});
                                    logs('isOnatap-->${chatViewModel.isOnTapMic}');
                                  },
                                  child: AppImageAsset(
                                    image: (chatViewModel.isOnTapMic)
                                        ? ImageConstants.sendMessage
                                        : ImageConstants.microPhone,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 5),
                        if (!chatViewModel.isOnTapMic)
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
                                            const SizedBox(
                                              height: 50,
                                              child: Row(
                                                children: <Widget>[
                                                  AppImageAsset(image: ImageConstants.imageIcon),
                                                  SizedBox(width: 20),
                                                  AppText('Add Image'),
                                                  Spacer(),
                                                  AppImageAsset(image: ImageConstants.forwardIcon)
                                                ],
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
              ),
            );
          });
        });
  }
}

class DocumentCardView extends StatelessWidget {
  const DocumentCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.px),
      child: Column(
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
        AppImageAsset(
          image: ImageConstants.playIcon,
          height: 25.px,
        ),
        SizedBox(width: 5.px),
        AppText(
          '01:04',
          fontSize: 14.px,
          color: AppColors.appWhite,
        )
      ],
    );
  }
}

Expanded buildAudioSendView() {
  ChatViewModel chatViewModel = ChatViewModel();
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
            color: (chatViewModel.isOnTapPause) ? AppColors.red : AppColors.white,
          ),
          if (chatViewModel.isOnTapPause)
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
                chatViewModel.isOnTapPause = !chatViewModel.isOnTapPause;
                logs('isOntapPause-->${chatViewModel.isOnTapPause}');
              },
              child: AppImageAsset(
                  image: (chatViewModel.isOnTapPause) ? ImageConstants.pauseButton : ImageConstants.recordButton))
        ],
      ),
    ),
  );
}

// buildAddFileBottomSheet() {
//   return Container(
//     padding: EdgeInsets.only(left: 15.px, right: 15.px),
//     height: MediaQuery.of(context).size.height * 40.px,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(30.px),
//         topRight: Radius.circular(30.px),
//       ),
//     ),
//     child: Stack(
//       alignment: Alignment.topRight,
//       children: <Widget>[
//         InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//             margin: EdgeInsets.only(top: 14.px),
//             alignment: Alignment.center,
//             height: 25.px,
//             width: 25.px,
//             decoration: const BoxDecoration(
//                 color: AppColors.appLightGrey, shape: BoxShape.circle),
//             child: AppImageAsset(
//               image: ImageConstants.closeIcon,
//               height: 20.px,
//             ),
//           ),
//         ),
//         Column(
//           children: <Widget>[
//             SizedBox(
//               height: 28.px,
//             ),
//             AppText(
//               'Add Image',
//               fontSize: 14.px,
//               fontWeight: FontWeight.w700,
//             ),
//             SizedBox(height: 23.px),
//             const Divider(),
//           ],
//         ),
//       ],
//     ),
//   );
// }
