

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;
import 'package:hessah/product/network/local/key_value_storage_base.dart';

import '../../../../product/base/model/base_model.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../model/password_model.dart';
import '../model/term_and_condition_model.dart';

class PasswordController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    KeyValueStorageBase.init();
    fetchData();
  }

  Map arguments = <String, dynamic>{};


  RxBool isActive = false.obs;


  Rx<TermAndConditionModel> termAndConditionModel = TermAndConditionModel().obs;

  //========password========//


  List<String> passWordCriteria = <String>[
    'minCharacters'.tr,
    'containNumbers'.tr,
    'containSpecialChars'.tr,
    'containUppercase'.tr,
    'containLowercase'.tr,
    'matchPasswords'.tr,
  ];

  // @observable
  // List<bool> isPassWordCriteria = List.filled(6, false);

 RxList<bool> isPassWordCriteria = RxList<bool>.of(List.filled(6, false));


  RxBool isButtonActive = false.obs;


  RxBool isPasswordVisible = false.obs;


  RxString errors = ''.obs;
  RxBool isRetypePasswordVisible = false.obs;


  TextEditingController passwordController = TextEditingController();


  TextEditingController retypePasswordController = TextEditingController();


  Future<void> fetchData() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get('http://167.99.93.83/api/v1/content/role/common/type/Terms_Conditions');
      logs('statusCode -- > ${response.statusCode}');
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        termAndConditionModel.value = TermAndConditionModel.fromJson(response.data);
      } else {
        logs('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      logs('Error: $error');
    }
  }

  Future<bool> registerUser() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final Dio dio = Dio();
    try {
      final Map<String, dynamic> body = {
        'userId': arguments['userId'].toString(),
        'password': passwordController.text,
        'isTermsAccepted': isActive.value,
        'firstName': arguments['firstName'],
        'lastName': arguments['lastName'],
        'hideUserName': arguments['hideUserName'] ?? false,
      };

      logs('password set body--> $body');
      final Response response = await dio.post('http://167.99.93.83/api/v1/users/register', data: body);
      //logs(response.statusCode.toString());
      if (response.statusCode == 200) {
        final BaseResponse<PasswordModel> baseResponse =
        BaseResponse<PasswordModel>.fromJson(response.data as Map<String, dynamic>, PasswordModel.fromJson);
        logs('token--> ${baseResponse.data.item?.token.accessToken}');
        final KeyValueStorageService keyValueStorageService = KeyValueStorageService();
        keyValueStorageService.setAuthToken(baseResponse.data.item?.token.accessToken.toString() ?? '');
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.dismiss();
        final BaseResponse<PasswordModel> baseResponse =
        BaseResponse<PasswordModel>.fromJson(response.data as Map<String, dynamic>, PasswordModel.fromJson);
        errors.value = baseResponse.status.message;
        logs('Failed to load data: ${response.statusCode}');
        return false;
      }
    } on DioException catch (error) {
      {
        // passwordModel = PasswordModel.fromJson(error.response!.data);
        final BaseResponse<PasswordModel> baseResponse =
        BaseResponse<PasswordModel>.fromJson(error.response!.data as Map<String, dynamic>, PasswordModel.fromJson);
        errors.value = baseResponse.status.message;
        EasyLoading.dismiss();
        logs('Error: $error');
        return false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      return false;
    }
  }


  void onTapTermAndCondition() {
    isActive.value = !isActive.value;
    isPassWordCriteria[5] =
        retypePasswordController.text == passwordController.text && passwordController.text.isNotEmpty;

    isButtonActive.value = isActive.value && isPassWordCriteria.every((bool element) => element);
    logs('isTermActive--> $isActive');
    logs('isPassWordCriteria--> $isPassWordCriteria');
    logs('isButtonActive--> $isButtonActive');
  }


  void validatePassword(String value, Function setState) {
    isPassWordCriteria[0] = value.length >= 8;
    isPassWordCriteria[1] = Regexes.validate(value, Regexes.digitRegExp);
    isPassWordCriteria[2] = Regexes.validate(value, Regexes.specialCharRegExp);
    isPassWordCriteria[3] = Regexes.validate(value, Regexes.uppercaseRegExp);
    isPassWordCriteria[4] = Regexes.validate(value, Regexes.lowercaseRegExp);
    isPassWordCriteria[5] = value == retypePasswordController.text && value.isNotEmpty;
    isButtonActive.value = isActive.value && isPassWordCriteria.every((bool element) => element);
    setState(() {});
  }


  void validateRetypePassword(String value, Function setState) {
    isPassWordCriteria[5] = value == passwordController.text && value.isNotEmpty;
    isButtonActive.value = isActive.value && isPassWordCriteria.every((bool element) => element);
    logs('isPassWordCriteria--> $isPassWordCriteria');
    setState(() {});
  }


  void setCriteria(int index, bool value) {
    isPassWordCriteria[index] = value;
  }
}
