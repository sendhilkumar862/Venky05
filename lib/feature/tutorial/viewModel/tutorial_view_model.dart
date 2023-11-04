import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../tutorial/view/language_view.dart';

part 'tutorial_view_model.g.dart';

class TutorialViewModel = _TutorialViewModelBase with _$TutorialViewModel;

abstract class _TutorialViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    Future.delayed(
      Duration(seconds: 2),
      () {
        AppRouter.push(LanguageView());
      },
    );
  }

  @observable
  int selectedIndex = -1;

  @observable
  List profileItems = <String>['Teacher', 'Parent/Student'];

  @observable
  List<String> countries = [
    'Oman',
    'Bahrain',
    'Qatar',
    'Saudi Arabia',
    'UEA',
  ];

  @observable
  List<String> countryLogo = [
    ImageConstants.oman,
    ImageConstants.bahrain,
    ImageConstants.qatar,
    ImageConstants.saudiArabia,
    ImageConstants.uae,
  ];

  @observable
  List<String> languages = [
    'English',
    'عربي',
  ];

  @observable
  List<String> languageIcon = [
    ImageConstants.usIcon,
    ImageConstants.saudiArabia,
  ];

  @observable
  List<String> filteredCountries = [];

  @observable
  PageController pageController = PageController();


  @observable
  List onboardingAnimation = [
    ImageConstants.onlineStudy,
    ImageConstants.book,
    ImageConstants.education,
  ];


  @observable
  List onboardingTitle = [
    'Explore Classes',
    'Book Or Create Classes',
    'Start Your Class'
  ];

  @observable
  List onboardingSubtitle = [
    'Explore classes or Teachers and Start your learning plan',
    "Can't find your class? No worries!You can create your needs.",
    'Book classes and start learning. Expand your classes to achieve your goals'
  ];

  @action
  void selectedItems(int index) {
    selectedIndex = index;
  }

  @action
  void selectCountry(int index) {
    print('enterd ${index}');
    selectedIndex = index;
  }

  @action
  void selectLanguage(int index) {
    selectedIndex = index;
  }

  @action
  void filterCountries(String query) {
    filteredCountries = countries
        .where((String country) =>
            country.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
