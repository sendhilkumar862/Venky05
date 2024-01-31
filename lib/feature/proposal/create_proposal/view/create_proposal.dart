
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
import '../../../../product/extension/string_extension.dart';
import '../../../../product/utils/common_function.dart';
import '../../../../product/utils/typography.dart';
import '../../../../product/utils/validators.dart';
import '../../../class/class_detail/controller/class_detail_controller.dart';
import '../../../classDetails/controller/class_details_controller.dart';
import '../controller/create_proposal_controller.dart';

class CreateProposal extends StatefulWidget {
  const CreateProposal({super.key});

  @override
  State<CreateProposal> createState() => _CreateProposalState();
}

class _CreateProposalState extends State<CreateProposal> {
  var selectedDate = DateTime.now();
  final CreateProposalController _createProposalController =Get.put(CreateProposalController());
  final ClassDetailController _classDetailController = Get.put(ClassDetailController());
  final ClassDetailsController _classDetailsController=Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  bool isDisable = true;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        // isBack: true,
        // trailingText: 'Cancel',
        title: Get.arguments['proposalId']!=null?'Update Proposal':'Create Proposal',
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
                          controller: _createProposalController.classCost,
                          keyboardType:
                          // ignore: use_named_constants
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
                          controller: _createProposalController.numberOfSession,
                          keyboardType:
                           // ignore: use_named_constants
                           const TextInputType.numberWithOptions(),
                          validate: Validators.requiredValidator.call,
                          hintText: 'numberOfSessions'.tr,
                        ),
                        AppTextFormField(
                          validate: Validators.requiredValidator.call,
                          controller: _createProposalController.dateController,
                          onTap: () {
                            calender(context, _createProposalController.dateController);
                          },
                          hintText: 'classDateAndTime'.tr,
                          readOnly: true,
                          suffix: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.downArrowColor),
                        ),
                        // AppTextFormField(
                        //   validate: Validators.requiredValidator.call,
                        //   controller: date2Controller,
                        //   onTap: () {
                        //     calender(context, date2Controller);
                        //   },
                        //   hintText: 'class2DateAndTime'.tr,
                        //   readOnly: true,
                        //   suffix: const Icon(
                        //       Icons.keyboard_arrow_down_sharp,
                        //       color: AppColors.downArrowColor),
                        // ),
                        AppTextFormField(
                          validate: Validators.requiredValidator.call,
                          suffix: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.downArrowColor),
                          hintText: 'classDuration'.tr,
                          title: 'classDuration'.tr,
                          readOnly: true,
                          controller: _createProposalController.classDurationController,
                          onTap: () {
                            bottomSheetDropDownList();
                          },
                        ),
                      ]),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.px, top: 80.px),
                    child: AppButton(
                      title: Get.arguments['proposalId']!=null?'Update':'submit'.tr,
                      onPressed: () async{
                        if (formKey.currentState!.validate()) {
                         bool status=  Get.arguments['proposalId']!=null? await _createProposalController.updateProposal():await _createProposalController.crateProposal();
                         if(status) {
                           _classDetailsController.fetchData();
                           // ignore: use_build_context_synchronously
                           showModalBottomSheet(
                            context: context,
                            constraints: BoxConstraints(
                              maxWidth:
                              // ignore: use_build_context_synchronously
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
                               _createProposalController.proposalId!=''?'You have successfully updated your proposal.':'You have successfully submit your proposal.',
                                isRouting: 'back',

                              );
                            },
                          );
                         }
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
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemCount: _classDetailController.masterData.value.sessionDurations?.length??0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text( _classDetailController.masterData.value.sessionDurations![index].toString().timeConvert(),
                        style: openSans.get16.w400
                            .textColor(AppColors.appTextColor)),
                    onTap: () {
                      _createProposalController.duration = _classDetailController.masterData.value.sessionDurations![index];
                      _createProposalController.classDurationController.text = _classDetailController.masterData.value.sessionDurations![index].toString().timeConvert();
                      Navigator.pop(context);
                    },
                    trailing: _classDetailController.masterData.value.sessionDurations![index]==_createProposalController.duration
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
        );
      },
    );
  }
}
