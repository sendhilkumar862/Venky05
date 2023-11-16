import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../product/cache/locale_manager.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/utils/validators.dart';

part 'tutorial_view_model.g.dart';

class TutorialViewModel = _TutorialViewModelBase with _$TutorialViewModel;

abstract class _TutorialViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
   
  }

  @observable
  int selectedIndex = -1;

  @observable
  List profileItems = <String>['Teacher', 'Parent/Student'];


 @observable
  Map data = <String, dynamic>{};

  @observable
  bool isActive = false;

  @action
  void onTapTermAndCondition() {
    isActive = !isActive;
  }

  @observable
  bool isActiveSwitch = false;

  @action
  void onTapSwitch() {
    isActiveSwitch = !isActiveSwitch;
    logs('isActiveSwitch-->${isActiveSwitch}');
  }

  //======== userInfo ========//

  @observable
  TextEditingController firstNameController = TextEditingController();

  @observable
  TextEditingController lastNameController = TextEditingController();

  @observable
  String firstNameErrorText = '';

  @observable
  String lastNameErrorText = '';

  @observable
  int firstNameValid = 2;

  @observable
  int lastNameValid = 2;

  @action
  void validateFirstName(String value) {
    if (value!.isEmpty) {
      firstNameValid = 0;
      firstNameErrorText = 'pleaseEnterFirstName'.tr();
    } else if (Regexes.validateRegEx(
        firstNameController.text, Regexes.nameRegex)) {
      firstNameValid = 0;

      firstNameErrorText = 'enterValidName'.tr();
    } else {
      firstNameValid = 1;
      firstNameErrorText = '';
      logs('error--> $firstNameErrorText');
    }
  }

  @action
  void validateLastName(String value) {
    if (value!.isEmpty) {
      lastNameValid = 0;
      lastNameErrorText = 'Please enter Last Name';
    } else if (Regexes.validateRegEx(
        lastNameController.text, Regexes.nameRegex)) {
      lastNameValid = 0;

      lastNameErrorText = 'enterValidLastname';
    } else {
      lastNameValid = 1;
      lastNameErrorText = '';
      logs('error--> $lastNameErrorText');
    }
  }

  @action
  void onTapSubmitUserInfo() {
    if (firstNameValid == 1 && lastNameValid == 1) {
  final Map<String, dynamic> arguments = <String, dynamic>{
    'userId': data['userId'],
    'firstName': firstNameController.text,
    'lastName': lastNameController.text,
  };
      AppRouter.pushNamed(Routes.passwordView, args: arguments);
    }
  }

  @action
  bool isDisableUserInfoSubmit() {
    if (firstNameValid == 1 && lastNameValid == 1) {
      return false;
    } else {
      return true;
    }
  }

  //========password========//

  @observable
  List<String> passWordCriteria = <String>[
    'minCharacters'.tr(),
    'containNumbers'.tr(),
    'containSpecialChars'.tr(),
    'containUppercase'.tr(),
    'containLowercase'.tr(),
    'matchPasswords'.tr(),
  ];

  // @observable
  // List<bool> isPassWordCriteria = List.filled(6, false);
  @observable
  ObservableList<bool> isPassWordCriteria = ObservableList<bool>.of(List.filled(6, false));


  @observable
  TextEditingController passwordController = TextEditingController();

  @observable
  TextEditingController retypePasswordController = TextEditingController();

  @action
  void validatePassword(String value) {
    if (value.length >= 8) {
      setCriteria(0, true);
      //isPassWordCriteria[0] = true;
    } else {
       setCriteria(0, false);
      // isPassWordCriteria[0] = false;
    }

    if (Regexes.validate(value, Regexes.digitRegExp)) {
      isPassWordCriteria[1] = true;
    } else {
      isPassWordCriteria[1] = false;
    }

    if (Regexes.validate(value, Regexes.specialCharRegExp)) {
      isPassWordCriteria[2] = true;
    } else {
      isPassWordCriteria[2] = false;
    }

    if (Regexes.validate(value, Regexes.uppercaseRegExp)) {
      isPassWordCriteria[3] = true;
    } else {
      isPassWordCriteria[3] = false;
    }

    if (Regexes.validate(value, Regexes.lowercaseRegExp)) {
      isPassWordCriteria[4] = true;
    } else {
      isPassWordCriteria[4] = false;
    }

    logs(isPassWordCriteria.toString());
  }

  @action
  void validateRetypePassword(String value) {
    if (value == passwordController.text) {
      isPassWordCriteria[5] = true;
    } else {
      isPassWordCriteria[5] = false;
    }
  }

  @action
  Future<void> onTapSubmitPassword() async {
     EasyLoading.show(status: 'loading...',  maskType: EasyLoadingMaskType.black);
   final Dio dio = Dio();
    try {
       data['password'] = passwordController.text;
       data['isTermsAccepted'] = true;
      final Response response =
          await dio.post('http://167.99.93.83/api/v1/users/register', data:data);

      print(response.statusCode);
      if (response.statusCode == 200) {
         EasyLoading.dismiss();
        AppRouter.pushNamed(Routes.homeViews);
      } else {
         EasyLoading.dismiss();
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
       EasyLoading.dismiss();
      print('Error: $error');
      // Handle the error
    }
  }

  @action
  void setCriteria(int index, bool value) {
    isPassWordCriteria[index] = value;
  }

}
