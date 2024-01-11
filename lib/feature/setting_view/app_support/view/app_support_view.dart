import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/route.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../custom/cardView/status_card_view.dart';
import '../../../../custom/choice/src/inline/list.dart';
import '../../../../custom/choice/src/inline/main.dart';
import '../../../../custom/choice/src/selection/controller/main.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/sheet/show_bottom_sheet.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/extension/string_extension.dart';
import '../../../../product/utils/typography.dart';
import '../../view/widget/app_support/new_ticket_view.dart';
import '../controller/app_support_controller.dart';


class AppSupportView extends StatefulWidget {
  const AppSupportView({super.key});

  @override
  State<AppSupportView> createState() => _AppSupportViewState();
}

class _AppSupportViewState extends State<AppSupportView> {
  List<String> shortByList = <String>[
    'Date',
    'Old to New',
    'New to Old',
  ];
  List<String> filterByList = <String>[
    'New',
    'InProgress',
    'Solved',
  ];

  void filterByValue(List<String> value) {
    setState(() => shortByList = value);
  }

  void setSchoolValue(List<String> value) {
    setState(() => filterByList = value);
  }

  Set<int> shortBy = <int>{};
  Set<int> filterBy = <int>{};

  final AppSupportController _appSupportController =
  Get.put(AppSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        title: 'App Support',
        isTitleOnly: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Obx(
              ()=> _appSupportController.getTicketsList.isNotEmpty?Expanded(
                  child: Column(
                    children: [
                      TextFormsField(
                        controller: _appSupportController
                            .searchTicketController,
                        hintText: 'search Tickets',
                        prefix: Padding(
                          padding: EdgeInsets.only(left: 10.px),
                          child: const AppImageAsset(
                              image: ImageConstants.searchIcon,
                              height: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () {
                            filterBottomSheet(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              AppText(
                                'Sort / Filter',
                                fontSize: 14.px,
                                color: AppColors.appBlue,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(width: 5.px),
                              AppImageAsset(
                                image: ImageConstants.filterSettings,
                                height: 16.px,
                                width: 16.px,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _appSupportController.getTicketsList.length,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _appSupportController.getTicketsList[index].title!=null?_appSupportController.getTicketsList[index].title!:'',
                                              style: openSans.get14.w500,
                                            ),
                                            Text(
                                              _appSupportController.getTicketsList[index].ticketId!=null?'#${_appSupportController.getTicketsList[index].ticketId!}':'',
                                              style: openSans.get10.w400.textColor(
                                                  AppColors.appTextColor
                                                      .withOpacity(0.5)),
                                            ),
                                            Text(
                                              _appSupportController.getTicketsList[index].createdAt!=null?_appSupportController.getTicketsList[index].createdAt!.toString().epochToNormal():'',
                                              style: openSans.get10.w400.textColor(
                                                  AppColors.appTextColor
                                                      .withOpacity(0.5)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: StatusCardView(status: _appSupportController.getTicketsList[index].status!=null? _appSupportController.getTicketsList[index].status!:'',),),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 12,
                                        color: AppColors.arrowColor,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Divider(
                                      color:
                                          AppColors.appBorderColor.withOpacity(0.5),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AppButton(
                            isDisable: false,
                            title: 'Open New Ticket',
                            onPressed: () {
                              Get.toNamed(Routes.newTicketView);
                            }),
                      )
                    ],
                  ),
                )
                :InfoCardVIew(
                    isShowButton: true,
                    title: 'No Tickets Found!',
                    subTitle:
                    "No tickets created yet? If you have issues, submit a ticket anytime. We're here to assist!",
                    cardColor: AppColors.white,
                    buttonTitle: 'Open New Ticket',
                    buttonTap: () => Get.toNamed(Routes.newTicketView),
                  ),
              ),

            ],
          ),
        )
    );
  }

  void filterBottomSheet(BuildContext context) {
    return showCommonBottomSheet(
        context: context,
        commonWidget: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Align(
                            child: AppText('Sort / Filter',
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
                      value: shortByList,
                      onChanged: setSchoolValue,
                      itemCount: shortByList.length,
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
                                shortBy.clear();
                                shortBy.add(
                                    index); // Add to the set for multi-selection
                              } else {
                                shortBy.remove(index); // Remove from the set
                              }
                            });
                          },
                          showCheckmark: false,
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(shortByList[index],
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
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 15),
                      child: Divider(
                        height: 1,
                        color: Color(0xffC5CEEE).withOpacity(0.5),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 2),
                      child: AppText('Filter by',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.appTextColor),
                    ),
                    InlineChoice<String>(
                      clearable: true,
                      value: filterByList,
                      onChanged: setSchoolValue,
                      itemCount: filterByList.length,
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
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(filterByList[index],
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
                      padding: const EdgeInsets.only(top: 25),
                      child: AppButton(
                        onPressed: () {},
                        title: 'Clear Selections',
                        isDisable: shortBy.isNotEmpty || filterBy.isNotEmpty
                            ? false
                            : true,
                      ),
                    ),
                  ]),
            );
          },
        ));
  }
}

class StatusModel {
  StatusModel(this.status,
      {required this.title, required this.idNum, required this.date});
  final StatusCardView status;
  final String title;
  final String idNum;
  final String date;
}
// InfoCardVIew(
// isShowButton: true,
// title: 'No Tickets!',
// subTitle:
// "No tickets created yet? If you have issues, submit a ticket anytime. We're here to assist!",
// cardColor: AppColors.white,
// buttonTitle: 'Open New Ticket',
// buttonTap: () => null,
// ),
