import 'package:get/get.dart';
import '../../../../core/base_response.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/cache/key_value_storage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../proposol_details/repository/get_proposal_detail_repository.dart';
import '../model/proposal_detail_model.dart';
import '../view/proposals_by.dart';

class ProposalsByController extends GetxController{

  RxString selectedProfile = ''.obs;


  RxBool isActive = false.obs;
  final GetProposalDetailRepository _getProposalDetailRepository = GetProposalDetailRepository();
    Rx<ProposalDetailModel> proposalDetailModel= ProposalDetailModel().obs;


  @override
  void onInit() {
    super.onInit();
    selectedProfile.value =
        LocaleManager.getValue(StorageKeys.profile) ??'';
  }
  Future<void> getProposalDetails(String classId,String id ) async {
    showLoading();
    final BaseResponse getProposalsDataResponse = await _getProposalDetailRepository.getProposalDetail(id,classId);
    if (getProposalsDataResponse.status?.type == 'success') {
      final  Map<String, dynamic> proposalListData=getProposalsDataResponse.data!.item! as Map<String,dynamic>;
      proposalDetailModel.value=ProposalDetailModel.fromJson(proposalListData);
    }
    hideLoading();
  }
}
