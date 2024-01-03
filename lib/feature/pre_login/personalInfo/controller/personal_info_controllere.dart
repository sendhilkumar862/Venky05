
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../config/routes/route.dart';

import '../../../../core/base_response.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../home/controller/home_controller.dart';
import '../../../tutorial/language/model/country_model.dart';
import '../model/personal_info_request_model.dart';
import '../repository/get_country_repository.dart';
import '../repository/personalInfo_update_repository.dart';
import '../repository/upload_document_repository.dart';

class PersonalInfoController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  RxString selectedItem = ''.obs;


   Rx<Country> selectedCountry = Country().obs;
   List<String> civilIds=[];


  RxBool isSwitch = false.obs;


  RxInt genderListIndex = 0.obs;


  TextEditingController countryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  final PersonalUpdateRepository _personalUpdateRepository =PersonalUpdateRepository();
  final GetCountryRepository _countryRepository =GetCountryRepository();
  final UploadDocRepository _uploadDocRepository =UploadDocRepository();
  void selectItem(String item) {
    selectedItem.value = item;
  }


  void selectCountry(Country country) {
    selectedCountry.value = country;
  }


  RxList<Country> countries = <Country>[].obs;


  RxList<Country> temp = <Country>[].obs;


  List isLanguageSelected = List.filled(2, false);


  RxList<String> languageList = <String>[].obs;


  TextEditingController languageController = TextEditingController();


  List<String> languages = <String>[
    'English',
    'عربي',
  ];


  void selectLanguage(int index,) {
    isLanguageSelected[index] = !isLanguageSelected[index];

    if (isLanguageSelected[index]) {
      languageList.add(languages[index]);
    } else {
      languageList.remove(languages[index]);
    }

    languageController.text = languageList.toString().replaceAll('[', '').replaceAll(']', '');
  }


  List<String> languageIcon = <String>[
    ImageConstants.usIconNew,
    ImageConstants.saudiArabiaNew,
  ];

  Future<void> fetchData() async {
    showLoading();
    final BaseResponse countryData = await _countryRepository.getCountry();
    if (countryData.status?.type == 'success') {
      // ignore: always_specify_types
      final List countryList=countryData.data!.item! as List;
      countries.clear();
      temp.clear();
      for (var element in countryList) {
        countries.add(Country.fromJson(element));
        temp.add(Country.fromJson(element));
      }
      }
    EasyLoading.dismiss();
    }


  void filterCountries(String query, Function setState) {
    countries.value = countries
        .where((Country country) =>
    country.name?.toLowerCase().contains(query.toLowerCase()) ??
        false || country.flag_url!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (countryController.text.isEmpty) {
      countries = temp;
    }
    setState(() {});
  }
  Future<void> personalInformationUpdate() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse personalUpdate = await _personalUpdateRepository.updateCountry(PersonalInfoRequest(nationality:selectedCountry.value.name,languages: languageList.value,dob:dateController.text,
      dobIsPublic: isSwitch.value,gender: genderListIndex.value==0?"male":"female",civilIds:civilIds ));
    if (personalUpdate.status?.type == 'success') {
      civilIds.clear();
      final HomeController _home = Get.find();
      _home.fetchData();
      EasyLoading.dismiss();
      Get.toNamed(Routes.teachingInfo);
    }else {
        EasyLoading.dismiss();
      }
  }

  Future<void> uploadDocument(String path) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse signInResponse = await _uploadDocRepository.uploadDocument(path);
    if (signInResponse.status?.type == 'success') {
      var data =signInResponse.data?.item as Map<String, dynamic>;
      civilIds.add(data['id']);
    } else {

    }
    EasyLoading.dismiss();
  }
}
