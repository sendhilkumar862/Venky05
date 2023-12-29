import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/search_view.dart';

class SearchController extends GetxController {
  RxInt selectedIndex = 0.obs;

  List<Map<String, dynamic>> bottomBarItems = [
    {'title': 'Classes', 'screenName': const SearchView()},
    {'title': 'Activities', 'screenName': const SizedBox()},
    {'title': 'Teachers', 'screenName': const SizedBox()},
  ];

  void onChangeIndex(int index) {
    selectedIndex.value = index;
    if (kDebugMode) {
      print(index);
    }
  }
}
