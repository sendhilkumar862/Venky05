import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../product/constants/image/image_constants.dart';

class OnBoadingController extends GetxController {
  RxString currentProfile = ''.obs;

  PageController pageController = PageController();

  List<String> studentAnimation = <String>[
    ImageConstants.onlineStudy,
    ImageConstants.book,
    ImageConstants.education,
  ];

  List<String> teacherAnimation = <String>[
    ImageConstants.onlineStudy,
    ImageConstants.education,
    ImageConstants.timetable,
  ];

  List<String> studentTitle = <String>['exploreClasses'.tr, 'book'.tr, 'startClass'.tr];

  List<String> teacherTitle = [
    'submitProposalTeacher'.tr,
    'startClass'.tr,
    'setAvailableTimes'.tr
  ];

  List<String> studentSubtitle = <String>[
    'explore'.tr,
    'cantFind'.tr,
    'bookClasses'.tr
  ];

  List<String> teacherSubtitle = <String>[
    'exploreClassesCreated'.tr,
    'createAndClasses'.tr,
    'setAndGive'.tr
  ];
}
