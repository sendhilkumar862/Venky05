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
    KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    var currentProfile =
        keyValueStorageBase.getCommon(KeyValueStorageService.profile);
    countryCode = keyValueStorageBase
        .getCommon(KeyValueStorageService.countryCodeAndIDD)
        .toString()
        .split(',');
    logs('countryCode--> $countryCode');
  }

  @observable
  Map data = {};

  @observable
  TextEditingController mobileController = TextEditingController();

  @observable
  String selectedCountry = '+1';

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
  };

  @action
  Future<void> sendOTP() async {
    // viewModelContext.loaderOverlay.show();
    Dio dio = Dio();
    final String mobile = '$selectedCountry${mobileController.text}';
    logs('mobile--> $mobile');
    try {
      Map body = <String, dynamic>{'userId': data['userId'], 'mobile': mobile};
      logs('send mobile body--> $body');
      final response = await dio.post(
        'http://167.99.93.83/api/v1/users/mobile/send-otp',
        data: body,
      );
      logs('status Codee --> ${response.statusCode}');
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final EnterMobileModel data = EnterMobileModel.fromJson(response.data);
        logs('status Code --> ${data.status.type}');
        arguments['otp_id'] = response.data['data']['item']['otp_id'];
        AppRouter.pushNamed(Routes.mobileOtpView, args: arguments);
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
    } else if (mobileController.text.length != 10) {
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
    if (mobileValid == 1) {
      AppRouter.pushNamed(Routes.mobileOtpView, args: arguments);
      // sendOTP();
    }
  }

  @observable
  List<CountryCodeModel> countries = [];

  @observable
  List<CountryCodeModel> filteredCountries = [];

  Future<void> fetchData() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    logs('entered Fetch country data');
    Dio dio = Dio();
    try {
      Response response =
          await dio.get('http://167.99.93.83/api/v1/public/countries/idd');
      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final List<dynamic> countriesJson = response.data['data']['items'];
        countries = countriesJson
            .map((json) => CountryCodeModel.fromJson(json))
            .toList();
      }
    } catch (error) {
      EasyLoading.dismiss();

      logs('Error: $error');
    }
  }

  @observable
  int countryIndex = 118;

  @observable
  String selectedItem = '';

  @observable
  int languageIndex = 1;

  @observable
  TextEditingController countryController = TextEditingController();

  @action
  void selectCountry(int index) {
    countryIndex = index;
    selectedCountry = countries[countryIndex].idd_code.toString();
    logs('selected Country-->$countryIndex');
  }

  @action
  void filterCountries(String query, Function setState) {
    filteredCountries = countries
        .where((CountryCodeModel country) =>
            country.name?.toLowerCase().contains(query.toLowerCase()) ??
            false ||
                country.flag_url!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    logs('filteredCountries.toString()--> ${filteredCountries.toString()}');
    setState(() {});
  }
}
