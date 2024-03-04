import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/route.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/calender/calender.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/extension/string_extension.dart';
import '../../../../product/utils/common_function.dart';
import '../../../../product/utils/validators.dart';
import '../../controller/class_details_controller.dart';

class RescheduleClass extends StatefulWidget {
  const RescheduleClass({super.key});

  @override
  State<RescheduleClass> createState() => _RescheduleClassState();
}

class _RescheduleClassState extends State<RescheduleClass> {
  final ClassDetailsController _classDetailsController =
      Get.put(ClassDetailsController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        trailingText: 'cancel'.tr,
        title: 'Reschedule Class',
        isBack: false,
        trailingTap: () {
          _classDetailsController.dateControllers.clear();
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: <Widget>[
              if (_classDetailsController.reScheduleInfoList.isNotEmpty && _classDetailsController.dateControllers.isNotEmpty) ListView.separated(
                padding: const EdgeInsets.only(
                    right: 15, top: 5, bottom: 20, left: 15),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: _classDetailsController.reScheduleInfoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 340.px,
                    child: AppTextFormField(
                      validate: Validators.requiredValidator.call,
                      controller:
                          _classDetailsController.dateControllers[index],
                      onTap: () {
                        calender(
                            context,
                            _classDetailsController.dateControllers[index],
                            index);
                      },
                      hintText: 'Class Date and Time',
                      readOnly: true,
                      suffix: const Icon(Icons.keyboard_arrow_down_sharp,
                          color: AppColors.downArrowColor),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 15,
                  );
                },
              ) else const SizedBox.shrink(),
              AppButton(
                  isDisable: false,
                  title: 'Reschedule',
                  borderColor: AppColors.appBlue,
                  onPressed: () async {
                    List data = [];
                    for (int index = 0;
                        index < _classDetailsController.dateControllers.length;
                        index++) {
                      data.add(<String, dynamic>{
                        'classScheduleId': _classDetailsController
                                .reScheduleInfoList[index].classScheduleId ??
                            0,
                        'oldTime': _classDetailsController
                                .reScheduleInfoList[index].startTime ??
                            0,
                        'newTime': _classDetailsController
                            .dateControllers[index].text
                            .toEpoch()
                      });
                    }

                    final bool status = await _classDetailsController
                        .rescheduleClass(
                            <String, dynamic>{'scheduleInfo': data});
                    if (status) {
                      // ignore: use_build_context_synchronously
                      showModalBottomSheet(
                        context: context,
                        constraints: BoxConstraints(
                          maxWidth:
                              // ignore: use_build_context_synchronously
                              (MediaQuery.of(context).size.width - 30).px,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.px),
                        ),
                        builder: (BuildContext context) {
                          return SuccessFailsInfoDialog(
                            title: 'Success',
                            buttonTitle: 'Done',
                            content:
                                'You have successfully reschedule the class time, awaiting teacher acceptance.',
                            isRouting: 'back',
                            argument: _classDetailsController.classId,
                            backIndex: 1,
                          );
                        },
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> calender(
      BuildContext context, TextEditingController controller, int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AppCalender(
                selectedTime: (DateTime selectedTime) {
                  _classDetailsController.selectedTimes =
                      formatTime(selectedTime).obs;
                  controller.text =
                      '${_classDetailsController.selectedDate} ${_classDetailsController.selectedTimes}';
                },
                selectedDate: (String selectedDate) {
                  _classDetailsController.selectedDate.value = selectedDate;
                  controller.text =
                      '${_classDetailsController.selectedDate} ${_classDetailsController.selectedTimes}';
                },
                startDate: DateTime.now());
          },
        );
      },
    );
  }
}
