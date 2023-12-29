import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/base/model/base_model.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../model/country_code_model.dart';
import '../model/enter_mobile_model.dart';

class MobileEnterController extends GetxController{

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


  Map data = {};


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
    // viewModelContext.loaderOverlay.show();
    Dio dio = Dio();
    try {
      Map body = <String, String>{
        'userId': data['userId'].toString(),
        'mobile': mobileController.text,
        'countryCode': selectedCountryCode.replaceAll('+', '')
      };

      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/mobile/send-otp',
        data: body,
      );
      if (response.statusCode == 200) {
        hideLoading();
        final BaseResponse<EnterMobileModel> baseResponse =
        BaseResponse<EnterMobileModel>.fromJson(response.data, EnterMobileModel.fromJson);
        if (baseResponse.status.type == 'success') {
          AppUtils.showFlushBar(
              icon: Icons.check_circle_outline_rounded,
              iconColor: Colors.green,
              context: AppRouter.navigatorKey.currentContext!,
              message: baseResponse.status.message);
          arguments['userId'] = data['userId'].toString();
          arguments['otp_id'] = baseResponse.data.item?.otpId ?? '';
          arguments['mobile'] = mobileController.text.trim();
          arguments['countryCode'] = selectedCountryCode.replaceAll('+', '');
          arguments['isMobileUpdation']=false;
          Future.delayed(
              const Duration(milliseconds: 1000),
                  () => AppRouter.pushNamed(Routes.verifyOtpView, args: arguments)
          );
        } else {
          responseError.value = baseResponse.status.message;
        }
      } else {
        hideLoading();
        responseError.value = 'Some Error Occurred';
      }
    } on DioException {
      hideLoading();
    }
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
    Dio dio = Dio();
    try {
      Response response =
      await dio.get('http://167.99.93.83/api/v1/public/countries/idd');

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final List<dynamic> countriesJson = response.data['data']['items'];
        countries.value = countriesJson
            .map((json) => CountryCodeModel.fromJson(json))
            .toList();
        tempList = countriesJson
            .map((json) => CountryCodeModel.fromJson(json))
            .toList();
        selectedCountry = countries.firstWhere(
                (CountryCodeModel element) => element.idd_code == '+965');
      }
    } catch (error) {
      EasyLoading.dismiss();
    }
  }


  CountryCodeModel? selectedCountry;


  String selectedItem = '';


  int languageIndex = 1;


  int countryIndex = 118;


  TextEditingController countryController = TextEditingController();


  void selectCountry(int index) {
    countryIndex = index;
  }


  void filterCountries(String query, Function setState) {
    countryIndex = 0;
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