import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../config/routes/route.dart';
import '../../../core/api_end_points.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/cardView/app_card_view.dart';
import '../../../custom/cardView/info_card_view.dart';
import '../../../custom/choice/src/inline/list.dart';
import '../../../custom/choice/src/inline/main.dart';
import '../../../custom/choice/src/modal/button.dart';
import '../../../custom/choice/src/selection/controller/main.dart';
import '../../../custom/dialog/success_fail_dialog.dart';
import '../../../custom/divider/divider.dart';
import '../../../product/cache/key_value_storage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/app/app_enums.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/utils/typography.dart';
import '../../class/class_detail/controller/class_detail_controller.dart';
import '../../classDetails/controller/class_details_controller.dart';
import '../../classDetails/view/bottomSheetView/booking_bottom_view.dart';
import '../../proposal/create_proposal/controller/create_proposal_controller.dart';
import '../../setting_view/add_address_screen/Model/request_address_model.dart';
import '../../setting_view/manage_address/Model/get_address_model.dart' hide Location;
import '../../setting_view/manage_address/controller/manage_controller.dart';
import '../../tutorial/language/controller/language_controller.dart';
import '../../tutorial/language/model/country_model.dart';
import '../controller/search_controller.dart';


class ForStudents extends StatefulWidget {
  const ForStudents({super.key});

  @override
  State<ForStudents> createState() => _ForStudentsState();
}

