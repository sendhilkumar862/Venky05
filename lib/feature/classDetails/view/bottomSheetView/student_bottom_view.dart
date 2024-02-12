import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../controller/class_details_controller.dart';
class StudentBottomSheet extends StatefulWidget {
  const StudentBottomSheet({super.key,required this.classId});
  final String classId;
  @override
  State<StudentBottomSheet> createState() => _StudentBottomSheetState();
}

class _StudentBottomSheetState extends State<StudentBottomSheet> {

  final ClassDetailsController _classDetailsController = Get.put(ClassDetailsController());
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: (MediaQuery.of(context).size.height * 0.92).px,
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
              margin: EdgeInsets.only(top: 14.px, right: 15.px),
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
                height: 25.px,
              ),
              AppText('Students',
                  fontWeight: FontWeight.w700, fontSize: 14.px),
              SizedBox(
                height: 30.px,
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15.px),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _classDetailsController.studentsList.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.px,
                      mainAxisSpacing: 10.px,
                      childAspectRatio: 0.65),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(10.px),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.px),
                        border: Border.all(color: AppColors.appLightGrey),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: AppImageAsset(
                                image: ImageConstants.removeBookmark,
                                height: 18.px),
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 8.px,
                                ),
                                AppImageAsset(
                                  image: _classDetailsController.studentsList[index].imageId??ImageConstants.avtar,
                                  height: 55.px,
                                ),
                                SizedBox(
                                  height: 6.px,
                                ),
                                AppText(
                                  _classDetailsController.studentsList[index].name??'',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.px,
                                ),
                                SizedBox(
                                  height: 4.px,
                                ),
                                AppText(
                                    'Grade ${_classDetailsController.studentsList[index].grade?.join(' - ')}',
                                    fontSize: 12.px,
                                ),
                                SizedBox(
                                  height: 10.px,
                                ),
                               if(_classDetailsController.studentsList[index].status!=null && _classDetailsController.studentsList[index].status==0) AppButton(
                                  title: 'Accept',
                                  height: 45.px,
                                  isDisable: false,
                                  borderColor: AppColors.appBlue,
                                  borderRadius: BorderRadius.circular(10.px),
                                  onPressed: () {
                                    _classDetailsController.approveRejectStudents(widget.classId, <String, dynamic>{'isSelectAll':false,'type':'accept','users':<int?>[_classDetailsController.studentsList[index].userId]});
                                  },
                                ),
                                if(_classDetailsController.studentsList[index].status!=null && _classDetailsController.studentsList[index].status==1) const Text(
                                  'Accepted',
                                  style: TextStyle(
                                          color: AppColors.appBlue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                ),
                                if(_classDetailsController.studentsList[index].status!=null && _classDetailsController.studentsList[index].status==2) AppText(
                                  'Rejected',
                                  fontSize: 14.px,
                                  color: AppColors.appLightRed,
                                ),
                                SizedBox(height: 10.px),
                                if(_classDetailsController.studentsList[index].status!=null && _classDetailsController.studentsList[index].status==0) GestureDetector(
                                  onTap: (){
                                    _classDetailsController.approveRejectStudents(widget.classId, <String, dynamic>{'isSelectAll':false,'type':'reject','users':<int?>[_classDetailsController.studentsList[index].userId]});
                                  },
                                  child: AppText(
                                    'Reject',
                                    fontSize: 14.px,
                                    color: AppColors.appLightRed,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (_classDetailsController.studentsList.length>1) Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                child: AppButton(
                  title: 'Accept All Students',
                  height: 45.px,
                  isDisable: false,
                  borderRadius: BorderRadius.circular(10.px),
                  borderColor: AppColors.appBlue,
                  onPressed: () {
                    _classDetailsController.approveRejectStudents(widget.classId, <String, dynamic>{'isSelectAll':true,'type':'accept'});
                  },
                ),
              ) else const SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}
