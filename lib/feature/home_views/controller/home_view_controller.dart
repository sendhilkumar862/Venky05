import 'package:get/get.dart';
import '../views/tabs/avtivities_view.dart';
import '../views/tabs/classes_view.dart';
import '../views/tabs/students_view.dart';
import '../views/tabs/teachers_view.dart';

class HomeViewController extends GetxController{
  RxInt selectedIndex = 0.obs;



  RxList<Map<String, dynamic>> bottomBarItemsTeacher = [
    {'title': 'Classes', 'screenName': const ClassesView()},
    {'title': 'Activities', 'screenName': const ActivitiesView()},
    {'title': 'Teachers', 'screenName': const TeachersView()},
  ].obs;
  RxList<Map<String, dynamic>> bottomBarItemsStudent = [
    {'title': 'Classes', 'screenName': const ClassesView()},
    {'title': 'Activities', 'screenName': const ActivitiesView()},
    {'title': 'Students', 'screenName': const StudentsView()},
  ].obs;


  // ignore: use_setters_to_change_properties
  void onChangeIndex(int index) {
    selectedIndex.value = index;
  }



}
