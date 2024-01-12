import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../../../core/base_response.dart';
import '../model/create_ticket_request_model.dart';
import '../repository/create_ticket_repository.dart';
import '../repository/master_data_app_support_repository.dart';

class NewTicketController extends GetxController {
  final GetMasterDataAppSupportRepository _getMasterDataAppSupportRepository =
      GetMasterDataAppSupportRepository();
  final CreateTicketRepository _createTicketRepository =
      CreateTicketRepository();

  RxList<String> masterData = <String>[].obs;
  RxList<File> attachments=<File>[].obs;
  bool isSwitch = false;
  int? ticketId;
  bool isReply=false;
  TextEditingController ticketType = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');

  @override
  void onInit() {
    super.onInit();
    getMasterDataList();
  }

  Future<void> getMasterDataList() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse masterDataResponse =
        await _getMasterDataAppSupportRepository.getMasterDataAppSupport();
    if (masterDataResponse.status?.type == 'success') {
      // ignore: always_specify_types
      final List data = masterDataResponse.data!.item! as List;
      for (var element in data) {
        masterData.add(element);
      }
    } else {}
    EasyLoading.dismiss();
  }

  Future<bool> createNewTicket(
      CreateTicketRequestModel createTicketBody) async {
    bool status = false;
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse masterDataResponse =
        await _createTicketRepository.createNewTicket(createTicketBody);
    if (masterDataResponse.status?.type == 'success') {
      final Map<String, dynamic> data=masterDataResponse.data!.item! as Map<String, dynamic>;
      ticketId=data['ticketId'];
      status = true;
    } else {
      status = false;
    }
    EasyLoading.dismiss();
    return status;
  }
}
