import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../config/routes/route.dart';
import '../../../../core/base_response.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../pre_login/personalInfo/repository/get_country_repository.dart';
import '../model/country_code_model.dart';
import '../model/enter_mobile_model.dart';
import '../repository/mobile_otp_repository.dart';
import '../requestModel/mobile_enter_request.dart';

class MobileEnterController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchData();
    KeyValueStorageBase.init();
    final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    countryCode.value = keyValueStorageBase
        .getCommon(List<String>, KeyValueStorageService.countryCodeAndIDD)
        .toString()
        .split(',');
  }

  final GetCountryRepository _countryRepository = GetCountryRepository();
  final MobileOTPSendRepository _mobileOTPSendRepository =
      MobileOTPSendRepository();
  TextEditingController mobileController = TextEditingController();

  RxString selectedCountryCode = '965'.obs;

  RxString mobileErrorText = ''.obs;

  RxString responseError = ''.obs;

  RxInt mobileValid = 2.obs;

  RxList<String> countryCode = <String>[].obs;

  Map<String, dynamic> arguments = {
    'id': '',
    'otp_id': '',
    'isScreen': false,
  };

  Future<void> sendOTP() async {
    showLoading();
    final BaseResponse sendOTPResponse =
        await _mobileOTPSendRepository.mobileOTPSend(
            mobileEnterRequest: MobileEnterRequest(
      mobile: mobileController.text,
      countryCode: selectedCountryCode.replaceAll('+', ''),
      userId: arguments['userId'].toString(),
    ));
    if (sendOTPResponse.status?.type == 'success') {
      final Map<String, dynamic> mobileOTPData =
          sendOTPResponse.data!.item! as Map<String, dynamic>;
      final EnterMobileModel enterMobileModel =
          EnterMobileModel.fromJson(mobileOTPData);
      AppUtils.showFlushBar(
          icon: Icons.check_circle_outline_rounded,
          iconColor: Colors.green,
          context: Routes.navigatorKey.currentContext!,
          message: sendOTPResponse.status?.message ?? '');
      arguments['userId'] = arguments['userId'].toString();
      arguments['otp_id'] = enterMobileModel.otpId ?? '';
      arguments['mobile'] = mobileController.text.trim();
      arguments['countryCode'] = selectedCountryCode.replaceAll('+', '');
      arguments['isMobileUpdation'] = false;
      arguments['isPreLogin'] = true;
      arguments['isScreen'] = false;
      Future.delayed(const Duration(milliseconds: 1000),
          () => Get.toNamed(Routes.verifyOtpView, arguments: arguments));
    } else {
      responseError.value = sendOTPResponse.status?.message ?? '';
      AppUtils.showFlushBar(
        icon: Icons.check_circle_outline_rounded,
        iconColor: Colors.red,
        context: Routes.navigatorKey.currentContext!,
        message: sendOTPResponse.status?.message ?? 'Error occured',
      );
    }
    EasyLoading.dismiss();
  }

  void validateMobile(String value) {
    responseError.value = '';
    if (value.isEmpty) {
      mobileValid.value = 0;
      mobileErrorText.value = 'pleaseEnterMobile'.tr;
    } else if (mobileController.text.length < 8) {
      mobileValid.value = 0;
      mobileErrorText.value = 'kuwaitiNumber'.tr;
    }
    // else if (Regexes.validateRegEx(
    //     mobileController.text, Regexes.contactRegex)) {
    //   mobileValid = 0;
    //   mobileErrorText = 'Kuwaiti number should be start with 4,5,6 and 9';
    //}
    else {
      mobileValid.value = 1;
      mobileErrorText.value = '';
    }
  }

  void onTapMobileSubmit() {
    sendOTP();
  }

  RxList<CountryCodeModel> countries = <CountryCodeModel>[].obs;

  List<CountryCodeModel> tempList = <CountryCodeModel>[];

  List<CountryCodeModel> filteredCountries = <CountryCodeModel>[];

  Future<void> fetchData() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse countryData = await _countryRepository.getCountry();
    if (countryData.status?.type == 'success') {
      final List<dynamic> countriesJson =
          countryData.data!.item as List<dynamic>;
      countries.value =
          countriesJson.map((json) => CountryCodeModel.fromJson(json)).toList();
      tempList =
          countriesJson.map((json) => CountryCodeModel.fromJson(json)).toList();
      selectedCountry = countries
          .firstWhere((CountryCodeModel element) => element.idd_code == '+965');
    }
    EasyLoading.dismiss();
  }

  CountryCodeModel? selectedCountry;

  String selectedItem = '';

  int languageIndex = 1;

  RxInt countryIndex = 118.obs;

  TextEditingController countryController = TextEditingController();

  void selectCountry(int index) {
    countryIndex.value = index;
  }

  void filterCountries(String query, Function setState) {
    countryIndex.value = 0;
    countries.value = countries
        .where((CountryCodeModel country) =>
            country.name?.toLowerCase().contains(query.toLowerCase()) ??
            false ||
                country.flag_url!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (countryController.text.isEmpty) {
      countries.value = tempList;
    }
  }
}
