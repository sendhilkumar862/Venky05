import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/routes/route.dart';
import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/cache/key_value_storeage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/utils/validators.dart';
import '../../home/controller/home_controller.dart';
import '../../proposal/proposol_details/repository/approve_proposal_repository.dart';
import '../../proposal/proposol_details/repository/delete_proposal_repository.dart';
import '../modal/class_detail_model.dart';
import '../modal/initiate_payment_model.dart';
import '../modal/proposal_model.dart';
import '../modal/students_model.dart';
import '../repository/approve_reject_student_repository.dart';
import '../repository/book_class_repository.dart';
import '../repository/cancel_class_repository.dart';
import '../repository/get_all_proposal_repository.dart';
import '../repository/get_all_students_repository.dart';
import '../repository/get_class_details_repository.dart';
import '../repository/initiate_payment.dart';
import '../repository/make_payment_repository.dart';


class ClassDetailsController extends GetxController{

  final GetClassDetailRepository _getClassDetailRepository = GetClassDetailRepository();
  final GetProposalAllRepository _getProposalAllRepository=GetProposalAllRepository();
  final GetStudentsAllRepository _getStudentsAllRepository= GetStudentsAllRepository();
  final DeleteProposalDetailRepository _deleteProposalDetailRepository= DeleteProposalDetailRepository();
  final ApproveProposalRepository _approveProposalRepository = ApproveProposalRepository();
  final BookClassRepository _bookClassRepository=BookClassRepository();
  final CancelClassRepository _cancelClassRepository=CancelClassRepository();
  final ApproveRejectStudentsRepository _approveRejectStudentsRepository=ApproveRejectStudentsRepository();
  final InitiatePaymentRepository _initiatePaymentRepository=InitiatePaymentRepository();
  final MakePaymentRepository _makePaymentRepository=MakePaymentRepository();


  final HomeController homeController=Get.find();

  RxString selectedProfile = ''.obs;
  String classId='';
  int startIndex=1;
  ScrollController scrollController=ScrollController();
  String? proposalId;
  Rx<InitiatePaymentModel> initiatePaymentModel=InitiatePaymentModel().obs;


  @override
  void onInit() {
    super.onInit();
    selectedProfile.value =
        LocaleManager.getValue(StorageKeys.profile) ??
            '';
    // ignore: avoid_dynamic_calls
    if(Get.arguments!=null && Get.arguments['classNumber']!=null){
    // ignore: avoid_dynamic_calls
    classId=Get.arguments['classNumber'];
    fetchData();}

  }


  Rx<CameraPosition> kGooglePlex=const CameraPosition( target: LatLng(24.7136,46.6753),
    zoom: 14.4746,).obs;

  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  GoogleMapController? googleMapController;
  //AIzaSyBT8CFEhdKhFteNf6L4NaY3Z3UKFfpRy2w

