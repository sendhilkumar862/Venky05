
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:hessah/core/base_response.dart';

import '../../../config/routes/route.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../classDetails/repository/get_class_attendance_repository.dart';
import '../../classDetails/repository/get_review_class_details_repository.dart';
import '../../classDetails/repository/post_class_attendance_repository.dart';
import '../../classDetails/repository/post_review_class_details_repository.dart';
import '../model/class_attendance_model.dart';
import '../model/review_session_submit_model.dart';



class ConfirmAttendanceController extends GetxController{

     RxList<String> sessionNumber=<String>[].obs;
     RxInt sessionNo=0.obs;
    ClassAttendanceModel fullSessionRecord=ClassAttendanceModel();
    RxList<Attendance> sessionClassAttandanceList=<Attendance>[].obs;
     final GetClassAttendanceRepository _getClassAttendanceRepository=GetClassAttendanceRepository();
     final PostClassAttendanceRepository _postClassAttendanceRepository=PostClassAttendanceRepository();

    Attendance _attendance=Attendance();

 
  @override
 void onInit() {
  super.onInit();
  fetchSession(Get.arguments['classNumber']);
 }
 Future<void> fetchSession(String id) async {
    final BaseResponse sessionnResponse = await _getClassAttendanceRepository.getGetClassAttendance(id);
      if (sessionnResponse.status?.type == 'success') {
   final Data  sessionResponseData =
          sessionnResponse.data!;
          
        final ClassAttendanceModel sessionJson = ClassAttendanceModel.fromJson(objectToMap(sessionResponseData));
        fullSessionRecord=sessionJson;
        sessionNumber.clear();
       for (var i = 1; i <= int.parse('${sessionResponseData.count}'); i++) {
          sessionNumber.add('Session - $i');
       }
      }else{
        AppUtils.showFlushBar(
          context: Routes.navigatorKey.currentContext!,
          message: sessionnResponse.status?.message ?? 'Error occured',
        );
      }

  }

  Map<String, dynamic> objectToMap(dynamic obj) {
  final Map<String, dynamic> resultMap = {};
  resultMap['items'] = obj.item;
  resultMap['count'] = obj.count;
  return resultMap;
}



Future<void> onSelectSession(String? value)async{
  var filterData=fullSessionRecord.items?.where((element) => element.sessionNo.toString()==value?.replaceAll('Session - ', "")).toList();
  sessionClassAttandanceList.value=filterData!.first.attendance!;
  sessionNo.value=filterData.first.sessionId!;
}


  Future<void> makeItAsAttended(bool isAttended,Attendance value) async {
   final ClassAttendancePostModel classAttendancePostModel=ClassAttendancePostModel(
      isSelectAll: false,
      type: isAttended?"yes":"no",
      sessions: ["${sessionNo.value}"],
      users: ["${value.userId}"]
    );
    final className=Get.arguments['classNumber'];
    final BaseResponse sessionnResponse = await _postClassAttendanceRepository.postClassAttendance(className,classAttendancePostModel);
      if (sessionnResponse.status?.type == 'success') {
     AppUtils.showFlushBar(
          icon: Icons.done_rounded,
          iconColor: Colors.green,
          context: Routes.navigatorKey.currentContext!,
          message: sessionnResponse.status?.message ?? 'Error occured',
        );
    fetchSession(className).whenComplete(() {
       ;var filterData=fullSessionRecord.items?.where((element) => element.sessionId.toString()==sessionNo.value.toString()).toList();
    print("cheeck iinnn ${filterData!.first.attendance}");
     sessionClassAttandanceList.value=filterData!.first.attendance!;
    });
   
      }else{
        AppUtils.showFlushBar(
          context: Routes.navigatorKey.currentContext!,
          message: sessionnResponse.status?.message ?? 'Error occured',
        );
      }

  }

}
