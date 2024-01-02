import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/base_response.dart';
import '../../../../core/user_location.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../tutorial/mobileEnter/model/country_code_model.dart';
import '../../manage_address/controller/manage_controller.dart';
import '../Model/request_address_model.dart';
import '../repository/add_address_repository.dart';
import '../repository/get_city_repository.dart';



class AddAddressController extends GetxController{
  TextEditingController shortName = TextEditingController();
  TextEditingController addressFirst = TextEditingController();
  TextEditingController addressSecond = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final AddAddressRepository _addAddressRepository=AddAddressRepository();
  final GetCityRepository _getCityRepository=GetCityRepository();
  // ignore: always_specify_types
  RxList<String> city=<String>[].obs;
   RxString selectedCity=''.obs;
  RxList<Placemark>  address = <Placemark>[].obs ;
  final Completer<GoogleMapController> controllerGoogleMap = Completer();
  Rx<LatLng> position = const LatLng(56.0, 58.0).obs;
  late GoogleMapController googleMapController;
  bool isTap=false;
  @override
  void init() {
    // fetchFullData();
  }
fetchFullData()async{
  EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
   await Future.wait(<Future<void>>[
      fetchCity(),
      getPositionAddress()
    ]);
  EasyLoading.dismiss();

}

  RxMap data = {}.obs;
  RxBool isSwitchExperience = false.obs;


  getPositionAddress() async {
    try{
      await LocationService().requestLocPermission();
    }catch(e){
    }
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position.value, zoom: 5)));


  }

  getAddress(LatLng lac)async{
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    try{
      await LocationService().getAddressFromLatLng(lac);
    }catch(e){
    }
    EasyLoading.dismiss();
  }
  RxString selectedCountryCode = '965'.obs;


  RxString mobileErrorText = ''.obs;


  RxString responseError = ''.obs;


  RxInt mobileValid = 2.obs;

  Map<String, dynamic> arguments = {
    'id': '',
    'otp_id': '',
    'isScreen': false,
  };

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





  RxList<CountryCodeModel> countries = <CountryCodeModel>[].obs;


  RxList<CountryCodeModel> tempList = <CountryCodeModel>[].obs;


  RxList<CountryCodeModel> filteredCountries = <CountryCodeModel>[].obs;

  Future<void> fetchCity() async {
    final BaseResponse cityResponse = await _getCityRepository.getCity();
      if (cityResponse.status?.type == 'success') {
        final List<dynamic> cityJson = cityResponse.data?.item as List<dynamic>;
        city.clear();
        for (var element in cityJson) {
          city.add(element['city_name']);
        }
        
      }else{
        AppUtils.showFlushBar(
          context: AppRouter.navigatorKey.currentContext!,
          message: cityResponse.status?.message ?? 'Error occured',
        );
      }

  }

  Future<void> addAddress( AddressRequestModel userAddress) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse addAddressResponse = await _addAddressRepository.addAddressRepository(userAddress);
    if (addAddressResponse.status?.type == 'success') {
      final ManageAddressController manageAddressController=Get.find();
      await manageAddressController.fetchAddressData();
      AppRouter.pop();
    } else {
      AppUtils.showFlushBar(
        context: AppRouter.navigatorKey.currentContext!,
        message: addAddressResponse.status?.message ?? 'Error occured',
      );
    }
    EasyLoading.dismiss();
  }

  CountryCodeModel? selectedCountry;


  RxString selectedItem = ''.obs;


  RxInt languageIndex = 1.obs;


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
      countries = tempList;
    }
    setState(() {});
  }
}