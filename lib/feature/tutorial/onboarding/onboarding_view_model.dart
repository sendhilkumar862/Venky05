import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../product/cache/locale_manager.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../tutorial/view/language_view.dart';

part 'onboarding_view_model.g.dart';

class OnboardingViewModel = _OnboardingViewModelBase with _$OnboardingViewModel;

abstract class _OnboardingViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    currentProfile = LocaleManager.instance.getIntValue(LocaleManager.profile);
    print('current profile--> $currentProfile');
  }

  @observable
  int currentProfile = 0;

  @observable
  PageController pageController = PageController();

  @observable
  List studentAnimation = [
    ImageConstants.onlineStudy,
    ImageConstants.book,
    ImageConstants.education,
  ];

  @observable
  List teacherAnimation = [
    ImageConstants.onlineStudy,
    ImageConstants.education,
    ImageConstants.timetable,
  ];

  @observable
  List studentTitle = ['exploreApp'.tr(), 'book'.tr(), 'startClass'.tr()];

  @observable
  List teacherTitle = ['submitProposalTeacher'.tr(), 'startClass'.tr(), 'setAvailableTimes'];

  @observable
  List studentSubtitle = ['explore'.tr(), 'cantFind'.tr(), 'bookClasses'.tr()];

  @observable
  List teacherSubtitle = [
    'exploreClasses'.tr(),
    "createAndClasses".tr(),
    'setAndGive'.tr()
  ];
}
