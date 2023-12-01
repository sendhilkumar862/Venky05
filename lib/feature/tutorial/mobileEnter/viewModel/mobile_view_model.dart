import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../model/country_code_model.dart';
import '../model/enter_mobile_model.dart';

part 'mobile_view_model.g.dart';

class MobileViewModel = _MobileViewModelBase with _$MobileViewModel;

abstract class _MobileViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    fetchData();
    KeyValueStorageBase.init();
    final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    // var currentProfile =
    //     keyValueStorageBase.getCommon(KeyValueStorageService.profile);
    countryCode =
        keyValueStorageBase.getCommon(List<String>, KeyValueStorageService.countryCodeAndIDD).toString().split(',');
    logs('countryCode--> $countryCode');
  }

  @observable
  Map data = {};

  @observable
  TextEditingController mobileController = TextEditingController();

  @observable
  String selectedCountryCode = '965';

  @observable
  String mobileErrorText = '';

  @observable
  int mobileValid = 2;

  @observable
  List<String> countryCode = <String>[];

  @observable
  Map<String, dynamic> arguments = {
    'id': '',
    'otp_id': '',
    'isScreen': false,
  };

  @action
  Future<void> sendOTP() async {
    // viewModelContext.loaderOverlay.show();
    Dio dio = Dio();
    final String mobile = '$selectedCountryCode${mobileController.text}';
    logs('mobile--> $mobile');
    try {
      Map body = <String, dynamic>{
        'userId': data['userId'],
        'mobile': mobileController.text,
        'countryCode': selectedCountryCode.replaceAll('+', '')
      };
      logs('send mobile body--> $body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/mobile/send-otp',
        data: body,
      );
      logs('status Codee --> ${response.statusCode}');
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final EnterMobileModel enterMobileModel = EnterMobileModel.fromJson(response.data);
        logs('status Code --> ${enterMobileModel.status.type}');
        arguments['userId'] = data['userId'].toString();
        arguments['otp_id'] = enterMobileModel.data.item.otpId.toString();
        AppRouter.pushNamed(Routes.verifyOtpView, args: arguments);
      } else {
        EasyLoading.dismiss();
        logs('error not response');
      }
    } catch (error) {
      logs('error');
    }
  }

  @action
  void validateMobile(String value) {
    if (value!.isEmpty) {
      mobileValid = 0;
      mobileErrorText = 'pleaseEnterMobile'.tr();
    } else if (mobileController.text.length < 8) {
      mobileValid = 0;
      mobileErrorText = 'kuwaitiNumber'.tr();
    }
    // else if (Regexes.validateRegEx(
    //     mobileController.text, Regexes.contactRegex)) {
    //   mobileValid = 0;
    //   mobileErrorText = 'Kuwaiti number should be start with 4,5,6 and 9';
    //}
    else {
      mobileValid = 1;
      mobileErrorText = '';
      logs('error--> $mobileErrorText');
    }
  }

  @action
  void onTapMobileSubmit() {
    //if (mobileValid == 1) {
    if (true) {
      AppRouter.pushNamed(Routes.verifyOtpView, args: arguments);
      sendOTP();
    }
  }

  @observable
  List<CountryCodeModel> countries = <CountryCodeModel>[];

  @observable
  List<CountryCodeModel> tempList = <CountryCodeModel>[];

  @observable
  List<CountryCodeModel> filteredCountries = <CountryCodeModel>[];

  Future<void> fetchData() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    logs('entered Fetch country data');
    Dio dio = Dio();
    try {
      Response response = await dio.get('http://167.99.93.83/api/v1/public/countries/idd');
      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final List<dynamic> countriesJson = response.data['data']['items'];
        countries = countriesJson.map((json) => CountryCodeModel.fromJson(json)).toList();
        tempList = countriesJson.map((json) => CountryCodeModel.fromJson(json)).toList();
        selectedCountry = countries.firstWhere((CountryCodeModel element) => element.idd_code == '+965');
      }
    } catch (error) {
      EasyLoading.dismiss();

      logs('Error: $error');
    }
  }

  @observable
  CountryCodeModel? selectedCountry;

  @observable
  String selectedItem = '';

  @observable
  int languageIndex = 1;

  @observable
  int countryIndex = 118;

  @observable
  TextEditingController countryController = TextEditingController();

  @action
  void selectCountry(int index) {
    countryIndex = index;
    logs('selected Country-->$countryIndex');
  }

  @action
  void filterCountries(String query, Function setState) {
    countryIndex = 0;
    countries = countries
        .where((CountryCodeModel country) =>
            country.name?.toLowerCase().contains(query.toLowerCase()) ??
            false || country.flag_url!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (countryController.text.isEmpty) {
      countries = tempList;
    }
    setState(() {});
  }
}
