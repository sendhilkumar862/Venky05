import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/validators.dart';
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
                  isBack: true,
                  showSuffix: true,
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: chatViewModel.message.length,
                        itemBuilder: (BuildContext context, int index) {
                          logs(
                              'chatViewModel.message[index].mess-->${chatViewModel.message[index].mess}');
                          return (chatViewModel.message[index].isCheck!)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          SwipeTo(
                                            onLeftSwipe: (details) {
                                              logs('swipe to reply------>');
                                              setState(() {});
                                            },
                                            child: ChatBubble(
                                              clipper: ChatBubbleClipper5(
                                                type: BubbleType.sendBubble,
                                              ),
                                              alignment: Alignment.topRight,
                                              backGroundColor:
                                                  AppColors.appBlue,
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.7,
                                                ),
                                                child: AppText(
                                                  '${chatViewModel.message[index].mess}',
                                                  color: AppColors.appWhite,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          const Row(
                                            children: <Widget>[
                                              AppText('12:24 AM',
                                                  fontSize: 10,
                                                  color: AppColors.appGrey),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              AppImageAsset(
                                                  image: ImageConstants
                                                      .doneMessage),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 10, bottom: 16),
                                        height: 20,
                                        child: const AppImageAsset(
                                            image: ImageConstants.avtar),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, bottom: 16),
                                        height: 20,
                                        child: const AppImageAsset(
                                            image: ImageConstants.teacherAvtar),
                                      ),
                                      const SizedBox(width: 4),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SwipeTo(
                                            onLeftSwipe:
                                                (DragUpdateDetails details) {},
                                            child: ChatBubble(
                                              clipper: ChatBubbleClipper5(
                                                  type: BubbleType
                                                      .receiverBubble),
                                              alignment: Alignment.topLeft,
                                              backGroundColor: Colors.white,
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.7,
                                                ),
                                                child: AppText(
                                                  '${chatViewModel.message[index].mess}',
                                                  fontSize: 14.px,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5, width: 3),
                                          const AppText('12:24 AM',
                                              fontSize: 10,
                                              color: AppColors.appGrey),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                        },
                      ),
                      // ChatMessageUi(chatViewModel.message),
                    ),
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
                                    decoration: BoxDecoration(
                                        color: AppColors.red.withOpacity(0.2),
                                        shape: BoxShape.circle),
                                    child: const AppImageAsset(
                                        image: ImageConstants.messageDelete)),
                              ),
                            const SizedBox(width: 5),
                            if (!chatViewModel.isOnTapMic)
                              Expanded(
                                child: TextFormsField(
                                  controller: chatViewModel.chatController,
                                  hintText: 'Write your message',
                                  onChanged: (String value) {
                                    setState(() {});
                                  },
                                ),
                              )
                            else
                              buildAudioSendView(),
                            const SizedBox(width: 5),
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: AppColors.appBlue.withOpacity(0.2),
                                  shape: BoxShape.circle),
                              child: (chatViewModel
                                      .chatController.text.isNotEmpty)
                                  ? InkWell(
                                      onTap: () {
                                        chatViewModel.message.add(Demo(
                                            chatViewModel.chatController.text,
                                            true));
                                         logs(
                                          'message length-->${chatViewModel.message.length}',
                                        );
                                        chatViewModel.chatController.clear();
                                        setState(() {});
                                      },
                                      child: const AppImageAsset(
                                          image: ImageConstants.sendMessage),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        chatViewModel.isOnTapMic =
                                            !chatViewModel.isOnTapMic;
                                        setState(() {});
                                        logs(
                                            'isOnatap-->${chatViewModel.isOnTapMic}');
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
                                        padding: EdgeInsets.only(
                                            left: 15.px, right: 15.px),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.40.px,
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
                                                margin:
                                                    EdgeInsets.only(top: 14.px),
                                                alignment: Alignment.center,
                                                height: 25.px,
                                                width: 25.px,
                                                decoration: const BoxDecoration(
                                                    color:
                                                        AppColors.appLightGrey,
                                                    shape: BoxShape.circle),
                                                child: AppImageAsset(
                                                  image:
                                                      ImageConstants.closeIcon,
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
                                                       final imagepick = ImagePicker().pickImage(source: ImageSource.camera);
                                                      logs('imagepick-->$imagepick');
                                                       if (imagepick != null) {
                                                         logs('imagepick123-->${imagepick.toString()}');
                                                         setState(() {});
                                                       }
                                                    },
                                                    child: const Row(
                                                      children: <Widget>[
                                                        AppImageAsset(
                                                            image: ImageConstants
                                                                .cameraIcon),
                                                        SizedBox(width: 20),
                                                        AppText('Take Photo'),
                                                        Spacer(),
                                                        AppImageAsset(
                                                            image: ImageConstants
                                                                .forwardIcon)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(),
                                                const SizedBox(
                                                  height: 50,
                                                  child: Row(
                                                    children: <Widget>[
                                                      AppImageAsset(
                                                          image: ImageConstants
                                                              .imageIcon),
                                                      SizedBox(width: 20),
                                                      AppText('Add Image'),
                                                      Spacer(),
                                                      AppImageAsset(
                                                          image: ImageConstants
                                                              .forwardIcon)
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
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    25.0),
                                                          ),
                                                        ),
                                                        builder: (BuildContext
                                                            context) {
                                                          return const SizedBox();
                                                        },
                                                      );
                                                    },
                                                    child: const Row(
                                                      children: <Widget>[
                                                        AppImageAsset(
                                                            image: ImageConstants
                                                                .documentFileClip),
                                                        SizedBox(width: 20),
                                                        AppText('Add File'),
                                                        Spacer(),
                                                        AppImageAsset(
                                                            image: ImageConstants
                                                                .forwardIcon)
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
                                  decoration: BoxDecoration(
                                      color: AppColors.appBlue.withOpacity(0.2),
                                      shape: BoxShape.circle),
                                  child: const AppImageAsset(
                                    image: ImageConstants.plusIcon,
                                  ),
                                ),
                              ),
                          ],
                        ))
                  ],
                ));
          });
        });
  }
}

