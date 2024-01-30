import 'package:get/get.dart';
import '../../../../core/base_response.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../proposol_details/repository/get_proposal_detail_repository.dart';
import '../model/proposal_detail_model.dart';
import '../view/proposals_by.dart';

class ProposalsByController extends GetxController{

  RxString selectedProfile = ''.obs;


  RxBool isActive = false.obs;
  final GetProposalDetailRepository _getProposalDetailRepository = GetProposalDetailRepository();
    Rx<ProposalDetailModel> proposalDetailModel= ProposalDetailModel().obs;
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
