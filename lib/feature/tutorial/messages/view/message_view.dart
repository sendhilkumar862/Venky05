import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/route.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/cache/key_value_storage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/validators.dart';
import '../../../home/controller/home_controller.dart';
import '../../../home_views/views/tabs/classes_view.dart';
import '../controller/message_controller.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  bool isStudent = false;
  String selectedProfile = '';
  bool isPending = false;

  final MessageController _messageController=Get.put(MessageController());
  final HomeController _homeController = Get.find();
  @override
  void initState() {
    super.initState();
    selectedProfile =  LocaleManager.getValue( StorageKeys.profile)??'';
  }

  @override
  Widget build(BuildContext context) {
    logs('Current Screen--> $runtimeType');

    return Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        title: 'Messages',
        isBack: false,
        trailingText: (selectedProfile == ApplicationConstants.tutor && _homeController.homeData.value?.userStatus != '99')?'':'Done',
        trailingTap: () {},
      ),
      body: selectedProfile == ApplicationConstants.tutor &&  _homeController.homeData.value?.userStatus != '99'
          ? const ClassesView()
          : StatefulBuilder(
        builder: (BuildContext context, setState) {
          return ListView(
            children: <Widget>[
              // InfoCardVIew(
              //   isPending: false,
              //   isShowButton: true,
              //   isSupport: false,
              //   isStatus: false,
              //   title: 'No Messages!',
              //   message: 'Start Conversation With Teacher',
              //   cardColor: AppColors.white,
              //   buttonTitle: 'Search About Teacher',
              //   buttonTap: () {},
              // ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: <Widget>[
                    TextFormsField(
                      controller: _messageController
                          .searchTeacherController,
                      hintText: 'search About Teacher',
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 10.px),
                        child: const AppImageAsset(
                            image: ImageConstants.searchIcon,
                            height: 20),
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// message Screen in sort archived ///
                    if (_messageController.teacherLongPress.value)
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _messageController
                                  .onSelectAll(setState);
                              setState(() {});
                            },
                            child: Row(
                              children: <Widget>[
                                AppImageAsset(
                                  image: (!_messageController
                                      .selectAll.value)
                                      ? ImageConstants.checkbox
                                      : ImageConstants.checkBox,
                                  height: 18.px,
                                ),
                                const SizedBox(width: 8),
                                AppText('Select All',
                                    fontSize: 14.px,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.appBlue),
                              ],
                            ),
                          ),
                          const Spacer(),
                          const AppText('Archive',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.appBlue),
                          const SizedBox(
                            width: 6,
                          ),
                          const AppImageAsset(
                              image: ImageConstants.documentBox),
                          const SizedBox(width: 8),
                          const AppText('Delete',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.red),
                          const SizedBox(width: 6),
                          const AppImageAsset(
                              image: ImageConstants.messageDelete)
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                shape:
                                const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.vertical(
                                    top: Radius.circular(25.0),
                                  ),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return SortBottomSheet();
                                },
                              );
                            },
                            child: const Row(
                              children: <Widget>[
                                AppImageAsset(
                                    image: ImageConstants
                                        .filterSort),
                                SizedBox(width: 7),
                                AppText(
                                  'Sort',
                                  color: AppColors.appBlue,
                                )
                              ],
                            ),
                          ),
                          const Row(
                            children: <Widget>[
                              AppText(
                                'Archived',
                                color: AppColors.appBlue,
                              ),
                              SizedBox(width: 7),
                              AppImageAsset(
                                  image:
                                  ImageConstants.documentBox),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(height: 7),
                    const Divider(
                      color: AppColors.appGrey,
                    ),
                    const SizedBox(height: 7),

                    Obx(
               ()=>_messageController.mirrorFlyMessageController.userList.isNotEmpty? ListView.separated(
                         shrinkWrap: true,
                         scrollDirection: Axis.vertical,
                         physics:
                         const NeverScrollableScrollPhysics(),
                         itemBuilder:
                             (BuildContext context, int index) {
                           return teachersCardView(context,
                               index, setState);
                         },
                         separatorBuilder:
                             (BuildContext context, int index) {
                           return const Divider(
                             height: 30,
                           );
                         },
                         itemCount: _messageController.mirrorFlyMessageController.userList.length):
          const SizedBox.shrink()
                    )


                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget teachersCardView(BuildContext context,
      int index, Function setState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText('Today',
            fontSize: 12.px,
            fontWeight: FontWeight.w700,
            color: AppColors.appGrey),
        SizedBox(height: 10.px),
        Slidable(
          closeOnScroll: true,
          endActionPane:
          ActionPane(motion: const ScrollMotion(), children: <Widget>[
            SlidableAction(
              backgroundColor: AppColors.appLightBlue.withOpacity(0.3),
              foregroundColor: AppColors.appBlue,
              image: const AppImageAsset(image: ImageConstants.documentBox),
              label: 'Archive',
              onPressed: (BuildContext context) {
                showModalBottomSheet(
                  context: context,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 30,
                    // here increase or decrease in width
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  builder: (BuildContext context) {
                    return ConfirmationButton(
                      title: 'Archive Confirmation',
                      titleDescription:
                      'Are you sure you want to archive selected messages?',
                      buttonText: 'Yes, Archive',
                      buttonTextDiscript: 'No, Keep It',
                      buttonTextDisColor: AppColors.appBlue,
                    );
                    //ConfirmationButton(
                    //                       title: 'Unarchive Confirmation',
                    //                       titleDescription: 'Are you sure you want to unarchive all messages?',
                    //                       buttonText: 'Yes, Unarchive',
                    //                       buttonTextDiscript: 'No, Keep Them',
                    //                       buttonTextDisColor: AppColors.appBlue,
                    //                     );
                  },
                );
              },
            ),
            SlidableAction(
              backgroundColor: AppColors.appLightBlue.withOpacity(0.3),
              foregroundColor: AppColors.appBlue,
              image: const AppImageAsset(image: ImageConstants.phoneCall),
              label: 'Call',
              onPressed: (BuildContext context) {},
            ),
            SlidableAction(
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.appWhite,
              image: const AppImageAsset(image: ImageConstants.delete),
              label: 'Delete',
              onPressed: (BuildContext context) {
                showModalBottomSheet(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.px)),
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmationButton(
                      title: 'Delete Confirmation',
                      titleDescription:
                      'Are you sure you want to delete selected messages?',
                      buttonText: 'No, Keep it',
                      buttonTextDiscript: 'Yes, Delete',
                    );
                  },
                );
              },
            ),
          ]),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(Routes.chatView,arguments: _messageController.mirrorFlyMessageController.userList[index].jid??'');
            },
            onLongPress: () {
              _messageController.teacherLongPress.value =
              !_messageController.teacherLongPress.value;
              setState(() {});
              logs('Long Pressed');
            },
            child: Row(
              children: <Widget>[
                if (_messageController.teacherLongPress.value)
                  InkWell(
                      onTap: () {
                        _messageController.onSelected(index);
                        setState(() {});
                      },
                      child: (!_messageController.isSelected[index])
                          ? AppImageAsset(
                        image: ImageConstants.checkbox,
                        height: 22.px,
                      )
                          : AppImageAsset(
                        image: ImageConstants.checkBox,
                        height: 22.px,
                      )),
                if (_messageController.teacherLongPress.value)
                  const SizedBox(width: 14),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child:
                  const AppImageAsset(image: ImageConstants.teacherAvtar),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                          AppText(
                            _messageController.mirrorFlyMessageController.userList[index].name!=''
                            ?'Mr. ${ _messageController.mirrorFlyMessageController.userList[index].name??''}':''
                       ,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(width: 10.px),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.px, vertical: 3.px),
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(20.px),
                          ),
                          child: Row(children: <Widget>[
                            AppImageAsset(
                              image: ImageConstants.proIcon,
                              height: 12.px,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            AppText(
                              'Pro',
                              color: AppColors.appYellow,
                              fontSize: 10.px,
                              fontWeight: FontWeight.w700,
                            )
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.px,
                    ),
                    AppText(
                      'Hii Ahmed',
                      fontSize: 10.px,
                      fontWeight: FontWeight.w400,
                      color: AppColors.appGrey,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: <Widget>[
                    AppText(
                      '12:00 Am',
                      fontSize: 10.px,
                      color: AppColors.appGrey,
                    ),
                    const SizedBox(width: 4),
                    // AppImageAsset(image: ImageConstants.doneCheckSingle),
                    const AppImageAsset(image: ImageConstants.doneMessage),
                    // AppImageAsset(image: ImageConstants.messageSeen),
                    if (_messageController.teacherLongPress.value)
                      Container(
                        height: 8.px,
                        width: 8.px,
                        decoration: const BoxDecoration(
                            color: AppColors.appBlue, shape: BoxShape.circle),
                      )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class SortBottomSheet extends StatefulWidget {
  SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  final MessageController _messageController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.px, right: 15.px),
      height: MediaQuery.of(context).size.height * 0.30.px,
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
                'Sort',
                fontSize: 14.px,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 23.px,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  'Sort By',
                  fontSize: 16.px,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 18.px),
              Row(
                children: <Widget>[
                  const AppText('Date', color: AppColors.appGrey),
                  const SizedBox(width: 10),
                  sortList(
                    title: _messageController.newStatus,
                    selected: _messageController.isSelectNewStatus,
                  )
                  // sortList(title: 'hello')
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  const AppText('Status', color: AppColors.appGrey),
                  const SizedBox(width: 10),
                  sortList(
                      title: _messageController.readStatus,
                      selected: _messageController.isSelectReadStatus),
                  const SizedBox(height: 10),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                color: AppColors.appGrey,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget sortList({List<dynamic>? title, String? icon, List<bool>? selected}) {
    return SizedBox(
      height: 22.px,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                selected[index] = !selected[index];
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 5.px),
                padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 3.px),
                decoration: BoxDecoration(
                  color: (selected![index])
                      ? AppColors.appBlue
                      : AppColors.appWhite,
                  border: Border.all(
                      color: (selected[index])
                          ? AppColors.appBlue
                          : AppColors.appLightGrey),
                  borderRadius: BorderRadius.circular(30.px),
                ),
                child: Row(
                  children: <Widget>[
                    // Another check for spacing
                    SizedBox(width: 4.px),
                    AppText(
                      title![index] ?? '',
                      fontSize: 10.px,
                      fontWeight: FontWeight.w500,
                      color: (selected[index])
                          ? AppColors.appWhite
                          : AppColors.appGrey,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ConfirmationButton extends StatelessWidget {
  String? title;
  String? titleDescription;
  String? buttonText;
  String? buttonTextDiscript;
  Color? buttonTextDisColor;

  ConfirmationButton({
    this.title,
    this.titleDescription,
    this.buttonText,
    this.buttonTextDiscript,
    this.buttonTextDisColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      height: MediaQuery.of(context).size.height * 0.45.px,
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
              SizedBox(height: 28.px),
              const AppImageAsset(image: ImageConstants.warning),
              SizedBox(height: 20.px),
              Align(
                alignment: Alignment.center,
                child: AppText(
                  title ?? '',
                  fontSize: 16.px,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 18.px),
              AppText(
                titleDescription ?? '',
                color: AppColors.appGrey,
                fontSize: 12,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              AppButton(
                title: buttonText ?? '',
                height: 45.px,
                borderRadius: BorderRadius.circular(12.px),
                borderColor: AppColors.appBlue,
                onPressed: () {},
                isDisable: false,
              ),
              const SizedBox(height: 20),
              AppText(buttonTextDiscript ?? '',
                  color: buttonTextDisColor ?? AppColors.appRed),
            ],
          ),
        ],
      ),
    );
  }
}

