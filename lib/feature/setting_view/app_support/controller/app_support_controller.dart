
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/base_response.dart';
import '../Model/get_tickets_request_model.dart';
import '../Model/get_tickets_response_model.dart';
import '../repository/app_support_repository.dart';


class AppSupportController extends GetxController{
  List<Filters> filterList=<Filters>[];
  RxBool isInitial=true.obs;
  bool initialCount=true;
  List<String> shortByList = <String>[
    'New to Old',
    'Old to New',
  ];

  List<String> filterByList = <String>[
    'New',
    'InProgress',
    'Solved',
  ];
  int appSupportDetailIndex=-1;
  int? shortBy=-1;
  List<String> filterBy = <String>[];

  TextEditingController searchTicketController = TextEditingController(text: '');
  @override
  void onInit() {
    super.onInit();
    getTickets();
  }

  final GetTicketsRepository _getTicketsRepository = GetTicketsRepository();

  RxList<GetTicketsResponseModel> getTicketsList = <GetTicketsResponseModel>[].obs;

  Future<void> getTickets() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    filterList.clear();
    for (var element in filterBy) {
      filterList.add(Filters(value:element));
    }

    final GetTicketsRequestModel tickets=GetTicketsRequestModel(pagination:Pagination(sort: Sort(direction:shortBy==0?'asc':'desc')) , searchTerm: searchTicketController.text ,filters:filterList );
    final BaseResponse getTicketResponse = await _getTicketsRepository.getTickets(tickets);
    if (getTicketResponse.status?.type == 'success') {
      final List ticketsListData=getTicketResponse.data!.item! as List;
      getTicketsList.clear();
      if(ticketsListData.isEmpty && isInitial.value){
        if(initialCount) {
          isInitial.value=false;
        }
      }
      for (var element in ticketsListData) {
        getTicketsList.add(GetTicketsResponseModel.fromJson(element));
      }
      initialCount=false;
    }
    EasyLoading.dismiss();
  }
}
