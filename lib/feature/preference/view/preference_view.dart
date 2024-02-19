
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../config/routes/route.dart';

import '../../../custom/app_button/app_button.dart';
import '../../../custom/choice/choice.dart';
import '../../../custom/divider/divider.dart';
import '../../../product/cache/key_value_storage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/colors_extension.dart';
import '../../home/controller/home_controller.dart';
import '../controller/preference_controller.dart';
import '../model/preference_model.dart';


class PreferenceView extends StatefulWidget {
  const PreferenceView({super.key});

  @override
  State<PreferenceView> createState() => _PreferenceViewState();
}

class _PreferenceViewState extends State<PreferenceView>
    with TickerProviderStateMixin {
  final PreferenceController _preferenceController =Get.put(PreferenceController());
  List<String> choicesValue = <String>[];
  late final AnimationController _controller;
  String selectedProfile = '';
/*  Set<String> selectedGrade = <String>{};
  Set<String> selectedSchool = <String>{};*/
  int? value = 0;
  int isSelect = 0;
/*  Set<int> selectedSchoolIndices = <int>{};
  Set<int> selectedCurriculumIndices = <int>{};
  Set<int> selectedSubjectIndices = <int>{};*/


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Obx(()
           {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: SafeArea(
                              child: Text(
                                'customization'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0, color: Colors.transparent),
                                borderRadius:
                                BorderRadius.circular(20), //<-- SEE HERE
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              tileColor: HexColor('#F0F5FF'),
                              leading: Lottie.asset(
                                ImageConstants.animPreference,
                                controller: _controller,
                                fit: BoxFit.fill,
                                onLoaded: (LottieComposition composition) {
                                  _controller.duration = composition.duration;
                                  _controller.repeat();
                                },
                              ),
                              title: Text(
                                'msgCustomizationNow'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                              subtitle: Text('msgCustomization'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.appDarkBlack
                                          .withOpacity(0.5),
                                      fontSize: 12)),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'grade'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'selectMore'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: ConstrainedBox(
                              constraints:
                              const BoxConstraints(maxWidth: 500),
                              child: InlineChoice<Grade>(
                                clearable: true,
                                loading: _preferenceController.grade.isEmpty ??
                                    true,
                                value: _preferenceController.grade ??
                                    <Grade>[],
                                //onChanged: setChoicesValue,
                                itemCount:
                                _preferenceController.grade.length ?? 0,
                                itemBuilder:
                                    (ChoiceController<Grade> selection,
                                    int index) {
                                  return ChoiceChip(
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: _preferenceController
                                                .selectedGrade
                                                .contains(
                                                _preferenceController
                                                    .grade[index]
                                                    .value ??
                                                    emptyString)
                                                ? AppColors.trans
                                                : AppColors.appBorderColor)),
                                    backgroundColor: AppColors.trans,
                                    selected: _preferenceController
                                        .selectedGrade
                                        .contains(_preferenceController
                                        .grade[index].value ??
                                        emptyString),
                                    onSelected: (bool isSelected) {
                                      setState(() {
                                        if (isSelected) {
                                          _preferenceController.selectedGrade
                                              .add(_preferenceController
                                              .grade[index].value ??
                                              emptyString);
                                        } else {
                                          _preferenceController.selectedGrade
                                              .remove(_preferenceController
                                              .grade[index].value ??
                                              emptyString);
                                        }
                                      });
                                    },
                                    showCheckmark: false,
                                    label: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(_preferenceController
                                          .grade[index].value ??
                                          emptyString),
                                    ),
                                    selectedColor: AppColors
                                        .appBlue, // Change this to your desired color
                                    labelStyle: TextStyle(
                                      color: _preferenceController.selectedGrade
                                          .contains(_preferenceController
                                          .grade[index].value ??
                                          emptyString)
                                          ? AppColors.white
                                          : AppColors
                                          .black, // Change text color
                                    ),
                                  );
                                },
                                listBuilder: ChoiceList.createWrapped(
                                    width: MediaQuery.of(context).size.width),
                              ),
                            ),
                          ),
                          AppDivider(),
                          if (_preferenceController.selectedGrade.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'school'.tr,
                                    style: const TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      'optional'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_preferenceController.selectedGrade.isNotEmpty)
                            InlineChoice<Grade>(
                              clearable: true,
                              loading:
                              _preferenceController.schoolType.isEmpty ??
                                  true,
                              value: _preferenceController.schoolType ??
                                  <Grade>[],
                              itemCount:
                              _preferenceController.schoolType.length ?? 0,
                              itemBuilder:
                                  (ChoiceController<Grade> selection,
                                  int index) {
                                return ChoiceChip(
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: _preferenceController
                                              .selectedSchoolIndices
                                              .contains(
                                              _preferenceController
                                                  .schoolType[
                                              index]
                                                  .value ??
                                                  emptyString)
                                              ? AppColors.trans
                                              : AppColors.appBorderColor)),
                                  backgroundColor: AppColors.trans,
                                  selected: _preferenceController
                                      .selectedSchoolIndices
                                      .contains(_preferenceController
                                      .schoolType[index].value ??
                                      emptyString),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _preferenceController
                                          .selectedCurriculumIndices.clear();
                                      _preferenceController
                                          .selectedSubjectIndices.clear();
                                      if (selected) {
                                        _preferenceController
                                            .selectedSchoolIndices
                                            .add(_preferenceController
                                            .schoolType[index]
                                            .value ??
                                            emptyString); // Add to the set for multi-selection
                                      } else {
                                        _preferenceController
                                            .selectedSchoolIndices
                                            .remove(_preferenceController
                                            .schoolType[index]
                                            .value ??
                                            emptyString); // Remove from the set
                                      }
                                    });
                                  },
                                  showCheckmark: false,
                                  label: Text(_preferenceController
                                      .schoolType?[index].value ??
                                      emptyString),
                                  selectedColor: AppColors
                                      .appBlue, // Change this to your desired color
                                  labelStyle: TextStyle(
                                    color: _preferenceController
                                        .selectedSchoolIndices
                                        .contains(_preferenceController
                                        .schoolType[index]
                                        .value ??
                                        emptyString)
                                        ? AppColors.white
                                        : AppColors
                                        .black, // Change text color
                                  ),
                                );
                              },
                              listBuilder: ChoiceList.createWrapped(),
                            ),
                          if (_preferenceController.selectedGrade.isNotEmpty)
                            AppDivider(),
                          if (_preferenceController
                              .selectedSchoolIndices.isNotEmpty && _preferenceController
                              .selectedSchoolIndices.contains('Private'))
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'curriculum'.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          if (_preferenceController
                              .selectedSchoolIndices.isNotEmpty && _preferenceController
                              .selectedSchoolIndices.contains('Private'))
                            InlineChoice<Grade>(
                              clearable: true,
                              value: _preferenceController.curriculum ??
                                  <Grade>[],
                              loading:
                              _preferenceController.curriculum.isEmpty ??
                                  true,
                              //onChanged: setSchoolValue,
                              itemCount:
                              _preferenceController.curriculum.length ?? 0,
                              itemBuilder:
                                  (ChoiceController<Grade> selection,
                                  int index) {
                                return ChoiceChip(
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: _preferenceController
                                              .selectedCurriculumIndices
                                              .contains(
                                              _preferenceController
                                                  .curriculum[
                                              index]
                                                  .value ??
                                                  emptyString)
                                              ? AppColors.trans
                                              : AppColors.appBorderColor)),
                                  backgroundColor: AppColors.trans,
                                  selected: _preferenceController
                                      .selectedCurriculumIndices
                                      .contains(_preferenceController
                                      .curriculum[index].value ??
                                      emptyString),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        _preferenceController
                                            .selectedCurriculumIndices
                                            .add(_preferenceController
                                            .curriculum[index]
                                            .value ??
                                            emptyString); // Add to the set for multi-selection
                                      } else {
                                        _preferenceController
                                            .selectedCurriculumIndices
                                            .remove(_preferenceController
                                            .curriculum?[index]
                                            .value ??
                                            emptyString); // Remove from the set
                                      }
                                    });
                                  },
                                  showCheckmark: false,
                                  label: Text(_preferenceController
                                      .curriculum[index].value ??
                                      emptyString),
                                  selectedColor: AppColors
                                      .appBlue, // Change this to your desired color
                                  labelStyle: TextStyle(
                                    color: _preferenceController
                                        .selectedCurriculumIndices
                                        .contains(_preferenceController
                                        .curriculum[index]
                                        .value ??
                                        emptyString)
                                        ? AppColors.white
                                        : AppColors
                                        .black, // Change text color
                                  ),
                                );
                              },
                              listBuilder: ChoiceList.createWrapped(),
                            ),
                          if (_preferenceController
                              .selectedSchoolIndices.isNotEmpty && _preferenceController
                              .selectedSchoolIndices.contains('Private'))
                            AppDivider(),
                          if ( _preferenceController
                              .selectedSchoolIndices.isNotEmpty && !_preferenceController
                              .selectedSchoolIndices.contains('Private') )
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'subject'.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      'optional'.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_preferenceController
                              .selectedSchoolIndices.isNotEmpty && !_preferenceController
                              .selectedSchoolIndices.contains('Private'))
                            InlineChoice<Grade>(
                              clearable: true,
                              loading: _preferenceController.subject.isEmpty ??
                                  true,
                              value: _preferenceController.subject ??
                                  <Grade>[],
                              //onChanged: setSchoolValue,
                              itemCount:
                              _preferenceController.subject.length ?? 0,
                              itemBuilder:
                                  (ChoiceController<Grade> selection,
                                  int index) {
                                return ChoiceChip(
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: _preferenceController
                                              .selectedSubjectIndices
                                              .contains(index)
                                              ? AppColors.trans
                                              : AppColors.appBorderColor)),
                                  backgroundColor: AppColors.trans,
                                  selected: _preferenceController
                                      .selectedSubjectIndices
                                      .contains(_preferenceController
                                      .subject[index].value ??
                                      emptyString),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        _preferenceController
                                            .selectedSubjectIndices
                                            .add(_preferenceController
                                            .subject[index].value ??
                                            emptyString); // Add to the set for multi-selection
                                      } else {
                                        _preferenceController
                                            .selectedSubjectIndices
                                            .remove(_preferenceController
                                            .subject[index].value ??
                                            emptyString); // Remove from the set
                                      }
                                    });
                                  },
                                  showCheckmark: false,
                                  label: Text(_preferenceController
                                      .subject[index].value ??
                                      emptyString),
                                  selectedColor: AppColors
                                      .appBlue, // Change this to your desired color
                                  labelStyle: TextStyle(
                                    color: _preferenceController
                                        .selectedSubjectIndices
                                        .contains(_preferenceController
                                        .subject[index].value ??
                                        emptyString)
                                        ? AppColors.white
                                        : AppColors
                                        .black, // Change text color
                                  ),
                                );
                              },
                              listBuilder: ChoiceList.createWrapped(),
                            ),
                          if ( _preferenceController
                              .selectedSchoolIndices.isNotEmpty && _preferenceController
                              .selectedSchoolIndices.contains('Private')  && _preferenceController
                              .selectedCurriculumIndices.isNotEmpty  )
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'subject'.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      'optional'.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_preferenceController
                              .selectedSchoolIndices.isNotEmpty && _preferenceController
                              .selectedSchoolIndices.contains('Private') && _preferenceController
                              .selectedCurriculumIndices.isNotEmpty)
                            InlineChoice<Grade>(
                              clearable: true,
                              loading: _preferenceController.subject.isEmpty ??
                                  true,
                              value: _preferenceController.subject ??
                                  <Grade>[],
                              //onChanged: setSchoolValue,
                              itemCount:
                              _preferenceController.subject.length ?? 0,
                              itemBuilder:
                                  (ChoiceController<Grade> selection,
                                  int index) {
                                return ChoiceChip(
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: _preferenceController
                                              .selectedSubjectIndices
                                              .contains(index)
                                              ? AppColors.trans
                                              : AppColors.appBorderColor)),
                                  backgroundColor: AppColors.trans,
                                  selected: _preferenceController
                                      .selectedSubjectIndices
                                      .contains(_preferenceController
                                      .subject[index].value ??
                                      emptyString),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        _preferenceController
                                            .selectedSubjectIndices
                                            .add(_preferenceController
                                            .subject[index].value ??
                                            emptyString); // Add to the set for multi-selection
                                      } else {
                                        _preferenceController
                                            .selectedSubjectIndices
                                            .remove(_preferenceController
                                            .subject[index].value ??
                                            emptyString); // Remove from the set
                                      }
                                    });
                                  },
                                  showCheckmark: false,
                                  label: Text(_preferenceController
                                      .subject[index].value ??
                                      emptyString),
                                  selectedColor: AppColors
                                      .appBlue, // Change this to your desired color
                                  labelStyle: TextStyle(
                                    color: _preferenceController
                                        .selectedSubjectIndices
                                        .contains(_preferenceController
                                        .subject[index].value ??
                                        emptyString)
                                        ? AppColors.white
                                        : AppColors
                                        .black, // Change text color
                                  ),
                                );
                              },
                              listBuilder: ChoiceList.createWrapped(),
                            ),
                          if (_preferenceController
                              .selectedCurriculumIndices.isNotEmpty)
                            AppDivider(),
                        ],
                      ),
                    ),
                  ),
                  Obx(()=>
                 AppButton(
                        isDisable: _preferenceController.selectedSubjectIndices.isEmpty,
                        title: 'saveMyPreferences'.tr,
                        onPressed: () {
                          if( _preferenceController.selectedSubjectIndices.isNotEmpty){
                          _preferenceController.setUserPreference().then((value) async{
                            final HomeController homeController=Get.put(HomeController());
                           await  homeController.fetchData();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                            selectedProfile =LocaleManager.getValue(StorageKeys.profile) ??'';
                            if (selectedProfile ==
                                ApplicationConstants.student) {
                              Get.toNamed(Routes.HomeScreenRoute);
                            }
                          });
                        }}),
                  )
                ],
              );
            },
          )),
    );
  }
}
