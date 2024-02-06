import 'package:get/get.dart';
import 'package:hessah/core/base_response.dart';
import 'package:hessah/feature/wallet/walletView/model/get_wallet_balance_model.dart';

import '../../../../custom/loader/easy_loader.dart';
import '../repository/get_wallet_balance_repository.dart';
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
  RxList<GetWalletBalanceModel> walletBalanceDataList = <GetWalletBalanceModel>[].obs;
  final GetWalletBalanceRepository _getWalletBalanceRepository=GetWalletBalanceRepository();

  RxBool isProfileTeacher = false.obs;
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   getData();
  // }

  getData()async{
    showLoading();
    await Future.wait(<Future<void>>[
       getWalletBalance(),
      ]);
    hideLoading();
  }


  Future<void> getWalletBalance() async {
    showLoading();
    final BaseResponse getWalletBalanceDataDataResponse = await _getWalletBalanceRepository.getWalletDetail();
    if (getWalletBalanceDataDataResponse.status?.type == 'success') {
      final  Map<String, dynamic> walletBalanceData=getWalletBalanceDataDataResponse.data!.item! as Map<String,dynamic>;
      walletBalanceDataList.add(GetWalletBalanceModel.fromJson(walletBalanceData));
    }
    hideLoading();
  }
}
