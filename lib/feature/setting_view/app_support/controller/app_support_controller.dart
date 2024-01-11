
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../core/base_response.dart';
import '../Model/get_tickets_request_model.dart';
import '../Model/get_tickets_response_model.dart';
import '../repository/app_support_repository.dart';


class AppSupportController extends GetxController{

  TextEditingController searchTicketController = TextEditingController();
  @override
  void onInit() {
    getTickets();
  }

  final GetTicketsRepository _getTicketsRepository = GetTicketsRepository();

  RxList<GetTicketsResponseModel> getTicketsList = <GetTicketsResponseModel>[].obs;

  Future<void> getTickets() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse getTicketResponse = await _getTicketsRepository.getTickets(GetTicketsRequestModel());
    if (getTicketResponse.status?.type == 'success') {
      final List ticketsListData=getTicketResponse.data!.item! as List;
      getTicketsList.clear();
      for (var element in ticketsListData) {
        getTicketsList.add(GetTicketsResponseModel.fromJson(element));
      }
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
    }
  }
}
