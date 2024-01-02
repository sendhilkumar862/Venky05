
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/base_response.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../home/controller/home_controller.dart';
import '../../changeMobileNumber/model/country_code_model.dart';
import '../../mobileEnter/controller/mobile_enter_controller.dart';
import '../repository/add_mobile_repository.dart';



class AddMobileNumberController extends GetxController{

  final HomeController _homeController=Get.find();

  final AddMobileNumberRepository _addMobileNumberRepository=AddMobileNumberRepository();
 final MobileEnterController _mobileEnterController =Get.put(MobileEnterController());

  @override
  void onInit() {
    super.onInit();
    countryCode.value =  LocaleManager.getValue( StorageKeys.countryCodeAndIDD).toString().split(',');
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
    'id': '',
    'otp_id': '',
    'isScreen': false,
    'changeMobileNumberScreen':'add'
  };



  Future<void> sendOTP() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse changeNumberResponse = await _addMobileNumberRepository.addMobileNumber(userId:_homeController.homeData.value!.userId!.toString(),mobileNumber: int.parse(mobileController.text ),countryCode:int.parse(_mobileEnterController.countries[_mobileEnterController.countryIndex.value].idd_code!), );
    if (changeNumberResponse.status?.type == 'success') {
      arguments['userId']=_homeController.homeData.value?.userId??'';
      Map otpId=changeNumberResponse.data!.item! as Map;
      arguments['otp_id']=otpId['otpId'];
      arguments['mobile']=mobileController.text;
      arguments['isMobileUpdation']=true;
      AppRouter.pushNamed(Routes.verifyOtpView,args: arguments);
    }
    else
    {mobileErrorText.value=changeNumberResponse.status?.message??'';}
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