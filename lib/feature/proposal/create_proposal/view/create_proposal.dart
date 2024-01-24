
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/calender/calender.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/common_function.dart';
import '../../../../product/utils/typography.dart';
import '../../../../product/utils/validators.dart';
import '../controller/create_proposal_controller.dart';

class CreateProposal extends StatefulWidget {
  const CreateProposal({super.key});

  @override
  State<CreateProposal> createState() => _CreateProposalState();
}

class _CreateProposalState extends State<CreateProposal> {
  var selectedDate = DateTime.now();
  final CreateProposalController _createProposalController =Get.put(CreateProposalController());
  int? isSelected;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController date2Controller = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController classCost = TextEditingController();
  TextEditingController numberOfSession = TextEditingController();
  TextEditingController classDurationController = TextEditingController();

  bool isDisable = true;
  String dateAndTime = '';
  String classDuration = '';

  bool isChecked = false;
  List<String> dateAndTimeList = <String>[
    'abs',
    'hello',
    'guys',
  ];
  List<String> classDurationList = <String>[
    '1 Hours',
    '1 Hour - 15 Minutes',
    '1 Hour - 30 Minutes',
    '1 Hour - 45 Minutes',
    '2 Hours',
    '2 Hour - 15 Minutes',
    '2 Hour - 30 Minutes',
    '2 Hour - 45 Minutes',
    '3 Hour',
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        // isBack: true,
        // trailingText: 'Cancel',
        title: 'createClass'.tr,
        // normalAppbar: true,
      ),
      body:  Form(
          key: formKey,
          onChanged: () {
            if (formKey.currentState!.validate()) {
              setState(() {
                isDisable = false;
              });
            } else {
              setState(() {
                isDisable = true;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'proposalDetails'.tr,
                            style: openSans.get20.w700
                                .textColor(AppColors.appTextColor),
                          ),
                        ),
                        AppTextFormField(
                          controller: classCost,
                          keyboardType:
                          const TextInputType.numberWithOptions(),
                          validate: Validators.requiredValidator.call,
                          suffix: Padding(
                            padding:
                            const EdgeInsets.only(top: 5, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('kwd'.tr,
                                    style: openSans.get16.w400),
                                const SizedBox(
                                  width: 4,
                                ),
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(500),
                                  child: AppImageAsset(
                                    fit: BoxFit.fill,
                                    image: ImageConstants.kuwaitFlag,
                                    height: 20.px,
                                    width: 20.px,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'classCost'.tr,
                        ),
                        AppTextFormField(
                          controller: numberOfSession,
                          keyboardType:
                          const TextInputType.numberWithOptions(),
                          validate: Validators.requiredValidator.call,
                          hintText: 'numberOfSessions'.tr,
                        ),
                        AppTextFormField(
                          validate: Validators.requiredValidator.call,
                          controller: dateController,
                          onTap: () {
                            calender(context, dateController);
                          },
                          hintText: 'classDateAndTime'.tr,
                          readOnly: true,
                          suffix: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.downArrowColor),
                        ),
                        AppTextFormField(
                          validate: Validators.requiredValidator.call,
                          controller: date2Controller,
                          onTap: () {
                            calender(context, date2Controller);
                          },
                          hintText: 'class2DateAndTime'.tr,
                          readOnly: true,
                          suffix: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.downArrowColor),
                        ),
                        AppTextFormField(
                          validate: Validators.requiredValidator.call,
                          suffix: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.downArrowColor),
                          hintText: 'classDuration'.tr,
                          title: 'classDuration'.tr,
                          readOnly: true,
                          controller: classDurationController,
                          onTap: () {
                            bottomSheetDropDownList();
                          },
                        ),
                      ]),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.px, top: 80.px),
                    child: AppButton(
                      title: 'submit'.tr,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          showModalBottomSheet(
                            context: context,
                            constraints: BoxConstraints(
                              maxWidth:
                              (MediaQuery.of(context).size.width - 30)
                                  .px,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.px),
                            ),
                            builder: (BuildContext context) {
                              return SuccessFailsInfoDialog(
                                title: 'Success',
                                buttonTitle: 'Done',
                                content:
                                'You have successfully submit your proposal.',
                              );
                            },
                          );
                        }
                      },
                      isDisable: isDisable,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )

    );
  }

  Future<void> calender(BuildContext context, TextEditingController controller,
      ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AppCalender(
              selectedTime: (DateTime selectedTime) {
                _createProposalController.selectedTimes.value = formatTime(selectedTime);
                controller.text =
                    '${_createProposalController.selectedDate.value} ${_createProposalController.selectedTimes.value}';
              },
              selectedDate: (String selectedDate) {
                _createProposalController.selectedDate.value = selectedDate;
                controller.text =
                    '${_createProposalController.selectedDate.value} ${_createProposalController.selectedTimes.value}';
              },
            );
          },
        );
      },
    );
  }

  Widget iconButtonWidget(
      {Color? bgColor,
      required IconData icon,
      double? iconSize,
      double? padding,
      void Function()? onPress}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor ?? AppColors.secondaryColor),
          child: Padding(
            padding: EdgeInsets.all(padding ?? 5.0),
            child: Icon(
              icon,
              size: iconSize ?? 23,
              color: AppColors.white,
            ),
          )),
    );
  }

  void bottomSheetDropDownList() {
    final double width = MediaQuery.sizeOf(context).width;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (context) {
        return Column(
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('classDuration'.tr, style: openSans.get14.w700),
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
                              icon: const Icon(
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
                itemCount: classDurationList.length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    title: Text(classDurationList[index],
                        style: openSans.get16.w400
                            .textColor(AppColors.appTextColor)),
                    onTap: () {
                      isSelected = index;
                      classDurationController.text = classDurationList[index];
                      Navigator.pop(context);
                    },
                    trailing: isSelected == index
                        ? const Icon(
                            Icons.check_circle,
                            color: AppColors.appBlue,
                          )
                        : SizedBox(),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
