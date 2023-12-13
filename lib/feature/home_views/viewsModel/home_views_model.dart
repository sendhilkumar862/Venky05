import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/base/model/base_model.dart';
import '../../../product/utils/validators.dart';
import '../model/home_views_dashboard_details.dart';
import '../views/tabs/avtivities_view.dart';
import '../views/tabs/classes_view.dart';
import '../views/tabs/teachers_view.dart';

part 'home_views_model.g.dart';

class HomeViewsModel = _HomeViewsModelBase with _$HomeViewsModel;

abstract class _HomeViewsModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
   fetchDashBoardDetails();
  }

  @observable
  int selectedIndex = 0;

  @observable
  List<Map<String, dynamic>> bottomBarItems = [
    {'title': 'Classes', 'screenName': const ClassesView()},
    {'title': 'Activities', 'screenName': const ActivitiesView()},
    {'title': 'Teachers', 'screenName': const TeachersView()},
  ];

  // ignore: use_setters_to_change_properties
  @action
  void onChangeIndex(int index) {
    selectedIndex = index;
    if (kDebugMode) {
      print(index);
    }
  }

  Future<void> fetchDashBoardDetails() async {
    showLoading();
    logs('Getting Dashboard Details');
    final Dio dio = Dio();
    try {
      Response response = await dio.get('http://167.99.93.83/api/v1/users/dashboard/details');

      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final BaseResponse<DashBoardDetailsModel> baseResponse =
        BaseResponse<DashBoardDetailsModel>.fromJson(response.data as Map<String, dynamic>, DashBoardDetailsModel.fromJson);
        var value=baseResponse.data.item!;

        logs('Status code--> ${baseResponse.status.type}');
        // countries = baseResponse.data.items ?? <Country>[];
        // temp = baseResponse.data.items ?? <Country>[];
      }
    } catch (error) {
      EasyLoading.dismiss();
      logs('Error: $error');
    }
  }
}
