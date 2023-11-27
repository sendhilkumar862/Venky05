import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/validators.dart';
import '../view_model/chat_view_model.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

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
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ListView(shrinkWrap: true, children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ChatBubble(
                                  clipper: ChatBubbleClipper5(
                                      type: BubbleType.sendBubble),
                                  alignment: Alignment.topRight,
                                  backGroundColor: AppColors.appBlue,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                    ),
                                    child: const AppText(
                                      'Hii, Ahmed How Are You',
                                      color: AppColors.appWhite,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const AppText('12:24 AM',
                                        fontSize: 10, color: AppColors.appGrey),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child: const AppImageAsset(
                                          image: ImageConstants.doneMessage),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(width: 4),
                            const SizedBox(
                              height: 20,
                              child: AppImageAsset(
                                  image: ImageConstants.avtar),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              height: 20,
                              child: AppImageAsset(
                                  image: ImageConstants.teacherAvtar),
                            ),
                            const SizedBox(width: 4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ChatBubble(
                                  clipper: ChatBubbleClipper5(
                                      type: BubbleType.receiverBubble),
                                  alignment: Alignment.topLeft,
                                  backGroundColor: Colors.white,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                    ),
                                    child: AppText(
                                      'Hii,Ahmed,How Are You',
                                      fontSize: 14.px,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5, width: 3),
                                const AppText('12:24 AM',
                                    fontSize: 10, color: AppColors.appGrey),
                              ],
                            ),
                          ],
                        ),
                      ]),
                      const BuildTextFormField()
                    ],
                  ),
                ));
          });
        });
  }
}

class BuildTextFormField extends StatefulWidget {
  const BuildTextFormField({super.key});

  @override
  State<BuildTextFormField> createState() => _BuildTextFormFieldState();
}

class _BuildTextFormFieldState extends State<BuildTextFormField> {
  ChatViewModel chatViewModel = ChatViewModel();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (chatViewModel.isOnTapMic)
          InkWell(
            onTap: () {
              chatViewModel.isOnTapMic = false;
              setState(() {});
            },
            child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.red.withOpacity(0.2),
                    shape: BoxShape.circle),
                child:
                    const AppImageAsset(image: ImageConstants.messageDelete)),
          ),
        const SizedBox(width: 5),
        if (!chatViewModel.isOnTapMic)
          Expanded(
            child: TextFormsField(
              controller: chatViewModel.chatController,
              hintText: 'Write your message',
            ),
          )
        else
          builsAudioSendView(),
        const SizedBox(width: 5),
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: AppColors.appBlue.withOpacity(0.2),
              shape: BoxShape.circle),
          child: (chatViewModel.chatController.text.isNotEmpty)
              ? const AppImageAsset(
                  image: ImageConstants.sendMessage,
                )
              : InkWell(
                  onTap: () {
                    chatViewModel.isOnTapMic = !chatViewModel.isOnTapMic;
                    logs('isOnatap-->${chatViewModel.isOnTapMic}');
                    setState(() {});
                  },
                  child: AppImageAsset(
                    image: (!chatViewModel.isOnTapMic)
                        ? ImageConstants.microPhone
                        : ImageConstants.sendMessage,
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
                builder: (context) {
                  return buildAddImageBottomSheet();
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
    );
  }

  builsAudioSendView() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.appLightBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const AppText(
              '00:12',
              color: Colors.red,
            ),
            const AppText(
              '00:12',
              color: Colors.red,
            ),
            // AppImageAsset(image: ImageConstants.audioWaves,),
            InkWell(
                onTap: () {
                  chatViewModel.isOnTapPause = !chatViewModel.isOnTapPause;
                  setState(() {});
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

  buildAddImageBottomSheet(){
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
                  color: AppColors.appLightGrey,
                  shape: BoxShape.circle),
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
              const SizedBox(
                height: 50,
                child: Row(
                  children: [
                    AppImageAsset(image: ImageConstants.cameraIcon),
                    SizedBox(width: 20,),
                    AppText('Take Photo'),
                    Spacer(),
                    AppImageAsset(image: ImageConstants.forwardIcon)
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 50,
                child: Row(
                  children: [
                    AppImageAsset(image: ImageConstants.imageIcon),
                    SizedBox(width: 20,),
                    AppText('Add Image'),
                    Spacer(),
                    AppImageAsset(image: ImageConstants.forwardIcon)
                  ],
                ),
              ),
              const Divider(),
               SizedBox(
                height: 50,
                child: InkWell(onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    builder: (context) {
                      return buildAddFileBottomSheet();
                    },
                  );
                },
                  child: Row(
                    children: [
                      AppImageAsset(
                          image: ImageConstants.documentFileClip),
                      SizedBox(width: 20,),
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
  }
  buildAddFileBottomSheet(){
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
                  color: AppColors.appLightGrey,
                  shape: BoxShape.circle),
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
              Divider(),
            ],
          ),
        ],
      ),
    );

  }
}
