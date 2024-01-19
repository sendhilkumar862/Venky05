import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/cache/key_value_storeage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/utils/validators.dart';
import '../modal/class_detail_model.dart';
import '../modal/proposal_model.dart';
import '../repository/get_class_details_repository.dart';
import '../repository/get_proposal_detail_repository.dart';

class ClassDetailsController extends GetxController{

  final GetClassDetailRepository _getClassDetailRepository = GetClassDetailRepository();
  final GetProposalDetailRepository _getProposalDetailRepository=GetProposalDetailRepository();
  RxString selectedProfile = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedProfile.value =
        LocaleManager.getValue(StorageKeys.profile) ??
            '';

    fetchData();

  }
  Rx<CameraPosition> kGooglePlex=const CameraPosition( target: LatLng(24.7136,46.6753),
    zoom: 14.4746,).obs;

  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  late GoogleMapController googleMapController;
  //AIzaSyBT8CFEhdKhFteNf6L4NaY3Z3UKFfpRy2w

  // ignore: always_declare_return_types
  fetchData()async{
    showLoading();
    await Future.wait([
      // ignore: avoid_dynamic_calls
      getProposalDetails(Get.arguments['classNumber']),
    // ignore: avoid_dynamic_calls
    getClassDetails(Get.arguments['classNumber']),
    ]);
    hideLoading();
  }
  Future<void> fetchMap(LatLng latlong) async {
    try {
      kGooglePlex.value = CameraPosition(
        target: latlong,
        zoom: 14.4746,
      );
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
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
      final  List classDetailData=classDataResponse.data!.item! as List;
       classData.value = ClassDetailsModel.fromJson(classDetailData[0]);
      await fetchMap(LatLng(double.parse(classData.value.location?.lat??'0.0'),double.parse(classData.value.location?.long??'0.0')));
    }
  }
  Future<void> getProposalDetails(String id) async {
    final BaseResponse getProposalsDataResponse = await _getProposalDetailRepository.getProposalDetail(id);
    if (getProposalsDataResponse.status?.type == 'success') {
      // final List proposalListData=getProposalsDataResponse.data!.item! as List;
      // proposalList.clear();
      // for (var element in proposalListData) {
      //   proposalList.add(ProposalModel.fromJson(element));
      // }
    }
  }
}

