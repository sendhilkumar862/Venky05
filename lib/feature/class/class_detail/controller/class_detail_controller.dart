
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
import '../../../pre_login/teachingInfo/controller/teaching_info_controller.dart';
import '../../../setting_view/manage_address/controller/manage_controller.dart';
import '../model/create_class_request_model.dart';
import '../repository/create_class_repository.dart';


class ClassDetailController extends GetxController{
  final CreateClassRepository _createClassRepository=CreateClassRepository();
  final ManageAddressController _manageAddressController = Get.put(ManageAddressController());
  final TeachingInfoController _teachingInfoController= Get.put(TeachingInfoController());
  @override
  void onInit() {
  selectedProfile.value =
      LocaleManager.getValue(StorageKeys.profile) ??
  '';
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
  TextEditingController participators2 = TextEditingController();
  TextEditingController participators3 = TextEditingController();
  TextEditingController participators4 = TextEditingController();
  TextEditingController participators5 = TextEditingController();
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

  bool isChecked = false;
  List<String> dateAndTimeList = <String>[
    'abs',
    'hello',
    'guys',
  ];
  List<String> classDurationList = <String>[
    '1 Hours',
    '1 Hour - 15 Minutes',
    '1 Hour - 30 Minutes',
    '1 Hour - 45 Minutes',
    '2 Hours',
    '2 Hour - 15 Minutes',
    '2 Hour - 30 Minutes',
    '2 Hour - 45 Minutes',
    '3 Hour',
  ];
  List<String> grade = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    'University',
  ];
  List<String> school = <String>['Public', 'Private'];
  List<String> subject = <String>[
    'Arabic',
    'Math',
    'Science',
    'Islamic',
    'physics',
    'Chemistry',
    'English',
    'French',
    'Deutsch',
    'Arts'
  ];
  int isGradeSelect = -1;
  int isSchoolSelect = -1;
  int isSubjectSelect = -1;

  void setSchoolValue(List<String> value) {
    school = value;
  }
  Future<bool> createClass() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse signInResponse = await _createClassRepository.createClassRepository(CreateClassRequestModel(grade:grade[isGradeSelect],school:school[isSchoolSelect],subject: subject[isSubjectSelect],summary:classSummaryController.text,minParticipants:lowerValue.toInt(),
    maxParticipants: upperValue.toInt(),cost:int.parse(classCost.text),sessions: int.parse(numberOfSession.text),classTime:dateController.text.toEpoch(),currency: 'KWD',duration:isSelected!.toString().toSecond(),location:_manageAddressController.address[selectedIndex!.value].id,otherParticipants: [] ,curriculum: _teachingInfoController.curriculumTypeList[isCurriculumSelected!] ));
    if (signInResponse.status?.type == 'success') {
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.dismiss();
      return false;
    }
  }

  bool onTapSwitch() {
    isActive.value = !isActive.value;
    return isActive.value;
  }

}
