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
  List studentTitle = [
    'Explore Classes',
    'Book Or Create Classes',
    'Start Your Class'
  ];

  @observable
  List teacherTitle = [
    'Submit Proposals',
    'Start Your Class',
    'Set Available Times'
  ];

  @observable
  List studentSubtitle = [
    'Explore classes or Teachers and Start your learning plan',
    "Can't find your class? No worries!You can create your needs.",
    'Book classes and start learning. Expand your classes to achieve your goals'
  ];

  @observable
  List teacherSubtitle = [
    'Explore classes created by students and submit your proposals.',
    "Create classes and start your teaching journey",
    'Set your free times, and give the students the ability to book their favorite times'
  ];
}
