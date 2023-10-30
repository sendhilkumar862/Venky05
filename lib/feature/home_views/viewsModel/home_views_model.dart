import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../views/tabs/avtivities_view.dart';
import '../views/tabs/classes_view.dart';

part 'home_views_model.g.dart';

class HomeViewsModel = _HomeViewsModelBase with _$HomeViewsModel;

abstract class _HomeViewsModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  int selectedIndex = 0;

  @observable
  List<Map<String, dynamic>> bottomBarItems = [
    {'title': 'Classes', 'screenName': const ClassesView()},
    {'title': 'Activities', 'screenName': const ActivitiesView()},
    {'title': 'Teachers', 'screenName': const SizedBox()},
  ];

  // ignore: use_setters_to_change_properties
  @action
  void onChangeIndex(int index) {
    selectedIndex = index;
    if (kDebugMode) {
      print(index);
    }
  }
}
