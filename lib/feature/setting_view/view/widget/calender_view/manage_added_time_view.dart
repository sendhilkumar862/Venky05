import 'package:flutter/material.dart';
import '../../../../../config/routes/routes.dart';
import '../../../../../custom/app_button/app_button.dart';
import '../../../../../custom/app_textformfield/app_field.dart';
import '../../../../../custom/appbar/appbar.dart';
import '../../../../../custom/cardView/info_card_view.dart';
import '../../../../../custom/cardView/warning_card_view.dart';
import '../../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../../custom/sheet/show_bottom_sheet.dart';
import '../../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../../product/utils/typography.dart';
import '../../../../../product/utils/validators.dart';

class ManageAddedTimeView extends StatefulWidget {
  const ManageAddedTimeView({super.key});

  @override
  State<ManageAddedTimeView> createState() => _ManageAddedTimeViewState();
}

class _ManageAddedTimeViewState extends State<ManageAddedTimeView> {
  TextEditingController startTimeDurationController = TextEditingController();
  TextEditingController endTimeDurationController = TextEditingController();
  int? startTime;
  int? endTime;
  List<String> timeDurationList = <String>[
    '04:30 PM',
    '04:45 PM',
    '05:00 PM',
    '05:15 PM',
    '05:30 PM',
    '05:45 PM',
    '06:00 PM',
    '06:15 PM',
    '06:30 PM',
    '06:45 PM',
    '07:00 PM',
    '07:15 PM',
    '07:30 PM',
    '07:45 PM',
    '08:00 PM',
    '08:15 PM',
    '08:30 PM',
    '08:45 PM',
    '09:00 PM',
    '09:15 PM',
    '09:30 PM',
    '09:45 PM',
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return  Scaffold(
      appBar: HessaAppBar(
        title: 'Add Free Time',
        isTitleOnly: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  AppTextFormField(
                    validate: Validators.requiredValidator.call,
                    suffix: const Icon(Icons.keyboard_arrow_down_sharp,
                        color: AppColors.downArrowColor),
                    title: 'Date',
                    readOnly: true,
                    controller:  startTimeDurationController,
                    onTap: () {
                    },
                  ),
                  AppTextFormField(
                    validate: Validators.requiredValidator.call,
                    suffix: const Icon(Icons.keyboard_arrow_down_sharp,
                        color: AppColors.downArrowColor),
                    hintText: 'Select Start Time',
                    title: 'Start Time',
                    readOnly: true,
                    controller:  startTimeDurationController,
                    onTap: () {
                      timeDurationSheet(context, width,
                      );
                    },
                  ),
                  AppTextFormField(
                    validate: Validators.requiredValidator.call,
                    suffix: const Icon(Icons.keyboard_arrow_down_sharp,
                        color: AppColors.downArrowColor),
                    hintText: 'Select End Time',
                    title: 'End Time',
                    readOnly: true,
                    controller:  endTimeDurationController,
                    onTap: () {
                      showCommonBottomSheet(
                          context: context,
                          commonWidget: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text('Class Duration', style: openSans.get14.w700),
                                          SizedBox(
                                            width: width * 0.25,
                                          ),
                                          Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                  AppColors.downArrowColor.withOpacity(0.15)),
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 15,
                                                ),
                                              ))
                                        ]),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (BuildContext context, index) {
                                    return const Divider();
                                  },
                                  itemCount: timeDurationList.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return ListTile(
                                      title: Text(timeDurationList[index],
                                          style: openSans.get16.w400
                                              .textColor(AppColors.appTextColor)),
                                      onTap: () {

                                        endTime = index;
                                        endTimeDurationController.text = timeDurationList[index];
                                        Navigator.pop(context);
                                      },
                                      trailing: startTime == index
                                          ? const Icon(
                                        Icons.check_circle,
                                        color: AppColors.appBlue,
                                      )
                                          : const SizedBox(),
                                    );
                                  },
                                ),
                              ),

                            ],
                          )
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:15),
                    child: WarningCardView(error: 'Another free time is found during your selection. If you proceed, the times will be merged.',),
                  )
                ],
              ),
            ),
            AppButton(
                title: 'Add Available Teaching Time',
                onPressed: (){
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 30,
                      // here increase or decrease in width
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    builder: (BuildContext context) {
                      return SuccessFailsInfoDialog(
                        // onPressed: () {
                        //   AppRouter.push(PendingTickets());
                        // },
                        verticalPadding: 10,
                        title: 'Success',
                        buttonTitle: 'Done',
                        content: 'You have successfully added new available teaching time.',
                      );
                    },
                  );
                }
            )
          ],
        ),
      ),
    );
  }

  void timeDurationSheet(BuildContext context, double width,) {
    return showCommonBottomSheet(
                context: context,
                commonWidget: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('Class Duration', style: openSans.get14.w700),
                                SizedBox(
                                  width: width * 0.25,
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                        AppColors.downArrowColor.withOpacity(0.15)),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 15,
                                      ),
                                    ))
                              ]),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, index) {
                          return const Divider();
                        },
                        itemCount: timeDurationList.length,
                        itemBuilder: (BuildContext context, index) {
                          return ListTile(
                            title: Text(timeDurationList[index],
                                style: openSans.get16.w400
                                    .textColor(AppColors.appTextColor)),
                            onTap: () {

                              startTime = index;
                              startTimeDurationController.text = timeDurationList[index];
                              Navigator.pop(context);
                            },
                            trailing: startTime == index
                                ? const Icon(
                              Icons.check_circle,
                              color: AppColors.appBlue,
                            )
                                : const SizedBox(),
                          );
                        },
                      ),
                    ),
                  ],
                )
            );
  }
}
