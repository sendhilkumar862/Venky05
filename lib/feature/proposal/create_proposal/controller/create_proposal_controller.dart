import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/api_end_points.dart';
import '../../../../core/base_response.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/extension/string_extension.dart';
import '../../../../product/utils/common_function.dart';
import '../../../class/class_detail/controller/class_detail_controller.dart';
import '../../../home/controller/home_controller.dart';
import '../../../search/controller/search_controller.dart';
import '../model/create_proposal_request_model.dart';
import '../repository/create_proposal_repository.dart';
import '../repository/update_proposal_repository.dart';

class CreateProposalController extends GetxController{
  final CreateProposalRepository _createProposalRepository= CreateProposalRepository();
  final UpdateProposalRepository _updateProposalRepository=UpdateProposalRepository();
  final ClassDetailController _classDetailController = Get.put(ClassDetailController());
  final SearchClassController _searchController=Get.put(SearchClassController());

  int? duration;
  RxString selectedProfile = ''.obs;
  RxString selectedTimes = formatTime(DateTime.now()).obs;
  RxString selectedDate = formatTime(DateTime.now()).obs;
  RxBool isActive = false.obs;


  TextEditingController dateController = TextEditingController();
  TextEditingController date2Controller = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController classCost = TextEditingController();
  TextEditingController numberOfSession = TextEditingController();
  TextEditingController classDurationController = TextEditingController();
  String proposalId='';

  @override
  void onInit() {
    super.onInit();
    selectedProfile.value =
        LocaleManager.getValue(StorageKeys.profile) ??'';
    // ignore: avoid_dynamic_calls
    if(Get.arguments!=null) {
      proposalId=Get.arguments['proposalId']??'';
    }
  }
  Future<bool> crateProposal() async {
    bool status =false;
    showLoading();
    final BaseResponse getProposalsDataResponse = await _createProposalRepository.createClassRepository(CreateProposalRequestModel(cost:int.parse(classCost.text),sessions:int.parse(numberOfSession.text) ,duration:duration,classTime:dateController.text.toEpoch(),currency: 'KWD'  ), Get.arguments['classNumber']);
    if (getProposalsDataResponse.status?.type == 'success') {
      final HomeController homeController=Get.find();
      homeController.relatedPageIndex=1;
      homeController.historyPageIndex=1;
      homeController.activityPageIndex=1;
      homeController.upcomingPageIndex=1;
      await _searchController.search(SchoolEndpoint.SEARCH_CLASSES,_searchController.searchData);
      await homeController.getData();
     status=true;
    }
    hideLoading();
    return status;
  }

  Future<bool> updateProposal() async {
    bool status =false;
    showLoading();
    final BaseResponse getProposalsDataResponse = await _updateProposalRepository.updateClassRepository(CreateProposalRequestModel(cost:int.parse(classCost.text),sessions:int.parse(numberOfSession.text) ,duration: duration ?? int.parse(classDurationController.text),classTime:dateController.text.toEpoch(),currency: 'KWD'  ), Get.arguments['classNumber'],Get.arguments['proposalId']);
    if (getProposalsDataResponse.status?.type == 'success') {
      final HomeController homeController=Get.find();
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
}
