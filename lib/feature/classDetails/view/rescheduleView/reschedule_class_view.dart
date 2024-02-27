import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/calender/calender.dart';
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
    return Scaffold( appBar: HessaAppBar(
      isTitleOnly: true,
      trailingText: 'cancel'.tr,
      title: 'Reschedule Class',
      isBack: false,
      trailingTap: (){

        _classDetailsController.dateControllers.clear()
            Get.back();
      },
    ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            Obx(
            ()=> ListView.separated(
                padding: const EdgeInsets.only(
                    right: 15, top: 5, bottom: 20, left: 15),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: _classDetailsController.reScheduleInfoList.length,
                itemBuilder: (BuildContext context, int index) {
                  // ignore: unnecessary_null_comparison
                  // _classDetailsController.dateController.text=_classDetailsController.reScheduleInfoList[index].startTime!=null?_classDetailsController.reScheduleInfoList[index].startTime.toString().epochToNormal():'';
                  // _classDetailsController.classScheduleId=_classDetailsController.reScheduleInfoList[index].classScheduleId??0;
                  // _classDetailsController.oldDateValue=_classDetailsController.reScheduleInfoList[index].startTime!=null?_classDetailsController.reScheduleInfoList[index].startTime.toString():'';
                  _classDetailsController.dateControllers.add(TextEditingController(text: _classDetailsController.reScheduleInfoList[index].startTime!=null?_classDetailsController.reScheduleInfoList[index].startTime.toString().epochToNormal():''));
                  return SizedBox(
                    width: 340.px,
                    child: AppTextFormField(
                      validate: Validators.requiredValidator.call,
                      controller: _classDetailsController.dateControllers[index],
                      onTap: () {
                        calender(
                          context,
                          _classDetailsController.dateControllers[index],
                        );
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
              ),
            ),
            AppButton(
            isDisable: false,
            title: 'Reschedule',
            borderColor: AppColors.appBlue,
            onPressed: () {
              // _classDetailsController.rescheduleClass({
              //   'scheduleInfo': [
              //     {
              //       'classScheduleId': _classDetailsController.classScheduleId,
              //       'oldTime': _classDetailsController.oldDateValue,
              //       'newtime':_classDetailsController.dateController.text.toEpoch(),
              //     }
              //   ]
              // });
            },
                    )
        
          ],
        ),
      ),
    );
  }

  Future<void> calender(
      BuildContext context,
      TextEditingController controller,
      ) async {
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
                startDate:DateTime.now()
            );
          },
        );
      },
    );
  }
}
