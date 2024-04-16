
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hessah/core/base_response.dart';

import '../../../config/routes/route.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../classDetails/repository/get_class_attendance_repository.dart';
import '../../classDetails/repository/get_review_class_details_repository.dart';
import '../../classDetails/repository/post_review_class_details_repository.dart';
import '../model/class_attendance_model.dart';
import '../model/review_session_submit_model.dart';



class ConfirmAttendanceController extends GetxController{

     RxList<String> sessionNumber=<String>[].obs;
    ClassAttendanceModel fullSessionRecord=ClassAttendanceModel();
     final GetClassAttendanceRepository _getClassAttendanceRepository=GetClassAttendanceRepository();
     final PostReviewClassDetailRepository _postReviewClassDetailRepository=PostReviewClassDetailRepository();

     RxString session_id =''.obs;
     RxString educational_skills =''.obs;
     RxString friendliness =''.obs;
     RxString ontime_arrival =''.obs;
     RxString overall_rating =''.obs;
 
  @override
 void onInit() {
  super.onInit();
  fetchSession(Get.arguments['classNumber']);
 }
 Future<void> fetchSession(String id) async {
    final BaseResponse sessionnResponse = await _getClassAttendanceRepository.getGetClassAttendance(id);
      if (sessionnResponse.status?.type == 'success') {
   final Map<String,String>  sessionResponseData =
          sessionnResponse.data! as  Map<String,String>;
        final ClassAttendanceModel sessionJson = ClassAttendanceModel.fromJson(sessionResponseData);
        fullSessionRecord=sessionJson;
        sessionNumber.clear();
      //  for (var i = 0; i < sessionJson.count; i++) {
      //     sessionNumber.add('Session - ${element.!}');
      //  }
      }else{
        AppUtils.showFlushBar(
          context: Routes.navigatorKey.currentContext!,
          message: sessionnResponse.status?.message ?? 'Error occured',
        );
      }

  }


  Future<void> submittingReview() async {
    final ReviewSessionSubmitModal reviewSessionSubmitModal=ReviewSessionSubmitModal(
      educationalSkills: double.parse(educational_skills.value).round(),
      friendliness: double.parse(friendliness.value).round(),
      ontimeArrival: double.parse(ontime_arrival.value).round(),
      overallRating: double.parse(overall_rating.value).round(),
      sessionId: int.parse(session_id.value)
    );
    final className=Get.arguments['classNumber'];
    // final BaseResponse sessionnResponse = await _postReviewClassDetailRepository.postReviewSessionClassDetail(className,reviewSessionSubmitModal);
    //   if (sessionnResponse.status?.type == 'success') {
    // AppUtils.showFlushBar(
    //       icon: Icons.done_rounded,
    //       iconColor: Colors.green,
    //       context: Routes.navigatorKey.currentContext!,
    //       message: sessionnResponse.status?.message ?? 'Error occured',
    //     );
    // Future.delayed(const Duration(milliseconds: 1000),()=>  {
    // Get.back(),
    // Get.back(),
    // }
    //                               );
    //   }else{
    //     AppUtils.showFlushBar(
    //       context: Routes.navigatorKey.currentContext!,
    //       message: sessionnResponse.status?.message ?? 'Error occured',
    //     );
    //   }

  }

}
