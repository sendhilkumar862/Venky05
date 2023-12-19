import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../product/constants/image/image_constants.dart';

class OnBoadingController extends GetxController {
  RxString currentProfile = ''.obs;

  PageController pageController = PageController();

  List studentAnimation = <String>[
    ImageConstants.onlineStudy,
    ImageConstants.book,
    ImageConstants.education,
  ];

  List teacherAnimation = <String>[
    ImageConstants.onlineStudy,
    ImageConstants.education,
    ImageConstants.timetable,
  ];

  List studentTitle = <String>['exploreClasses'.tr, 'book'.tr, 'startClass'.tr];

  List teacherTitle = [
    'submitProposalTeacher'.tr,
    'startClass'.tr,
    'setAvailableTimes'.tr
  ];

  List studentSubtitle = <String>[
    'explore'.tr,
    'cantFind'.tr,
    'bookClasses'.tr
  ];

  List teacherSubtitle = <String>[
    'exploreClassesCreated'.tr,
    'createAndClasses'.tr,
    'setAndGive'.tr
  ];
}
