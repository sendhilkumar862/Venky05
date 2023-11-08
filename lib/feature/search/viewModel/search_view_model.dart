import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../view/search_view.dart';
part 'search_view_model.g.dart';


class SearchViewModel = _SearchViewModelBase with _$SearchViewModel;

abstract class _SearchViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  int selectedIndex = 0;

  @observable
  List<Map<String, dynamic>> bottomBarItems = [
    {'title': 'Classes', 'screenName': const SearchView()},
    {'title': 'Activities', 'screenName': const SizedBox()},
    {'title': 'Teachers', 'screenName': const SizedBox()},
  ];
  @action
  void onChangeIndex(int index) {
    selectedIndex = index;
    if (kDebugMode) {
      print(index);
    }
  }
}
