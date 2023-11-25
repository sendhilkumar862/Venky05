import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../custom/choice/choice.dart';
import '../../../../custom/divider/divider.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/switch/app_switch.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/validators.dart';
import '../viewmodel/message_view_model.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    logs('Current Screen--> $runtimeType');

    return BaseView<MessageViewModel>(
        viewModel: MessageViewModel(),
        onModelReady: (MessageViewModel messageViewModel) {
          messageViewModel.setContext(context);
          messageViewModel.init();
        },
        onPageBuilder:
            (BuildContext context, MessageViewModel messageViewModel) {
          return Observer(builder: (BuildContext context) {
            return Scaffold(
              appBar: HessaAppBar(
                isTitleOnly: true,
                title: 'Messages',
                isBack: false,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    context: context,
                    builder: (context) {
                      return ConfirmationButton();
                    },
                  );
                },
              ),
              body: Observer(
                builder: (context) {
                  return ListView(
                    children: <Widget>[
                      SizedBox(height: 60.px),
                      InfoCardVIew(
                        isPending: false,
                        isShowButton: true,
                        isSupport: false,
                        isStatus: false,
                        title: 'No Messages!',
                        message: 'Start Conversation With Teacher',
                        cardColor: AppColors.white,
                        buttonTitle: 'Search About Teacher',
                        buttonTap: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            TextFormsField(
                              controller:
                                  messageViewModel.searchTeacherController,
                              hintText: 'search About Teacher',
                              prefix: Padding(
                                padding: EdgeInsets.only(left: 10.px),
                                child: const AppImageAsset(
                                    image: ImageConstants.searchIcon,
                                    height: 20),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return SortBottomSheet();
                                      },
                                    );
                                  },
                                  child: const Row(
                                    children: [
                                      AppImageAsset(
                                          image: ImageConstants.filterSort),
                                      SizedBox(width: 7),
                                      AppText(
                                        'Sort',
                                        color: AppColors.appBlue,
                                      )
                                    ],
                                  ),
                                ),
                                const Row(
                                  children: [
                                    AppText(
                                      'Archived',
                                      color: AppColors.appBlue,
                                    ),
                                    SizedBox(width: 7),
                                    AppImageAsset(
                                        image: ImageConstants.documentBox),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),
                            const Divider(
                              color: AppColors.appGrey,
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return TeacherList();
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: 20)
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          });
        });
  }
}

class TeacherList extends StatelessWidget {
  TeacherList({super.key});

  MessageViewModel messageViewModel = MessageViewModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Today',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.appGrey),
        const SizedBox(height: 10),
        Slidable(
          closeOnScroll: true,
          endActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              backgroundColor: AppColors.appLightBlue.withOpacity(0.3),
              foregroundColor: AppColors.appBlue,
              icon: Icons.archive,
              label: 'Archive',
              onPressed: (BuildContext context) {},
            ),
            SlidableAction(
              backgroundColor: AppColors.appLightBlue.withOpacity(0.3),
              foregroundColor: AppColors.appBlue,
              icon: Icons.call,
              label: 'Call',
              onPressed: (BuildContext context) {},
            ),
            SlidableAction(
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.appWhite,
              icon: Icons.delete,
              label: 'Delete',
              onPressed: (BuildContext context) {},
            ),
          ]),
          child: Row(
            children: [
              // RadioMenuButton(
              //     value: 0,
              //     groupValue: 'h',
              //     onChanged: (value) {},
              //     child: SizedBox()),
              Container(
                height: 50,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const AppImageAsset(image: ImageConstants.teacherAvtar),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const AppText('Mr.User Name',
                          fontSize: 14, fontWeight: FontWeight.w500),
                      const SizedBox(width: 5),
                      Container(
                        padding: EdgeInsets.all(4.px),
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(20.px)),
                        child: Row(children: [
                          AppImageAsset(
                              image: ImageConstants.proIcon, height: 12.px),
                          const SizedBox(
                            width: 4,
                          ),
                          AppText('Pro',
                              color: AppColors.appYellow, fontSize: 10.px)
                        ]),
                      ),
                    ],
                  ),
                  const AppText('Hii Ahmed',
                      fontSize: 10, fontWeight: FontWeight.w400),
                ],
              ),
              const Spacer(),
              const Row(
                children: [
                  AppText('12:00 Am', fontSize: 10),
                  SizedBox(width: 4),
                  AppImageAsset(image: ImageConstants.doneMessage)
                ],
              )
            ],
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
  MessageViewModel messageViewModel = MessageViewModel();

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
              SizedBox(
                height: 18.px,
              ),
              Row(
                children: [
                  const AppText('Date', color: AppColors.appGrey),
                  const SizedBox(
                    width: 10,
                  ),
                  sortList(
                    title: messageViewModel.newStatus,
                    selected: messageViewModel.isSelectNewStatus,
                  )
                  // sortList(title: 'hello')
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const AppText('Status', color: AppColors.appGrey),
                  const SizedBox(width: 10),
                  sortList(
                      title: messageViewModel.readStatus,
                      selected: messageViewModel.isSelectReadStatus),
                  const SizedBox(height: 10),
                ],
              ),
              SizedBox(height: 20),
              Divider(
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
                logs('Sekebasg-->${selected[index]}');
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
                  border: Border.all(color: AppColors.appLightGrey),
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
  const ConfirmationButton({super.key});

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 28.px),
              AppImageAsset(image: ImageConstants.warning),
              SizedBox(height: 20.px),
              Align(
                alignment: Alignment.center,
                child: AppText(
                  'Delete Confirmation',
                  fontSize: 16.px,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 18.px),
              const AppText('Are You Sure you want to delete selected message?',
                  color: AppColors.appGrey, fontSize: 12),
              const SizedBox(height: 20),
              AppButton(
                title: 'No, Keep it',
                onPressed: () {},
              ),
              SizedBox(height: 20),
              AppText('Yes,Delete', color: AppColors.appRed),
            ],
          ),
        ],
      ),
    );
  }
}
