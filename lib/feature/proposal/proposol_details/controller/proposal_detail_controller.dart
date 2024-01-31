import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/base_response.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/utils/validators.dart';
import '../../proposals_by/view/proposals_by.dart';
import '../repository/delete_proposal_repository.dart';
import '../repository/get_proposal_detail_repository.dart';

class ProposalDetailController extends GetxController{

 final GetProposalDetailRepository _getProposalDetailRepository = GetProposalDetailRepository();
 final DeleteProposalDetailRepository _deleteProposalDetailRepository= DeleteProposalDetailRepository();

  @override
  void onInit() {
    super.onInit();
    fetchMap();
    getProfile();
  }


  RxString selectedProfile = ''.obs;


  CameraPosition? kGooglePlex;


  Completer<GoogleMapController> mapController =
  Completer<GoogleMapController>();

  List<Header> dataList = [
    Header(heading: 'Original Class Details', headingData: [
      HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
      HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
      HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
      HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
      HeaderData(
          icon: 'assets/icons/read_book_icon.png',
          title: '5.000 KWD / Session'),
    ]),
    Header(heading: 'Proposal Details', headingData: [
      HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
      HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
      HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
      HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
      HeaderData(
          icon: 'assets/icons/read_book_icon.png',
          title: '5.000 KWD / Session'),
    ]),
  ];


  Future<void> fetchMap() async {
    try {
      kGooglePlex = CameraPosition(
        target: LatLng(
          double.parse('24.7136'),
          double.parse('46.6753'),
        ),
        zoom: 14.4746,
      );
    } on SocketException catch (e) {
      logs('Catch SocketException in getContactUsInfo --> ${e.message}');
    }
  }


  void getProfile() {
    selectedProfile.value =
        LocaleManager.getValue(StorageKeys.profile) ?? ApplicationConstants.student;
    getProposalDetails(Get.arguments['proposalId'],Get.arguments['classId']);
  }
  Future<void> getProposalDetails(String classId,String id ) async {
    showLoading();
    final BaseResponse getProposalsDataResponse = await _getProposalDetailRepository.getProposalDetail(id,classId);
    if (getProposalsDataResponse.status?.type == 'success') {
      // final List proposalListData=getProposalsDataResponse.data!.item! as List;
      // proposalList.clear();
      // for (var element in proposalListData) {
      //   proposalList.add(ProposalModel.fromJson(element));
      // }
    }
    hideLoading();
  }
 Future<void> deleteProposalDetails(String id, String classId) async {
   showLoading();
   final BaseResponse getProposalsDataResponse = await _deleteProposalDetailRepository.deleteProposalDetail(id,classId);
   if (getProposalsDataResponse.status?.type == 'success') {
     // final List proposalListData=getProposalsDataResponse.data!.item! as List;
     // proposalList.clear();
     // for (var element in proposalListData) {
     //   proposalList.add(ProposalModel.fromJson(element));
     // }
   }
   hideLoading();
 }
}
