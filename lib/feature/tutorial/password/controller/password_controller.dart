
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../core/base_response.dart';
import '../../../../mirrorfly/mirrorFlyController/mirrorfly_auth_controller.dart';
import '../../../../product/cache/key_value_storage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/utils/validators.dart';
import '../model/password_model.dart';
import '../model/password_model_request.dart';
import '../model/term_and_condition_model.dart';
import '../repository/get_term_condition_repository.dart';
import '../repository/password_repository.dart';

class PasswordController extends GetxController {

  final MirrorFlyAuthController _mirrorFlyAuthController=Get.put(MirrorFlyAuthController());
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Map arguments = <String, dynamic>{};

  RxBool isActive = false.obs;

  RxList<TermAndConditionModel> termAndConditionModel =
      <TermAndConditionModel>[].obs;

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

  final PasswordRepository _passwordRepository = PasswordRepository();
  final GetTermRepository _getTermRepository = GetTermRepository();

  Future<void> fetchData() async {
    final BaseResponse termsResponse = await _getTermRepository.getTerms();
    if (termsResponse.status?.type == 'success') {
      EasyLoading.dismiss();
      final List termsData = termsResponse.data!.item! as List;
      for (var element in termsData) {
        termAndConditionModel.add(TermAndConditionModel.fromJson(element));
      }
    }
  }

  Future<bool> registerUser() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse registerResponse = await _passwordRepository.register(
      registerRequest: RegisterRequest(
          userId: arguments['userId'].toString(),
          password: passwordController.text,
          isTermsAccepted: isActive.value,
          firstName: arguments['firstName'],
          lastName: arguments['lastName'],
          country: LocaleManager.getValue(
              StorageKeys.countryName),
          hideUserName: arguments['hideUserName'] ?? false),
    );
    if (registerResponse.status?.type == 'success') {
      final Map<String, dynamic> dataResponse =
          registerResponse.data!.item! as Map<String, dynamic>;
      final PasswordModel passwordModel = PasswordModel.fromJson(dataResponse);
      LocaleManager
          .setAuthToken(passwordModel.token.accessToken);
      await _mirrorFlyAuthController.registerAccount(passwordModel.username??'');
      EasyLoading.dismiss();
      return true;
    } else {
      errors.value = registerResponse.status?.message ?? 'Error found';
      EasyLoading.dismiss();
      return false;
    }
  }

  void onTapTermAndCondition() {
    isActive.value = !isActive.value;
    isPassWordCriteria[5] =
        retypePasswordController.text == passwordController.text &&
            passwordController.text.isNotEmpty;

    isButtonActive.value =
        isActive.value && isPassWordCriteria.every((bool element) => element);
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
    isPassWordCriteria[5] =
        value == retypePasswordController.text && value.isNotEmpty;
    isButtonActive.value =
        isActive.value && isPassWordCriteria.every((bool element) => element);
    setState(() {});
  }

  void validateRetypePassword(String value, Function setState) {
    isPassWordCriteria[5] =
        value == passwordController.text && value.isNotEmpty;
    isButtonActive.value =
        isActive.value && isPassWordCriteria.every((bool element) => element);
    logs('isPassWordCriteria--> $isPassWordCriteria');
    setState(() {});
  }

  void setCriteria(int index, bool value) {
    isPassWordCriteria[index] = value;
  }
}