  // ignore: always_declare_return_types
  fetchData()async{
    showLoading();

    await Future.wait(<Future<void>>[
      // ignore: avoid_dynamic_calls
      getProposalDetails(classId,startIndex),
    // ignore: avoid_dynamic_calls
    getClassDetails(classId),
      getStudentAllAtDetails(classId,startIndex)
    ]);
    hideLoading();
  }
  Future<void> fetchMap(LatLng latLong) async {
    try {
      kGooglePlex.value = CameraPosition(
        target: latLong,
        zoom: 14.4746,
      );
      googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: kGooglePlex.value.target, zoom: 5)));
    } on SocketException catch (e) {
      logs('Catch SocketException in getContactUsInfo --> ${e.message}');
    }
  }

   Rx<ClassDetailsModel> classData =  ClassDetailsModel().obs;
   RxList<ProposalModel> proposalList = <ProposalModel>[].obs;
   RxList<StudentsModel> studentsList = <StudentsModel>[].obs;

  Future<void> getClassDetails(String id) async {
    final BaseResponse classDataResponse = await _getClassDetailRepository.getClassDetail(id);
    if (classDataResponse.status?.type == 'success') {
      final Map<String, dynamic> classDetailData=classDataResponse.data!.item! as Map<String, dynamic>;
       classData.value = ClassDetailsModel.fromJson(classDetailData);
      await fetchMap(LatLng(double.parse(classData.value.location?.lat??'0.0'),double.parse(classData.value.location?.long??'0.0')));
    }
  }
  Future<void> getProposalDetails(String id, int startIndex,{bool isReload=false}) async {
    if(isReload){
      showLoading();
    }
    final BaseResponse getProposalsDataResponse = await _getProposalAllRepository.getProposalAll(id,startIndex);
    if (getProposalsDataResponse.status?.type == 'success') {
      if(getProposalsDataResponse.data!.item!=null){
      // ignore: always_specify_types
      final List proposalListData=getProposalsDataResponse.data!.item! as List;
      if(!isReload) {
        proposalList.clear();
      }

      // ignore: always_specify_types
      for (final element in proposalListData) {
        proposalList.add(ProposalModel.fromJson(element));
      }}
    }
    if(isReload){
      hideLoading();
    }
  }

  Future<void> getStudentAllAtDetails(String id, int startIndex,{bool isReload=false}) async {
    if(isReload){
      showLoading();
    }
    final BaseResponse getStudentsDataResponse = await _getStudentsAllRepository.getStudentsAll(id,startIndex);
    if (getStudentsDataResponse.status?.type == 'success') {
      if(getStudentsDataResponse.data!.item!=null){
        // ignore: always_specify_types
        final List proposalListData=getStudentsDataResponse.data!.item! as List;
        if(!isReload) {
          studentsList.clear();
        }

        // ignore: always_specify_types
        for (final element in proposalListData) {
          studentsList.add(StudentsModel.fromJson(element));
        }}
    }
    if(isReload){
      hideLoading();
    }
  }

  Future<void> deleteProposalDetails(String id, ) async {
    showLoading();
    final BaseResponse getProposalsDataResponse = await _deleteProposalDetailRepository.deleteProposalDetail(id,classId);
    if (getProposalsDataResponse.status?.type == 'success') {
      await getClassDetails(classId);
    }
    hideLoading();
  }
  Future<bool> bookClassDetail(Map<String,dynamic> data ) async {
    bool status=false;
    showLoading();
    final BaseResponse getProposalsDataResponse = await _bookClassRepository.bookClassRepositoryRepository(classId,data);
    if (getProposalsDataResponse.status?.type == 'success') {
      await getClassDetails(classId);
      homeController.relatedPageIndex=1;
      homeController.historyPageIndex=1;
      homeController.activityPageIndex=1;
      homeController.upcomingPageIndex=1;
      await homeController.getData();
      status=true;
    }
    hideLoading();
    return status;
  }
  Future<bool> approveProposal(String id, ) async {
    bool status=false;
    showLoading();
    final BaseResponse getProposalsDataResponse = await _approveProposalRepository.approveProposal(id,classId);
    if (getProposalsDataResponse.status?.type == 'success') {
      await getClassDetails(classId);
      homeController.relatedPageIndex=1;
      homeController.historyPageIndex=1;
      homeController.activityPageIndex=1;
      homeController.upcomingPageIndex=1;
      await homeController.getData();
      status=true;
    }
    hideLoading();
    return status;
  }
  Future<bool> cancelClass( ) async {
    bool status=false;
    showLoading();
    final BaseResponse getProposalsDataResponse = await _cancelClassRepository.cancelClassRepositoryRepository(classId);
    if (getProposalsDataResponse.status?.type == 'success') {
      final HomeController homeController=Get.find();
      await getClassDetails(classId);
      homeController.relatedPageIndex=1;
      homeController.historyPageIndex=1;
      homeController.activityPageIndex=1;
      homeController.upcomingPageIndex=1;
      await homeController.getData();
      status=true;
    }
    hideLoading();
    return status;
  }

  Future<bool> initiatePayment( ) async {
    bool status = false;
    showLoading();
    final BaseResponse initiatePaymentDataResponse = await _initiatePaymentRepository
        .initiatePaymentRepository(classId);
    if (initiatePaymentDataResponse.status?.type == 'success') {
      final Map<String,dynamic> initiateData=initiatePaymentDataResponse.data!.item! as Map<String,dynamic>;
      initiatePaymentModel.value=InitiatePaymentModel.fromJson(initiateData);
      status = true;
    }else{
      AppUtils.showFlushBar(
        context: Routes.navigatorKey.currentContext!,
        message: initiatePaymentDataResponse.status?.message ?? 'Error occured',
      );
    }
    hideLoading();
    return status;
  }

  Future<bool> makePayment( String paymentId) async {
    bool status = false;
    showLoading();
    final BaseResponse getProposalsDataResponse = await _makePaymentRepository
        .makePaymentRepository(classId,paymentId);
    if (getProposalsDataResponse.status?.type == 'success') {
      status = true;
    }
    hideLoading();
    return status;
  }

    Future<bool> approveRejectStudents(String id,Map <String,dynamic> approveRejectDetails) async {
    bool status=false;
    showLoading();
    final BaseResponse approveRejectDataResponse = await _approveRejectStudentsRepository.approveRejectStudent(id,approveRejectDetails);
    if (approveRejectDataResponse.status?.type == 'success') {
      await getClassDetails(classId);
      homeController.relatedPageIndex=1;
      homeController.historyPageIndex=1;
      homeController.activityPageIndex=1;
      homeController.upcomingPageIndex=1;
      await homeController.getData();
      status=true;
    }
    hideLoading();
    Get.back();
    return status;
  }

}