class _ForStudentsState extends State<ForStudents> {
  final SearchClassController _searchController=Get.find();
  final ClassDetailsController _classDetailsController =
  Get.put(ClassDetailsController());
  final ClassDetailController _classDetailController =
  Get.put(ClassDetailController());
  final ManageAddressController _manageAddressController =
  Get.put(ManageAddressController());
  final LanguageController _languageController = Get.find();
  String selectedProfile = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.getSavedSearch(SchoolEndpoint.GET_SEARCH_CLASS);
    _searchController.scrollControllerClass.addListener(pagination);
    selectedProfile = LocaleManager.getValue(StorageKeys.profile) ?? '';
    _manageAddressController.fetchAddressData();
  }
  void pagination() {
    if (_searchController.scrollControllerClass.position.pixels ==
        _searchController.scrollControllerClass.position.maxScrollExtent) {
      _searchController.pagination(endPoint: SchoolEndpoint.SEARCH_CLASSES);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>
       Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
            child:  !_searchController.isSearch.value ? searchScreen()
                : _searchController.searchClassList.isNotEmpty ?searchedDataScreen() :
            emptySearchedDataScreen(),
        ),
      ),
    );
  }


  Widget searchScreen(){
    return SingleChildScrollView(
      child: Column(
        children: [
          if(_searchController.savedData.isNotEmpty) Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Row(
              children: <Widget>[
                Text(
                  'Select From Saved Search',
                  style: openSans.get16.w700
                      .textColor(AppColors.appTextColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    '(optional)',
                    style: openSans.get12.w400.textColor(
                        AppColors.appTextColor.withOpacity(0.5)),
                  ),
                ),
              ],
            ),
          ),
          if(_searchController.savedData.isNotEmpty) InlineChoice<String>(
            clearable: true,
            value: _searchController.savedData,
            // onChanged: setGenderValue,
            itemCount: _searchController.savedData.length,
            itemBuilder:
                (ChoiceController<String> selection, int index) {
              return ChoiceChip(
                shape: StadiumBorder(
                    side: BorderSide(
                        color: _searchController.selectedSaveDataIndices==_searchController.savedData[index]
                            ? AppColors.trans
                            : AppColors.appBorderColor
                            .withOpacity(0.25))),
                backgroundColor: AppColors.trans,
                selected: _searchController.selectedSaveDataIndices==_searchController.savedData[index],
                onSelected: (bool selected) {
                  setState(() {
                    if(_searchController.selectedSaveDataIndices==_searchController.savedData[index]){
                      _searchController.selectedSaveDataIndices='';
                    }else{
                      _searchController.selectedSaveDataIndices=
                      _searchController.savedData[index];
                    }

                    // Add to the set for multi-selection

                  });
                },
                showCheckmark: false,
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Text(_searchController.savedData[index]),
                ),
                selectedColor: AppColors.appBlue,
                // Change this to your desired color
                labelStyle: TextStyle(
                  color: _searchController.selectedSaveDataIndices==_searchController.savedData[index]
                      ? AppColors.white
                      : AppColors.appTextColor
                      .withOpacity(0.5), // Change text color
                ),
              );
            },
            listBuilder: ChoiceList.createWrapped(),
          ),
          AppDivider(),
          if( _searchController.selectedSaveDataIndices.isEmpty)Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Class Type',
                      style: openSans.get16.w700
                          .textColor(AppColors.appTextColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '(optional)',
                        style: openSans.get12.w400.textColor(
                            AppColors.appTextColor.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              if(_searchController.preferenceController.masterData.value.classTypes!=null && _searchController.preferenceController.masterData.value.classTypes!.isNotEmpty) InlineChoice<String>(
                clearable: true,
                value: _searchController.preferenceController.masterData.value.classTypes!,
                // onChanged: setGenderValue,
                itemCount: _searchController.preferenceController.masterData.value.classTypes!.length,
                itemBuilder:
                    (ChoiceController<String> selection, int index) {
                  return ChoiceChip(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: _searchController.selectedClassTypeIndices.contains(selection.value[index])
                                ? AppColors.trans
                                : AppColors.appBorderColor
                                .withOpacity(0.25))),
                    backgroundColor: AppColors.trans,
                    selected:  _searchController.selectedClassTypeIndices.contains(selection.value[index]),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _searchController.selectedClassTypeIndices.add(
                              selection.value[index]); // Add to the set for multi-selection
                        } else {
                          _searchController.selectedClassTypeIndices
                              .remove(selection.value[index]); // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Text(_searchController.preferenceController.masterData.value.classTypes![index]),
                    ),
                    selectedColor: AppColors.appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color:   _searchController.selectedClassTypeIndices.contains(selection.value[index])
                          ? AppColors.white
                          : AppColors.appTextColor
                          .withOpacity(0.5), // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              AppDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Gender',
                      style: openSans.get16.w700
                          .textColor(AppColors.appTextColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '(optional)',
                        style: openSans.get12.w400.textColor(
                            AppColors.appTextColor.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              if(_searchController.preferenceController.masterData.value.gender!=null && _searchController.preferenceController.masterData.value.gender!.isNotEmpty) InlineChoice<String>(
                clearable: true,
                value: _searchController.preferenceController.masterData.value.gender!,
                // onChanged: setGenderValue,
                itemCount: _searchController.preferenceController.masterData.value.gender!.length,
                itemBuilder:
                    (ChoiceController<String> selection, int index) {
                  return ChoiceChip(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: _searchController.selectedGenderIndices==selection.value[index]
                                ? AppColors.trans
                                : AppColors.appBorderColor
                                .withOpacity(0.25))),
                    backgroundColor: AppColors.trans,
                    selected:  _searchController.selectedGenderIndices==selection.value[index],
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _searchController.selectedGenderIndices=
                          selection.value[index]; // Add to the set for multi-selection
                        } else {
                          _searchController.selectedGenderIndices='';
                          // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Text(_searchController.preferenceController.masterData.value.gender![index]),
                    ),
                    selectedColor: AppColors.appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color:   _searchController.selectedGenderIndices==selection.value[index]
                          ? AppColors.white
                          : AppColors.appTextColor
                          .withOpacity(0.5), // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              AppDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Grade',
                      style: openSans.get16.w700
                          .textColor(AppColors.appTextColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Select 1 or more',
                        style: openSans.get12.w400.textColor(
                            AppColors.appTextColor.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),

              if(_searchController.preferenceController.masterData.value.grades!=null && _searchController.preferenceController.masterData.value.grades!.isNotEmpty)InlineChoice<String>(
                clearable: true,
                value: _searchController.preferenceController.masterData.value.grades!,
                // onChanged: setGradeValue,
                itemCount:_searchController.preferenceController.masterData.value.grades!.length,
                itemBuilder:
                    (ChoiceController<String> selection, int index) {
                  return ChoiceChip(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color:
                            _searchController.grade.contains(selection.value[index])
                                ? AppColors.trans
                                : AppColors.appBorderColor.withOpacity(0.25))),
                    backgroundColor: AppColors.trans,
                    selected:  _searchController.grade.contains(selection.value[index]),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _searchController.grade.add(selection.value[index]); // Add to the set for multi-selection
                        } else {
                          _searchController.grade.remove(selection.value[index]); // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Text(_searchController.preferenceController.masterData.value.grades?[index]??''),
                    ),
                    selectedColor: AppColors
                        .appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: _searchController.grade.contains(selection.value[index])
                          ? AppColors.white
                          : AppColors.appTextColor.withOpacity(
                          0.5), // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              AppDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Curriculum',
                      style: openSans.get20.w700
                          .textColor(AppColors.appTextColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '(optional)',
                        style: openSans.get12.w400.textColor(
                            AppColors.appTextColor.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              if(_searchController.preferenceController.masterData.value.curriculum!=null && _searchController.preferenceController.masterData.value.curriculum!.isNotEmpty) InlineChoice<String>(
                clearable: true,
                value:  _searchController.preferenceController.masterData.value.curriculum!,
                // onChanged: setCurriculumValue,
                itemCount:  _searchController.preferenceController.masterData.value.curriculum!.length,
                itemBuilder:
                    (ChoiceController<String> selection, int index) {
                  return ChoiceChip(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: _searchController.selectedCurriculumIndices.contains(selection.value[index])
                                ? AppColors.trans
                                : AppColors.appBorderColor
                                .withOpacity(0.25))),
                    backgroundColor: AppColors.trans,
                    selected: _searchController.selectedCurriculumIndices.contains(selection.value[index]),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _searchController.selectedCurriculumIndices.add(
                              selection.value[index]); // Add to the set for multi-selection
                        } else {
                          _searchController.selectedCurriculumIndices
                              .remove(selection.value[index]); // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Text( _searchController.preferenceController.masterData.value.curriculum?[index]??''),
                    ),
                    selectedColor: AppColors.appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: _searchController.selectedCurriculumIndices.contains(selection.value[index])
                          ? AppColors.white
                          : AppColors.appTextColor
                          .withOpacity(0.5), // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              AppDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'School',
                      style: openSans.get16.w700
                          .textColor(AppColors.appTextColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '(optional)',
                        style: openSans.get12.w400.textColor(
                            AppColors.appTextColor.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              if(_searchController.preferenceController.masterData.value.schoolTypes!=null && _searchController.preferenceController.masterData.value.schoolTypes!.isNotEmpty) InlineChoice<String>(
                clearable: true,
                value: _searchController.preferenceController.masterData.value.schoolTypes!,
                // onChanged: setSchoolValue,
                itemCount:_searchController.preferenceController.masterData.value.schoolTypes!.length,
                itemBuilder:
                    (ChoiceController<String> selection, int index) {
                  return ChoiceChip(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color:
                            _searchController.selectedSchoolIndices.contains(selection.value[index])
                                ? AppColors.trans
                                : AppColors.appBorderColor.withOpacity(0.25))),
                    backgroundColor: AppColors.trans,
                    selected: _searchController.selectedSchoolIndices.contains(selection.value[index]),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _searchController.selectedSchoolIndices.add(
                              selection.value[index]); // Add to the set for multi-selection
                        } else {
                          _searchController.selectedSchoolIndices
                              .remove( selection.value[index]); // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Text(_searchController.preferenceController.masterData.value.schoolTypes?[index]??''),
                    selectedColor: AppColors
                        .appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: _searchController.selectedSchoolIndices.contains(selection.value[index])
                          ? AppColors.white
                          : AppColors.appTextColor.withOpacity(
                          0.5), // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              AppDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Subject',
                      style: openSans.get20.w700
                          .textColor(AppColors.appTextColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '(optional)',
                        style: openSans.get12.w400.textColor(
                            AppColors.appTextColor.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              if(_searchController.preferenceController.masterData.value.subjects!=null && _searchController.preferenceController.masterData.value.subjects!.isNotEmpty) InlineChoice<String>(
                clearable: true,
                value: _searchController.preferenceController.masterData.value.subjects!,
                // onChanged: setSubjectValue,
                itemCount:  _searchController.preferenceController.masterData.value.subjects!.length,
                itemBuilder:
                    (ChoiceController<String> selection, int index) {
                  return ChoiceChip(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color:
                            _searchController.selectedSubjectIndices.contains(selection.value[index])
                                ? AppColors.trans
                                : AppColors.appBorderColor.withOpacity(0.25))),
                    backgroundColor: AppColors.trans,
                    selected: _searchController.selectedSubjectIndices.contains(selection.value[index]),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _searchController.selectedSubjectIndices.add(
                              selection.value[index]); // Add to the set for multi-selection
                        } else {
                          _searchController.selectedSubjectIndices
                              .remove(  selection.value[index]); // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Text( _searchController.preferenceController.masterData.value.subjects?[index]??''),
                    selectedColor: AppColors
                        .appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: _searchController.selectedSubjectIndices.contains(selection.value[index])
                          ? AppColors.white
                          : AppColors.appTextColor.withOpacity(
                          0.5), // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              AppDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text('Save Search', style: openSans.get14.w500),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: FlutterSwitch(
                        value: _searchController.isSwitch,
                        height: 16.29,
                        width: 27.63,
                        toggleSize: 12,
                        activeColor: AppColors.appBlue,
                        inactiveColor: AppColors.gray.withOpacity(0.25),
                        onToggle: (bool value) {
                          setState(() {
                            _searchController.isSwitch = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (_searchController.isSwitch) AppTextFormField(
                controller: _searchController.saveName,
                hintText: 'Enter search name',
                top: 0,
              ) else
                const SizedBox.shrink(),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 45, top: 30),

            child: AppButton(
              title: !_searchController.isSwitch ? 'Search' : 'Save Search and Show Results',
              onPressed: () {
                if(_searchController.selectedSaveDataIndices==''){
                  _searchController.searchData=<String,dynamic >{
                    'saveSearch':_searchController.isSwitch,
                    if(_searchController.isSwitch && _searchController.saveName.text!='')...<String, dynamic>{
                      'shortName': _searchController.saveName.text,
                    },
                    'filters':<String, dynamic>{
                      'grades':_searchController.grade.toList(),
                      'subjects':_searchController.selectedSubjectIndices.toList(),
                      'schoolTypes':_searchController.selectedSchoolIndices.toList(),
                      'curriculum': _searchController.selectedCurriculumIndices.toList(),
                      if(_searchController.selectedGenderIndices!='')...{
                        'gender': _searchController.selectedGenderIndices,
                      },
                      'classTypes': _searchController.selectedClassTypeIndices.toList()
                    },
                  };}else{
                  _searchController.searchData=<String,dynamic >{
                    'saveSearch':false,
                    'filters':<String, dynamic>{
                      'shortName': _searchController.selectedSaveDataIndices,
                    }
                  };
                }
                _searchController.searchData['pagination']=<String, dynamic>{
                  'pageSize':20,
                  'pageIndex': _searchController.pageIndex,
                  'sort': <String, dynamic>{
                    'direction': 'asc',
                    'column': 'created_at'
                  }
                };
                _searchController.search(SchoolEndpoint.SEARCH_CLASSES,_searchController.searchData);
              },
              // ignore: avoid_bool_literals_in_conditional_expressions
              isDisable: _searchController.selectedSchoolIndices.isNotEmpty ||  _searchController.selectedGenderIndices.isNotEmpty || _searchController.selectedClassTypeIndices.isNotEmpty ||
                  _searchController.selectedSubjectIndices.isNotEmpty || _searchController.grade.isNotEmpty || _searchController.selectedSaveDataIndices !='' ||_searchController.selectedCurriculumIndices.isNotEmpty
                  ? false
                  : true,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchedDataScreen(){
   
    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 5, bottom: 20,),
      shrinkWrap: true,
      controller: _searchController.scrollControllerClass,
      physics: const BouncingScrollPhysics(),
      itemCount:_searchController.searchClassList.length,
      itemBuilder: (BuildContext context, int index) {
        return   AppCardView(
          proposals: 5,
          cardTitle:
          _searchController.searchClassList[index].subject,
          
          // ignore: avoid_bool_literals_in_conditional_expressions
          isBook: _searchController.searchClassList[index].canBookFlag!=null && _searchController.searchClassList[index].canBookFlag==1?true:false,
          date:  _searchController.searchClassList[index].classTime!=null?_searchController.searchClassList[index].classTime
              .toString()
              .epochToNormal():'',
          timer: _searchController.searchClassList[index].duration
              .toString()
              .timeConvert(),
          title: selectedProfile == ApplicationConstants.tutor?'Propose':'Book',
          money:
          "${ _searchController.searchClassList[index].cost ?? ''} ${ _searchController.searchClassList[index].currency ?? ''}",
          status:  _searchController.searchClassList[index].status,
          // isPro: true,
          avtar: _searchController.searchClassList[index].imageId?.getImageUrl('profile'),
          countryIcon: _searchController.searchClassList[index].country!=null && _languageController.countries.isNotEmpty?_languageController.countries.firstWhere((Country element) => element.name==_searchController.searchClassList[index].country).flag_url:ImageConstants.countryIcon,

          countryName: _searchController.searchClassList[index].country,
          reViewLength: _searchController.searchClassList[index].rating??0,
          role: _searchController.searchClassList[index].role??UserRole.student,
          teacherName:
          _searchController.searchClassList[index].name,
          grade: _searchController.searchClassList[index].grade,
          minParticipants: _searchController.searchClassList[index].minParticipants,
          maxParticipants: _searchController.searchClassList[index].maxParticipants,
          cardTap: () {
            Get.toNamed(Routes.classDetailsView,
                arguments: <String, Object?>{'classNumber': _searchController.searchClassList[index].classNumber,'backIndex':1});
          },
          buttonTap: selectedProfile == ApplicationConstants.student?() async {
            if (_searchController.searchClassList[index]
                .allowAtStudentLoc ==
                0) {
              if (_searchController.searchClassList[index]
                  .maxParticipants! >
                  1) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled:true,
                  constraints: BoxConstraints(
                    maxHeight: (MediaQuery.of(context).size.height * 0.95.px -
                        20).px,
                    maxWidth:
                    // ignore: use_build_context_synchronously
                    (MediaQuery.of(context).size.width -
                        30)
                        .px,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.px),
                  ),
                  builder: (BuildContext context) {
                    _classDetailsController.classId=_searchController.searchClassList[index].classNumber!;
                    _classDetailsController.getClassDetails(_searchController.searchClassList[index].classNumber!);
                    return BookingBottomSheet(
                        isRouting: 'backToHomeScreen'
                    );
                  },
                );
              } else {
                _classDetailsController.classId=_searchController.searchClassList[index].classNumber!;
                final bool status = await _classDetailsController
                    .bookClassDetail(
                    {});
                if (status) {
                  // ignore: use_build_context_synchronously
                  showModalBottomSheet(
                    context: context,
                    constraints: BoxConstraints(
                      maxWidth:
                      // ignore: use_build_context_synchronously
                      (MediaQuery.of(context)
                          .size
                          .width -
                          30)
                          .px,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(20.px),
                    ),
                    builder: (BuildContext context) {
                      return SuccessFailsInfoDialog(
                        title: 'Success',
                        buttonTitle: 'Done',
                        content:
                        'You have successfully booked your class, and you will get notification to pay after the teacher accept the class.',
                        isRouting: 'back',
                      );
                    },
                  );
                }
              }
            } else {
              locationModalBottomSheet(context, index);
            }
          }:(){
            final CreateProposalController createProposalController = Get
                .put(CreateProposalController());
            createProposalController.dateController.text =
                DateFormat('dd-M-yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(_searchController.searchClassList[index].classTime!));
            createProposalController.classDurationController.text =
                _searchController.searchClassList[index].duration?.toString()
                    .timeConvert() ?? '';
            createProposalController.duration =
                _searchController.searchClassList[index].duration??0;
            createProposalController.numberOfSession.text =
                _searchController.searchClassList[index].maxParticipants?.toString() ?? '';
            createProposalController.classCost.text =
                _searchController.searchClassList[index].cost?.replaceAll(
                    '.00', '') ?? '';
            // ignore: avoid_dynamic_calls
            Get.toNamed(Routes.createProposal,
                arguments: {'classNumber':_searchController.searchClassList[index].classNumber!,
                  'isRouting':'backToHomeScreen'
                });
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 15,
        );
      },
    );
  }

  Widget emptySearchedDataScreen(){
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: SizedBox(
        height: 240,
        child: InfoCardVIew(
          isShowButton: true,
          isSupport: false,
          title: 'No Results Found!',
          subTitle:
          'No results found. Please refine your search.',
          cardColor: AppColors.white,
          buttonTitle: 'Modify Search',
          buttonTap: () {
            _searchController.isSearch.value=false;
            _searchController.searchClassList.clear();
          },
        ),
      ),
    );
  }


  void locationModalBottomSheet(context, index) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        // showDragHandle: true,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Select class location', style: openSans.get20.w700),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                AppColors.downArrowColor.withOpacity(0.15)),
                            child: const Padding(
                              padding: EdgeInsets.all(3),
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
              Obx(
                    () => Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            Get.back();
                            if (_searchController.searchClassList[index].maxParticipants !=
                                1) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled:true,
                                constraints: BoxConstraints(
                                  maxHeight: (MediaQuery.of(context).size.height * 0.95.px -
                                      20).px,
                                  maxWidth:
                                  // ignore: use_build_context_synchronously
                                  (MediaQuery.of(context).size.width)
                                      .px,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.px),
                                ),
                                builder: (BuildContext context) {
                                  _classDetailsController.classId=_searchController.searchClassList[index].classNumber!;
                                  _classDetailsController.getClassDetails(_searchController.searchClassList[index].classNumber!);
                                  return BookingBottomSheet(
                                    isRouting: 'backToHomeScreen',
                                  );
                                },
                              );
                            } else {
                              _classDetailsController.classId=_searchController.searchClassList[index].classNumber!;
                              final bool status = await _classDetailsController
                                  .bookClassDetail(
                                  {});
                              if (status) {
                                // ignore: use_build_context_synchronously
                                showModalBottomSheet(
                                  context: context,
                                  constraints: BoxConstraints(
                                    maxWidth:
                                    // ignore: use_build_context_synchronously
                                    (MediaQuery.of(context).size.width - 30)
                                        .px,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.px),
                                  ),
                                  builder: (BuildContext context) {
                                    return SuccessFailsInfoDialog(
                                      title: 'Success',
                                      buttonTitle: 'Done',
                                      content:
                                      'You have successfully booked your class, and you will get notification to pay after the teacher accept the class.',
                                      isRouting: 'back',
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.gray.withOpacity(0.25),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(15),
                              child: const Text(
                                'Keep at the teacher location',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              )),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _manageAddressController.address.length,
                          itemBuilder: (BuildContext context, int index) {
                            final UserAddress data =
                            _manageAddressController.address[index];
                            return listData(index, data, setState);
                          }),
                    ],
                  ),
                ),
              ),
              Obx(
                    () => AppButton(
                  onPressed: () async {
                    Get.back();
                    _classDetailsController.classId=_searchController.searchClassList[index].classNumber!;
                    final bool status = await _classDetailsController
                        .bookClassDetail(
                        {
                          'location': _manageAddressController
                              .address[_classDetailController.selectedIndex.value]
                              .id
                        });

                    if (status) {
                      // ignore: use_build_context_synchronously
                      showModalBottomSheet(
                        context: context,
                        constraints: BoxConstraints(
                          maxWidth:
                          // ignore: use_build_context_synchronously
                          (MediaQuery.of(context).size.width - 30).px,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.px),
                        ),
                        builder: (BuildContext context) {
                          return SuccessFailsInfoDialog(
                            title: 'Success',
                            buttonTitle: 'Done',
                            content:
                            'You have successfully booked your class, and you will get notification to pay after the teacher accept the class.',
                            isRouting: 'back',
                          );
                        },
                      );
                    }
                  },
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  isDisable: _classDetailController.selectedIndex.value != 200
                      ? false
                      : true,
                  title: 'select'.tr,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                    onPressed: () {
                      final Map<String, dynamic> titleData = {
                        'title': 'Add New Addresses',
                      };
                      Get.toNamed(Routes.addAddressView, arguments: titleData);
                    },
                    child: Text(
                      'addNewAddress'.tr,
                      style: openSans.w700,
                    )),
              )
            ]);
          });
        });
  }

  Widget listData(int index, UserAddress data, StateSetter setState) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
              () => Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: _classDetailController.selectedIndex.value == index
                      ? AppColors.appBlue
                      : AppColors.gray.withOpacity(0.25),
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(data.shortName ?? '',
                                style: openSans.get17.w700),
                            if (data.isDefault == 1)
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color(0xfff0f5ff),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 8),
                                      child: Text('default'.tr),
                                    )),
                              ),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              _classDetailController.selectedIndex.value =
                                  index;
                            },
                            child: _classDetailController.selectedIndex.value ==
                                index
                                ? const ChoiceConfirmButton(
                              icon: Icon(
                                Icons.check_circle,
                                color: AppColors.appBlue,
                              ),
                            )
                                : ChoiceConfirmButton(
                                icon: Icon(
                                  Icons.circle_outlined,
                                  color: AppColors.gray.withOpacity(0.25),
                                )))
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${data.address1 ?? ''} ${data.address2 ?? ''}'),
                        Text(
                            '${data.city ?? ''} ${data.state ?? ''} ${data.country ?? ''}'),
                      ],
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            if (data.isDefault == 1) {
                              AppUtils.showFlushBar(
                                context: Routes.navigatorKey.currentContext!,
                                message: 'Can not delete default address',
                              );
                            } else {
                              await _manageAddressController
                                  .deleteAddressData(data.id!);
                              if (_classDetailController.selectedIndex.value ==
                                  index) {
                                _classDetailController.selectedIndex.value =
                                200;
                              }
                            }
                          },
                          child: iconButtonWidget(
                            icon: Icons.delete_outline_rounded,
                            padding: 8,
                            bgColor: AppColors.appRed,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            var arguments = {
                              'title': 'Update Address',
                              'userData': data
                            };
                            Get.toNamed(Routes.addAddressView,
                                arguments: arguments);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10,
                                right: _classDetailController
                                    .selectedIndex.value !=
                                    index
                                    ? 10
                                    : 0),
                            child: iconButtonWidget(
                              icon: Icons.edit,
                              padding: 8,
                              bgColor: AppColors.appBlue,
                            ),
                          ),
                        ),
                        if (data.isDefault != 1)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  final AddressRequestModel updatedData =
                                  AddressRequestModel(
                                      isDefault: true,
                                      shortName: data.shortName,
                                      city: data.city,
                                      state: data.state,
                                      country: data.country,
                                      address2: data.address2,
                                      address1: data.address2,
                                      location: Location(
                                          lat: data.location?.lat,
                                          long: data.location?.long));
                                  _manageAddressController.updateAddressData(
                                      updatedData, data.id!);
                                },
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppColors.appBlue),
                                    shape: MaterialStatePropertyAll(
                                        StadiumBorder())),
                                child: const Text('Set Default',
                                    style: TextStyle(color: AppColors.white))),
                          )
                      ]),
                ],
              ),
            ),
          ),
        ));
  }

  Widget iconButtonWidget(
      {Color? bgColor,
        required IconData icon,
        double? iconSize,
        double? padding,
        void Function()? onPress}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor ?? AppColors.secondaryColor),
          child: Padding(
            padding: EdgeInsets.all(padding ?? 5.0),
            child: Icon(
              icon,
              size: iconSize ?? 23,
              color: AppColors.white,
            ),
          )),
    );
  }
}


