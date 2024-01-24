import 'package:get/get.dart';
import '../../../../core/base_response.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/utils/common_function.dart';
import '../model/create_proposal_request_model.dart';
import '../repository/create_proposal_repository.dart';
import '../repository/update_proposal_repository.dart';

class CreateProposalController extends GetxController{
  final CreateProposalRepository _createProposalRepository= CreateProposalRepository();
  final UpdateProposalRepository _updateProposalRepository=UpdateProposalRepository();


  RxString selectedProfile = ''.obs;
  RxString selectedTimes = formatTime(DateTime.now()).obs;
  RxString selectedDate = formatTime(DateTime.now()).obs;
  RxBool isActive = false.obs;



  @override
  void onInit() {
    super.onInit();
    selectedProfile.value =
        LocaleManager.getValue(StorageKeys.profile) ??'';
  }
  Future<void> crateProposal(CreateProposalRequestModel createProposalRequestModel,String id) async {
    showLoading();
    final BaseResponse getProposalsDataResponse = await _createProposalRepository.createClassRepository(createProposalRequestModel, id);
    if (getProposalsDataResponse.status?.type == 'success') {
      // final List proposalListData=getProposalsDataResponse.data!.item! as List;
      // proposalList.clear();
      // for (var element in proposalListData) {
      //   proposalList.add(ProposalModel.fromJson(element));
      // }
    }
    hideLoading();
  }

  Future<void> updateProposal(CreateProposalRequestModel createProposalRequestModel,String id, String classId) async {
    showLoading();
    final BaseResponse getProposalsDataResponse = await _updateProposalRepository.updateClassRepository(createProposalRequestModel,id,classId);
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
