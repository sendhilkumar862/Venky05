
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' ;

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/base_response.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../home/controller/home_controller.dart';
import '../../mobileEnter/controller/mobile_enter_controller.dart';
import '../model/country_code_model.dart';
import '../repository/mobile_enter_repository.dart';



class ChangeMobileNumberController extends GetxController{
  RxBool isAccountPasswordVisible = false.obs;
  RxBool isWrongOldPassword = false.obs;
  TextEditingController accountPasswordController = TextEditingController();
  final HomeController _homeController=Get.find();
  RxString selectedCity=''.obs;
  final MobileEnterController _mobileEnterController =Get.put(MobileEnterController());

  final ChangeMobileNumberRepository _changeMobileNumberRepository=ChangeMobileNumberRepository();
  @override
  void onInit() {
    super.onInit();
    KeyValueStorageBase.init();
    final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    countryCode.value = keyValueStorageBase
        .getCommon(List<String>, KeyValueStorageService.countryCodeAndIDD)
        .toString()
        .split(',');
  }


  RxMap data = {}.obs;


  TextEditingController mobileController = TextEditingController();


  RxString selectedCountryCode = '965'.obs;


  RxString mobileErrorText = ''.obs;


  RxString responseError = ''.obs;


  RxInt mobileValid = 2.obs;

  RxInt accountPasswordValid = 2.obs;


  RxList<String> countryCode = <String>[].obs;


  Map<String, dynamic> arguments = {
    'userId': '',
    'otp_id': '',
    'isScreen': false,
    'changeMobileNumberScreen':'change'
  };



  Future<void> sendOTP() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse changeNumberResponse = await _changeMobileNumberRepository.changeMobileNumber(userId:_homeController.homeData.value?.userId??"",mobileNumber: int.parse(mobileController.text ),countryCode:int.parse(_mobileEnterController.countries[_mobileEnterController.countryIndex.value].idd_code!), password: accountPasswordController.text );
    if (changeNumberResponse.status?.type == 'success') {
      arguments['userId']=_homeController.homeData.value?.userId??'';
      Map otpId=changeNumberResponse.data!.item! as Map;
      arguments['otp_id']=otpId['otpId'];
      arguments['mobile']=mobileController.text;
      arguments['isMobileUpdation']=true;
      AppRouter.pushNamed(Routes.verifyOtpView,args: arguments);
    }
    else
    {
      mobileErrorText.value=changeNumberResponse.status?.message??'';
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

   bool isButtonDisable(){
    if(accountPasswordValid.value ==1 && mobileValid.value == 1) {
      return false;
    }
    return true;
   }

   void validatePassword(String value) {
    if (value.isEmpty) {
      accountPasswordValid.value = 0;
    }
    else {
      accountPasswordValid.value = 1;
    }
  }


  void onTapMobileSubmit() {
    sendOTP();
  }


  RxList<CountryCodeModel> countries = <CountryCodeModel>[].obs;


  List<CountryCodeModel> tempList = <CountryCodeModel>[];


  List<CountryCodeModel> filteredCountries = <CountryCodeModel>[];


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