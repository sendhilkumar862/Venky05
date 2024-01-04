import 'package:get/get.dart';

import '../views/tabs/avtivities_view.dart';
import '../views/tabs/classes_view.dart';
import '../views/tabs/teachers_view.dart';

class HomeViewController extends GetxController{
  RxInt selectedIndex = 0.obs;
  List<Map<String, dynamic>> bottomBarItems = [
    {'title': 'Classes', 'screenName': const ClassesView()},
    {'title': 'Activities', 'screenName': const ActivitiesView()},
    {'title': 'Teachers', 'screenName': const TeachersView()},
  ];


  // ignore: use_setters_to_change_properties
  void onChangeIndex(int index) {
    selectedIndex.value = index;
  }



}
