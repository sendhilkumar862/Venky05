import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/common_dropdown/app_dropdown.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/typography.dart';
import '../controller/confirm_attendance_controller.dart';
import '../model/class_attendance_model.dart';


class ConfirmAttendanceView extends StatefulWidget {
  const ConfirmAttendanceView({super.key});

  @override
  State<ConfirmAttendanceView> createState() => _ConfirmAttendanceViewState();
}

class _ConfirmAttendanceViewState extends State<ConfirmAttendanceView> with TickerProviderStateMixin {
     final ConfirmAttendanceController _confirmAttendanceController =
      Get.put(ConfirmAttendanceController());
      
  @override
  void initState() {
    super.initState();
    _confirmAttendanceController.onInit();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppColors.appWhite,
        appBar: HessaAppBar(
          icon: ImageConstants.avtar,
          title: 'Students',
          isTitleOnly: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
                Obx(() => AppDropdown(
                      options: _confirmAttendanceController.sessionNumber.value,
                      title: 'Session',
                      hintStyle:openSans.w400
                              .textColor(
                                  AppColors.appTextColor.withOpacity(0.25))
                              .get14,
                      value: '',
                      hintText: 'Select Session',
                      onChanged: _confirmAttendanceController.onSelectSession,
                    ),),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Obx(() => GridView.count(
                   crossAxisCount: 2,  
                  crossAxisSpacing: 4.0,  
                  mainAxisSpacing: 8.0,  
                  childAspectRatio: 0.83,
                  children: List.generate(_confirmAttendanceController.sessionClassAttandanceList.length, (int index) {  
                    return Card(
                      surfaceTintColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const CircleAvatar(backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049_640.png'),),
                            Text('${_confirmAttendanceController.sessionClassAttandanceList[index].name}'),
                            Text('Grade - ${_confirmAttendanceController.sessionClassAttandanceList[index].grade}'),
                            if (_confirmAttendanceController.sessionClassAttandanceList[index].status==2) Column(
                              children: [
                                AppButton(
                                    isDisable: false,
                                    title: 'Attended',
                                    borderColor: AppColors.appBlue,
                                    onPressed: (){
                                      _confirmAttendanceController.makeItAsAttended(true,_confirmAttendanceController.sessionClassAttandanceList[index]);
                                    },
                                  ),
                                  AppButton(
                                    isDisable: false,
                                    title: 'Not Attended',
                                    isBorderOnly: true,
                                    borderColor: AppColors.white,
                                    height: 30,
                                    onPressed: (){
                                        _confirmAttendanceController.makeItAsAttended(false,_confirmAttendanceController.sessionClassAttandanceList[index]);
                                    },
                                  )
                              ],
                            ) else AppButton(
                                    isDisable: false,
                                    title: _confirmAttendanceController.sessionClassAttandanceList[index].status==0?'Not Attended':'Attended',
                                    borderColor: AppColors.appBlue,
                                    onPressed: (){},
                                  ),
                          ],
                        ),
                      ),
                    );  
                  }  
                  )  ,),)
              ),
             const SizedBox(
                height: 20,
              ),
            AppButton(
                isDisable: true,
                title: 'All Student Attended',
                borderColor: AppColors.appBlue,
                onPressed: (){},
              ),
              const SizedBox(height: 30)
            ],
          ),
        ));
  }
}
