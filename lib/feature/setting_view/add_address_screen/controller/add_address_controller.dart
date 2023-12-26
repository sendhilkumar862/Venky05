import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/user_location.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../tutorial/mobileEnter/model/country_code_model.dart';
import '../../manage_address/controller/manage_controller.dart';



class AddAddressController extends GetxController{
  TextEditingController shortName = TextEditingController();
  TextEditingController addressFirst = TextEditingController();
  TextEditingController addressSecond = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  // ignore: always_specify_types
  RxList<String> city=<String>[].obs;
   RxString selectedCity=''.obs;
  RxList<Placemark>  address = <Placemark>[].obs ;
  final Completer<GoogleMapController> controllerGoogleMap = Completer();
  Rx<LatLng> position = const LatLng(56.0, 58.0).obs;
  late GoogleMapController googleMapController;
  @override
  void init() {
    // fetchFullData();
    KeyValueStorageBase.init();
    final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    countryCode.value = keyValueStorageBase
        .getCommon(List<String>, KeyValueStorageService.countryCodeAndIDD)
        .toString()
        .split(',');
  }
fetchFullData()async{
  EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
   await Future.wait(<Future<void>>[
     fetchData(),
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


  RxList<String> countryCode = <String>[].obs;


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

  Future<void> fetchData() async {
    Dio dio = Dio();
    try {
      Response response =
      await dio.get('http://167.99.93.83/api/v1/public/countries/idd');
      if (response.statusCode == 200) {
        final List<dynamic> countriesJson = response.data['data']['items'];
        countries.value = countriesJson
            .map((json) => CountryCodeModel.fromJson(json))
            .toList();
        tempList.value = countriesJson
            .map((json) => CountryCodeModel.fromJson(json))
            .toList();
        selectedCountry = countries.firstWhere(
                (CountryCodeModel element) => element.idd_code == '+965');
      }
    } catch (error) {
    }
  }
  Future<Options> _headers() async {
    final KeyValueStorageService keyValueStorageService =
    KeyValueStorageService();
    final String token = await keyValueStorageService.getAuthToken();
    print("get token ${token}");
    return Options(
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
    );
  }
  Future<void> fetchCity() async {
    Dio dio = Dio();
    try {
      Response response =
      await dio.get('http://167.99.93.83/api/v1/public/kw/cities');
      if (response.statusCode == 200) {
        final List<dynamic> cityJson = response.data['data']['items'];
        city.clear();
        for (var element in cityJson) {
          city.add(element['city_name']);
        }
        
      }
    } catch (error) {
    }
  }
  Future<void> addAddress(Map data) async {
    Dio dio = Dio();
    try {
      EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
      Response response =
      await dio.post('http://167.99.93.83/api/v1/users/:userId/address/',
      options:  await _headers(),
      data: data);
      if (response.statusCode == 200) {
        final ManageAddressController manageAddressController=Get.find();
        await manageAddressController.fetchAddressData();
        EasyLoading.dismiss();
        AppRouter.pop();
      }
    } catch (error) {
    }
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