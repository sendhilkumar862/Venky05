
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../core/base_response.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/extension/string_extension.dart';
import '../../../../product/utils/common_function.dart';
import '../../../setting_view/manage_address/controller/manage_controller.dart';
import '../model/create_class_request_model.dart';
import '../model/master_data_model.dart';
import '../repository/create_class_repository.dart';
import '../repository/gat_master_data_repository.dart';


class ClassDetailController extends GetxController{
  final CreateClassRepository _createClassRepository=CreateClassRepository();
  final GetMasterDataRepository _getMasterDataRepository=GetMasterDataRepository();
  final ManageAddressController _manageAddressController = Get.put(ManageAddressController());
  @override
  void onInit() {
  selectedProfile.value =
      LocaleManager.getValue(StorageKeys.profile) ??
  '';
  getMasterDataClass();
}

  RxInt? selectedIndex =200.obs;
  RxString selectedProfile = ''.obs;

  RxString selectedTimes = formatTime(DateTime.now()).obs;


  RxString selectedDate = formatTime(DateTime.now()).obs;

  RxBool isActive = false.obs;
  int? isSelected;
  int? isCurriculumSelected;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController class2DateController = TextEditingController();
  TextEditingController classCost = TextEditingController();
  TextEditingController numberOfSession = TextEditingController();
  TextEditingController participators2 = TextEditingController(text: '');
  TextEditingController participators3 = TextEditingController(text: '');
  TextEditingController participators4 = TextEditingController(text: '');
  TextEditingController participators5 = TextEditingController(text: '');
  TextEditingController classDurationController = TextEditingController();
  TextEditingController classSummaryController = TextEditingController(text: '');
  final EmailValidator emailValidator = EmailValidator(
      errorText: 'Enter a valid email address (e.g., name@example.com)');
  SfRangeValues sliderValue = const SfRangeValues(40, 40);
  bool isDisable = true;
  String dateAndTime = '';
  String classDuration = '';
  DateTime time = DateTime(2016, 5, 10, 22, 35);
  double lowerValue = 20.0;
  double upperValue = 80.0;
   Rx<MasterDataModel> masterData=MasterDataModel().obs;
  bool isChecked = false;
   List<OtherParticipants> otherParticipants=<OtherParticipants>[];
  int isGradeSelect = -1;
  int isSchoolSelect = -1;
  int isSubjectSelect = -1;
  String? classId;


  Future<String?> createClass() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    if(participators2.text!=''){
      otherParticipants.add(OtherParticipants(email:participators2.text ));
    }
    if(participators3.text!=''){
      otherParticipants.add(OtherParticipants(email:participators3.text ));
    }
    if(participators4.text!=''){
      otherParticipants.add(OtherParticipants(email:participators4.text ));
    }
    if(participators5.text!=''){
      otherParticipants.add(OtherParticipants(email:participators5.text ));
    }
    final BaseResponse classResponse = await _createClassRepository.createClassRepository(CreateClassRequestModel(grade: masterData.value.grades![isGradeSelect],school: masterData.value.schoolTypes![isSchoolSelect],subject:  masterData.value.subjects![isSubjectSelect],summary:classSummaryController.text,minParticipants:lowerValue.toInt(),
    maxParticipants: upperValue.toInt(),cost:int.parse(classCost.text),sessions: int.parse(numberOfSession.text),classTime:dateController.text.toEpoch(),currency: 'KWD',duration:masterData.value.sessionDurations![isSelected!],location:_manageAddressController.address[selectedIndex!.value].id,otherParticipants: otherParticipants ,curriculum: masterData.value.curriculum![isCurriculumSelected!] ));
    if (classResponse.status?.type == 'success') {
      final Map<String, dynamic> classData= classResponse.data!.item! as Map<String, dynamic>;
      EasyLoading.dismiss();
      return classData['classId'];
    } else {
      EasyLoading.dismiss();
      return null;
    }
  }
  Future<void> getMasterDataClass() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse masterDataResponse = await _getMasterDataRepository.getMasterDataDetail();
    if (masterDataResponse.status?.type == 'success') {
      var data=masterDataResponse.data!.item! as Map<String,dynamic>;
      masterData.value=MasterDataModel.fromJson(data);
    } else {
    }
    EasyLoading.dismiss();
  }
  bool onTapSwitch() {
    isActive.value = !isActive.value;
    return isActive.value;
  }

}
