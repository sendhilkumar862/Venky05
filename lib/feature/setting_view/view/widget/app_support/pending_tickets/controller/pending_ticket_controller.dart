
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../../../core/base_response.dart';
import '../../../../../app_support/controller/app_support_controller.dart';
import '../model/gte_chat_ticket_responce_model.dart';
import '../repository/get_chat_ticket_reply_repository.dart';
import '../repository/reply_ticket_chat_repository.dart';
import '../repository/update_ticket_status_repository.dart';


class PendingTicketController extends GetxController {
  final AppSupportController _appSupportController = Get.find();
  final ChatReplyTicketRepository _chatReplyTicketRepository =ChatReplyTicketRepository();
  final ReplyTicketRepository _replyTicketRepository=ReplyTicketRepository();
  final UpdateTicketRepository _updateTicketRepository=UpdateTicketRepository();


  RxList<ChatTicketResponseModel> chatMessage=<ChatTicketResponseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getChatTicket(_appSupportController.getTicketsList[_appSupportController.appSupportDetailIndex].ticketId!);
  }

  Future<void> getChatTicket(
      int id) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse masterDataResponse =
    await _chatReplyTicketRepository.chatReplyTicket(id);
    if (masterDataResponse.status?.type == 'success') {
      chatMessage.clear();
      final List data=masterDataResponse.data!.item! as List;
      for (var element in data) {
        chatMessage.add(ChatTicketResponseModel.fromJson(element));
      }
    }
    EasyLoading.dismiss();
  }


  Future<void> replyChatTicket(
      String msg) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse masterDataResponse =
    await _replyTicketRepository.replyTicket(_appSupportController.getTicketsList[_appSupportController.appSupportDetailIndex].ticketId!,msg);
    if (masterDataResponse.status?.type == 'success') {
      Get.back();
      getChatTicket(_appSupportController.getTicketsList[_appSupportController.appSupportDetailIndex].ticketId!);
    }else{
      EasyLoading.dismiss();
    }

  }
  Future<void> updateTicketStatus(
      int id,String status) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse masterDataResponse =
    await _updateTicketRepository.updateTicket(id,status);
    if (masterDataResponse.status?.type == 'success') {
      getChatTicket(id);
    }else{
      EasyLoading.dismiss();
    }
  }
}
