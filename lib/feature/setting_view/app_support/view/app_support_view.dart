import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/route.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/appbar/appbar.dart';
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
    'Inprogress',
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

  List<StatusModel> statusModelList = <StatusModel>[
    StatusModel(StatusCardView(status: 'NEW'),
        title: 'Refund', idNum: '#1234567890', date: 'Created On: 12/10/2023'),
    StatusModel(StatusCardView(status: 'IN PROGRESS'),
        title: 'Refund', idNum: '#1234597890', date: 'Created On: 12/10/2023'),
    StatusModel(StatusCardView(status: 'SOLVED'),
        title: 'Refund', idNum: '#1234567890', date: 'Created On: 12/10/2023'),
    StatusModel(StatusCardView(status: 'CANCEL'),
        title: 'Refund', idNum: '#1234567890', date: 'Created On: 12/10/2023'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        title: 'App Support',
        isTitleOnly: true,
      ),
      body: Obx(
          ()=> _appSupportController.getTicketsList.isNotEmpty?Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
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
                    ListView.builder(
                      itemCount: _appSupportController.getTicketsList.isNotEmpty?_appSupportController.getTicketsList.length:statusModelList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var data = statusModelList[index];
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
                                  Icon(
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
                  ],
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
        ):SizedBox.shrink(),
      ),
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
