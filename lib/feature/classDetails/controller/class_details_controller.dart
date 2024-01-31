import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/cache/key_value_storeage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/utils/validators.dart';
import '../../proposal/proposol_details/repository/delete_proposal_repository.dart';
import '../modal/class_detail_model.dart';
import '../modal/proposal_model.dart';
import '../repository/get_all_proposal_repository.dart';
import '../repository/get_class_details_repository.dart';


class ClassDetailsController extends GetxController{

  final GetClassDetailRepository _getClassDetailRepository = GetClassDetailRepository();
  final GetProposalAllRepository _getProposalAllRepository=GetProposalAllRepository();
  final DeleteProposalDetailRepository _deleteProposalDetailRepository= DeleteProposalDetailRepository();
  RxString selectedProfile = ''.obs;
  String classId='';
  int startIndex=1;
  ScrollController scrollController=ScrollController();


  @override
  void onInit() {
    super.onInit();
    selectedProfile.value =
        LocaleManager.getValue(StorageKeys.profile) ??
            '';
    classId=Get.arguments['classNumber'];
    fetchData();

  }
  Rx<CameraPosition> kGooglePlex=const CameraPosition( target: LatLng(24.7136,46.6753),
    zoom: 14.4746,).obs;

  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  GoogleMapController? googleMapController;
  //AIzaSyBT8CFEhdKhFteNf6L4NaY3Z3UKFfpRy2w

  // ignore: always_declare_return_types
  fetchData()async{
    showLoading();

    await Future.wait([
      // ignore: avoid_dynamic_calls
      getProposalDetails(classId,startIndex),
    // ignore: avoid_dynamic_calls
    getClassDetails(classId),
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

  Future<void> getClassDetails(String id) async {
    final BaseResponse classDataResponse = await _getClassDetailRepository.getClassDetail(id);
    if (classDataResponse.status?.type == 'success') {
      final classDetailData=classDataResponse.data!.item! as Map<String, dynamic>;
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
      final List proposalListData=getProposalsDataResponse.data!.item! as List;
      if(!isReload) {
        proposalList.clear();
      }

      for (var element in proposalListData) {
        proposalList.add(ProposalModel.fromJson(element));
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

}