// class ChatMessageUi extends StatelessWidget {
//   List<Demo> message;
//
//   ChatMessageUi(this.message, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     logs('messagelength-->${message.length}');
//     return ListView.builder(
//       itemCount: message.length,
//       itemBuilder: (BuildContext context, int index) {
//         return (message[index].isCheck == !false)
//             ? Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: <Widget>[
//                       SwipeTo(
//                         onLeftSwipe: (details) {
//                           logs('swipe to reply------>');
//                         },
//                         child: ChatBubble(
//                           clipper: ChatBubbleClipper5(
//                             type: BubbleType.sendBubble,
//                           ),
//                           alignment: Alignment.topRight,
//                           backGroundColor: AppColors.appBlue,
//                           child: Container(
//                             constraints: BoxConstraints(
//                               maxWidth: MediaQuery.of(context).size.width * 0.7,
//                             ),
//                             child: AppText(
//                               '${message[index].mess}',
//                               color: AppColors.appWhite,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 3),
//                       Row(
//                         children: <Widget>[
//                           const AppText('12:24 AM',
//                               fontSize: 10, color: AppColors.appGrey),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Container(
//                             child: const AppImageAsset(
//                                 image: ImageConstants.doneMessage),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 4),
//                   const SizedBox(
//                     height: 20,
//                     child: AppImageAsset(image: ImageConstants.avtar),
//                   ),
//                 ],
//               )
//             : Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   const SizedBox(
//                     height: 20,
//                     child: AppImageAsset(image: ImageConstants.teacherAvtar),
//                   ),
//                   const SizedBox(width: 4),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       SwipeTo(
//                         onLeftSwipe: (DragUpdateDetails details) {},
//                         child: ChatBubble(
//                           clipper: ChatBubbleClipper5(
//                               type: BubbleType.receiverBubble),
//                           alignment: Alignment.topLeft,
//                           backGroundColor: Colors.white,
//                           child: Container(
//                             constraints: BoxConstraints(
//                               maxWidth: MediaQuery.of(context).size.width * 0.7,
//                             ),
//                             child: AppText(
//                               '${message[index].mess}',
//                               fontSize: 14.px,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 5, width: 3),
//                       const AppText('12:24 AM',
//                           fontSize: 10, color: AppColors.appGrey),
//                     ],
//                   ),
//                 ],
//               );
//       },
//     );
//   }
// }

buildAudioSendView() {
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
            color:
                (chatViewModel.isOnTapPause) ? AppColors.red : AppColors.white,
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
                chatViewModel.isOnTapPause =!chatViewModel.isOnTapPause;
                logs('isOntapPause-->${chatViewModel.isOnTapPause}');

              },
              child: AppImageAsset(
                  image: (chatViewModel.isOnTapPause)
                      ? ImageConstants.pauseButton
                      : ImageConstants.recordButton))
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
