
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hessah/core/base_response.dart';

import '../../../config/routes/route.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../classDetails/repository/get_review_class_details_repository.dart';
import '../../classDetails/repository/post_review_class_details_repository.dart';
import '../model/review_rating_model.dart';
import '../model/review_session_submit_model.dart';



class RatingController extends GetxController{

     RxList<String> sessionNumber=<String>[].obs;
     RxList<ReviewSessionModal> fullSessionRecord=<ReviewSessionModal>[].obs;
     final GetReviewClassDetailRepository _getReviewClassDetailRepository=GetReviewClassDetailRepository();
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
    final BaseResponse sessionnResponse = await _getReviewClassDetailRepository.getReviewSessionClassDetail(id);
      if (sessionnResponse.status?.type == 'success') {
   final List<dynamic> sessionResponseData =
          sessionnResponse.data!.item! as List<dynamic>;
        final List<ReviewSessionModal> sessionJson = sessionResponseData.map((value)=>ReviewSessionModal.fromJson(value)).toList();
        fullSessionRecord.value=sessionJson;
        sessionNumber.clear();
        for (final ReviewSessionModal element in sessionJson) {
          sessionNumber.add('Session - ${element.sessionNo!}');
        }
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
    final BaseResponse sessionnResponse = await _postReviewClassDetailRepository.postReviewSessionClassDetail(className,reviewSessionSubmitModal);
      if (sessionnResponse.status?.type == 'success') {
    AppUtils.showFlushBar(
          icon: Icons.done_rounded,
          iconColor: Colors.green,
          context: Routes.navigatorKey.currentContext!,
          message: sessionnResponse.status?.message ?? 'Error occured',
        );
    Future.delayed(const Duration(milliseconds: 1000),()=>  {
    Get.back(),
    Get.back(),
    }
                                  );
      }else{
        AppUtils.showFlushBar(
          context: Routes.navigatorKey.currentContext!,
          message: sessionnResponse.status?.message ?? 'Error occured',
        );
      }

  }

}
