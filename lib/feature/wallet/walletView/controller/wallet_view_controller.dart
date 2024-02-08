import 'package:get/get.dart';
import 'package:hessah/core/base_response.dart';
import 'package:hessah/feature/wallet/walletView/model/get_wallet_balance_model.dart';

import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../model/get_wallet_balance_list_model.dart';
import '../model/get_wallet_balance_stats_model.dart';
import '../repository/get_wallet_balance_list_repository.dart';
import '../repository/get_wallet_balance_repository.dart';
import '../repository/get_wallet_balance_stats_repository.dart';
import '../view/wallet_view.dart';

class WalletViewController extends GetxController {
  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'Jan', y: 0.541),
    ChartSampleData(x: 'Feb', y: 0.818),
    ChartSampleData(x: 'March', y: 1.51),
    ChartSampleData(x: 'April', y: 0),
    ChartSampleData(x: 'May', y: 0),
    ChartSampleData(x: 'June', y: 0),
  ];
  Rx<GetWalletBalanceModel> walletBalanceDetailModel= GetWalletBalanceModel().obs;
  RxList<GetWalletBalanceListModel> walletBalanceListData = <GetWalletBalanceListModel>[].obs;
  Rx<GetWalletBalanceStatsModel> getWalletBalanceStatsModel=GetWalletBalanceStatsModel().obs;
  final GetWalletBalanceRepository _getWalletBalanceRepository=GetWalletBalanceRepository();
  final GetWalletBalanceListRepository _getWalletBalanceListRepository=GetWalletBalanceListRepository();
  final GetWalletBalanceStataRepository _getWalletBalanceStataRepository=GetWalletBalanceStataRepository();
  String selectedProfile='';
  RxBool isProfileTeacher = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedProfile = LocaleManager.getValue(StorageKeys.profile) ?? '';
    if(selectedProfile == ApplicationConstants.student){
      isProfileTeacher.value=false;
    }
    getData();
  }

  getData()async{
    showLoading();
    await Future.wait(<Future<void>>[
      getWalletBalance(),
      getWalletBalanceList(),
      if(selectedProfile == ApplicationConstants.tutor)
        getStatistics()
      ]);
    hideLoading();
  }


  Future<void> getWalletBalance() async {
    final BaseResponse getWalletBalanceDataDataResponse = await _getWalletBalanceRepository.getWalletDetail();
    if (getWalletBalanceDataDataResponse.status?.type == 'success') {
      final  Map<String, dynamic> walletBalanceData=getWalletBalanceDataDataResponse.data!.item! as Map<String,dynamic>;
      walletBalanceDetailModel.value=GetWalletBalanceModel.fromJson(walletBalanceData);
    }
  }

  Future<void> getWalletBalanceList() async {
    final BaseResponse getWalletBalanceDataDataResponse = await _getWalletBalanceListRepository.getWalletList();
    if (getWalletBalanceDataDataResponse.status?.type == 'success') {
      walletBalanceListData.clear();
      final  List  walletBalanceList=getWalletBalanceDataDataResponse.data!.item! as List;
      for (var element in walletBalanceList) {
        walletBalanceListData.add(GetWalletBalanceListModel.fromJson(element));
      }

    }
  }

  Future<void> getStatistics() async {
    final BaseResponse getWalletBalanceDataResponse = await _getWalletBalanceStataRepository.getWalletStats();
    if (getWalletBalanceDataResponse.status?.type == 'success') {
      final  Map<String,dynamic>  walletBalanceList=getWalletBalanceDataResponse.data!.item! as Map<String,dynamic>;
      getWalletBalanceStatsModel.value=GetWalletBalanceStatsModel.fromJson(walletBalanceList);
    }
  }

}
