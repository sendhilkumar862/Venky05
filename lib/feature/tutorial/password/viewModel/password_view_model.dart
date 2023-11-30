import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../model/password_model.dart';
import '../model/term_and_condition_model.dart';

part 'password_view_model.g.dart';

class PasswordViewModel = _PasswordViewModelBase with _$PasswordViewModel;

abstract class _PasswordViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    KeyValueStorageBase.init();
    fetchData();
  }

  @observable
  Map arguments = <String, dynamic>{};

  @observable
  bool isActive = false;

  @observable
  TermAndConditionModel termAndConditionModel = TermAndConditionModel();

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
  ObservableList<bool> isPassWordCriteria =
      ObservableList<bool>.of(List.filled(6, false));

  @observable
  bool isButtonActive = false;

  @observable
  TextEditingController passwordController = TextEditingController();

  @observable
  TextEditingController retypePasswordController = TextEditingController();

  @action
  Future<void> fetchData() async {
    Dio dio = Dio();
    try {
      Response response = await dio
          .get('http://167.99.93.83/api/v1/content/role/student/type/about_us');
      logs('statusCode -- > ${response.statusCode}');
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        termAndConditionModel = TermAndConditionModel.fromJson(response.data);
      } else {
        logs('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      logs('Error: $error');
    }
  }

  @action
  Future<void> registerUser() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final Dio dio = Dio();
    try {
      final Map<String, dynamic> body = {
        'userId': arguments['userId'],
        'password': passwordController.text,
        'isTermsAccepted': isActive,
        'firstName': arguments['firstName'],
        'lastName': arguments['lastName'],
      };

      logs('password set body--> $body');
      final Response response = await dio
          .post('http://167.99.93.83/api/v1/users/register', data: body);

      logs(response.statusCode.toString());
      if (response.statusCode == 200) {
        final PasswordModel passwordModel =
            PasswordModel.fromJson(response.data);
        logs('token--> ${passwordModel.data.item.token}');
        final KeyValueStorageService keyValueStorageService =
            KeyValueStorageService();
        keyValueStorageService
            .setAuthToken(passwordModel.data.item.token.toString());
        EasyLoading.dismiss();
        AppRouter.pushNamed(Routes.HomeScreenRoute);
      } else {
        EasyLoading.dismiss();
        logs('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      EasyLoading.dismiss();
      logs('Error: $error');
    }
  }

  @action
  void onTapTermAndCondition() {
    isActive = !isActive;
    isPassWordCriteria[5] =
        retypePasswordController.text == passwordController.text &&
            passwordController.text.isNotEmpty;

    isButtonActive =
        isActive && isPassWordCriteria.every((bool element) => element);
    logs('isTermActive--> $isActive');
    logs('isPassWordCriteria--> $isPassWordCriteria');
    logs('isButtonActive--> $isButtonActive');
  }

  @action
  void validatePassword(String value, Function setState) {
    isPassWordCriteria[0] = value.length >= 8;
    isPassWordCriteria[1] = Regexes.validate(value, Regexes.digitRegExp);
    isPassWordCriteria[2] = Regexes.validate(value, Regexes.specialCharRegExp);
    isPassWordCriteria[3] = Regexes.validate(value, Regexes.uppercaseRegExp);
    isPassWordCriteria[4] = Regexes.validate(value, Regexes.lowercaseRegExp);
    isPassWordCriteria[5] =
        value == retypePasswordController.text && value.isNotEmpty;
    isButtonActive =
        isActive && isPassWordCriteria.every((bool element) => element);
    setState(() {});
  }

  @action
  void validateRetypePassword(String value, Function setState) {
    isPassWordCriteria[5] =
        value == passwordController.text && value.isNotEmpty;
    isButtonActive =
        isActive && isPassWordCriteria.every((bool element) => element);
    logs('isPassWordCriteria--> $isPassWordCriteria');
    setState(() {});
  }

  @action
  Future<void> onTapSubmitPassword() async {
    if (isButtonActive) {
      registerUser();
    }
  }

  @action
  void setCriteria(int index, bool value) {
    isPassWordCriteria[index] = value;
  }
}
