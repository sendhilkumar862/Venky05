
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/info_card_view.dart';
import '../../../custom/choice/src/inline/list.dart';
import '../../../custom/choice/src/inline/main.dart';
import '../../../custom/choice/src/selection/controller/main.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/sheet/show_bottom_sheet.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/typography.dart';
import '../viewModel/notification_view_model.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  Set<int> shortBy = <int>{};
  Set<int> filterBy = <int>{};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationViewModel>(
      viewModel: NotificationViewModel(),
      onModelReady: (NotificationViewModel model, WidgetRef ref) {
        model.init();
        model.setContext(context);
      },
      onPageBuilder:
          (BuildContext context, NotificationViewModel notificationViewModel, WidgetRef ref) =>
              Scaffold(
        appBar: HessaAppBar(
          isTitleOnly: true,
          title: 'notification'.tr,
          isBack: true,
        ),
        body: Observer(builder: (context) {
          return notificationViewModel.notificationDataList.isNotEmpty
              ? Padding(
                  padding:
                      EdgeInsets.only(left: 16.px, top: 10.px, bottom: 10.px),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          filterBottomSheet(context, notificationViewModel);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
                          child: Row(
                            children: <Widget>[
                              AppImageAsset(
                                image: ImageConstants.upDownArrow,
                                height: 16.px,
                                width: 16.px,
                              ),
                              SizedBox(width: 8.px),
                              AppText(
                                'Sort',
                                fontSize: 14.px,
                                color: AppColors.appBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 1,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  child: Text('Today',
                                      style: openSans.get12.w700.copyWith(
                                          color: AppColors.appTextColor
                                              .withOpacity(0.5))),
                                ),
                                ListView.builder(
                                  itemCount: notificationViewModel
                                      .notificationDataList.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = notificationViewModel
                                        .notificationDataList[index];
                                    return Column(
                                      children: [
                                        Slidable(
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            extentRatio: 0.2,
                                            dragDismissible: false,
                                            dismissible: DismissiblePane(
                                                onDismissed: () {}),
                                            children: <Widget>[
                                              SlidableAction(
                                                onPressed:
                                                    (BuildContext context) {
                                                  setState(() {
                                                    notificationViewModel
                                                        .notificationDataList
                                                        .removeAt(index);
                                                  });
                                                },
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                label: 'Delete',
                                                backgroundColor:
                                                    AppColors.appLightRed,
                                                foregroundColor:
                                                    AppColors.appBlue,
                                                icon: Icons.ac_unit_rounded,
                                              ),
                                            ],
                                          ),
                                          key: const ValueKey(0),
                                          closeOnScroll: true,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {});
                                              data.isRead = false;
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Container(
                                                        height: 44,
                                                        width: 44,
                                                        decoration: BoxDecoration(
                                                            color: Color(data
                                                                    .isRead
                                                                ? 0xffD0F7DB
                                                                : 0xFFFFEDEE),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        child: SvgPicture.asset(
                                                          fit: BoxFit.scaleDown,
                                                          data.icon,
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          data.title,
                                                          style: openSans
                                                              .get14.w500,
                                                        ),
                                                        Text(data.description,
                                                            style: openSans
                                                                .get10.w400
                                                                .textColor(AppColors
                                                                    .appTextColor
                                                                    .withOpacity(
                                                                        0.5))),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(data.time,
                                                          style: openSans
                                                              .get10.w400
                                                              .textColor(AppColors
                                                                  .appTextColor
                                                                  .withOpacity(
                                                                      0.5))),
                                                      if (data.isRead)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 5,
                                                                  right: 6),
                                                          child:
                                                              SvgPicture.asset(
                                                            ImageConstants
                                                                .alert,
                                                          ),
                                                        ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_right_rounded,
                                                        color: AppColors
                                                            .downArrowColor
                                                            .withOpacity(0.5),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: Color(0xffC5CEEE)
                                              .withOpacity(0.5),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InfoCardVIew(
                      isShowButton: false,
                      title: 'No Notifications!',
                      subTitle: "Use the app and get notifications",
                      cardColor: AppColors.white,
                      buttonTitle: 'Class Details',
                      buttonTap: () => null,
                    ),
                  ],
                );
        }),
      ),
    );
  }

  void filterBottomSheet(
      BuildContext context, NotificationViewModel notificationViewModel) {
    return showCommonBottomSheet(
        context: context,
        commonWidget: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
              child: Observer(builder: (_) {
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: const Align(
                              child: AppText('Sort',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: AppColors.appTextColor),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.downArrowColor
                                          .withOpacity(0.15)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3),
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 2),
                        child: AppText('Sort by',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.appTextColor),
                      ),
                      InlineChoice<String>(
                        clearable: true,
                        value: notificationViewModel.shortByList,
                        onChanged: notificationViewModel.setSchoolValue,
                        itemCount: notificationViewModel.shortByList.length,
                        itemBuilder:
                            (ChoiceController<String> selection, int index) {
                          return ChoiceChip(
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: shortBy.contains(index)
                                        ? AppColors.trans
                                        : AppColors.appBorderColor
                                            .withOpacity(0.25))),
                            backgroundColor: AppColors.trans,
                            selected: shortBy.contains(index),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  shortBy.add(
                                      index); // Add to the set for multi-selection
                                } else {
                                  shortBy.remove(index); // Remove from the set
                                }
                              });
                            },
                            showCheckmark: false,
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                  notificationViewModel.shortByList[index],
                                  style: openSans.get12.w600),
                            ),
                            selectedColor: AppColors.appBlue,
                            // Change this to your desired color
                            labelStyle: TextStyle(
                              color: shortBy.contains(index)
                                  ? AppColors.white
                                  : AppColors.appTextColor
                                      .withOpacity(0.5), // Change text color
                            ),
                          );
                        },
                        listBuilder: ChoiceList.createWrapped(),
                      ),
                      InlineChoice<String>(
                        clearable: true,
                        value: notificationViewModel.filterByList,
                        onChanged: notificationViewModel.setSchoolValue,
                        itemCount: notificationViewModel.filterByList.length,
                        itemBuilder:
                            (ChoiceController<String> selection, int index) {
                          return ChoiceChip(
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: filterBy.contains(index)
                                        ? AppColors.trans
                                        : AppColors.appBorderColor
                                            .withOpacity(0.25))),
                            backgroundColor: AppColors.trans,
                            selected: filterBy.contains(index),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  filterBy.add(
                                      index); // Add to the set for multi-selection
                                } else {
                                  filterBy.remove(index); // Remove from the set
                                }
                              });
                            },
                            showCheckmark: false,
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                  notificationViewModel.filterByList[index],
                                  style: openSans.get12.w600),
                            ),
                            selectedColor: AppColors.appBlue,
                            // Change this to your desired color
                            labelStyle: TextStyle(
                              color: filterBy.contains(index)
                                  ? AppColors.white
                                  : AppColors.appTextColor
                                      .withOpacity(0.5), // Change text color
                            ),
                          );
                        },
                        listBuilder: ChoiceList.createWrapped(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Divider(
                          height: 1,
                          color: Color(0xffC5CEEE).withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: AppButton(
                          onPressed: () {},
                          title: 'Clear Selections',
                          isDisable: shortBy.isNotEmpty || filterBy.isNotEmpty
                              ? false
                              : true,
                        ),
                      ),
                    ]);
              }),
            );
          },
        ));
  }
}

class NotificationData {
  NotificationData({
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
    required this.id,
    this.isRead = true,
  });

  final String icon;
  final String title;
  final String description;
  final String time;
  final String id;
  bool isRead;
}
