import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../config/routes/route.dart';
import '../../../core/api_end_points.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/cardView/app_card_view.dart';
import '../../../custom/cardView/info_card_view.dart';
import '../../../custom/choice/src/inline/list.dart';
import '../../../custom/choice/src/inline/main.dart';
import '../../../custom/choice/src/selection/controller/main.dart';
import '../../../custom/divider/divider.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/enums/app_register_status_enums.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/utils/typography.dart';
import '../../home_views/views/reupload_documents.dart';
import '../../preference/controller/preference_controller.dart';
import '../../preference/model/preference_model.dart';
import '../controller/search_controller.dart';


class ForStudents extends StatefulWidget {
  const ForStudents({super.key});

  @override
  State<ForStudents> createState() => _ForStudentsState();
}

class _ForStudentsState extends State<ForStudents> {
  final SearchClassController _searchController=Get.put(SearchClassController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.getSavedSearch(SchoolEndpoint.GET_SEARCH_CLASS);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>
       Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            child:  !_searchController.isSearch.value ? Column(
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
                if( _searchController.selectedSaveDataIndices.isEmpty)Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 10),
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
                    if(_searchController.preferenceController.grade.isNotEmpty)InlineChoice<Grade>(
                      clearable: true,
                      value: _searchController.preferenceController.grade,
                      // onChanged: setGradeValue,
                      itemCount:_searchController.preferenceController.grade.length,
                      itemBuilder:
                          (ChoiceController<Grade> selection, int index) {
                        return ChoiceChip(
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color:
                                  _searchController.grade.contains(selection.value[index].value)
                                      ? AppColors.trans
                                      : AppColors.appBorderColor.withOpacity(0.25))),
                          backgroundColor: AppColors.trans,
                          selected:  _searchController.grade.contains(selection.value[index].value),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _searchController.grade.add(selection.value[index].value!); // Add to the set for multi-selection
                              } else {
                                _searchController.grade.remove(selection.value[index].value); // Remove from the set
                              }
                            });
                          },
                          showCheckmark: false,
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Text(_searchController.preferenceController.grade[index].value??''),
                          ),
                          selectedColor: AppColors
                              .appBlue,
                          // Change this to your desired color
                          labelStyle: TextStyle(
                            color: _searchController.grade.contains(selection.value[index].value)
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
                    if(_searchController.preferenceController.curriculum.isNotEmpty) InlineChoice<Grade>(
                      clearable: true,
                      value:  _searchController.preferenceController.curriculum,
                      // onChanged: setCurriculumValue,
                      itemCount:  _searchController.preferenceController.curriculum.length,
                      itemBuilder:
                          (ChoiceController<Grade> selection, int index) {
                        return ChoiceChip(
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color: _searchController.selectedCurriculumIndices.contains(selection.value[index].value)
                                      ? AppColors.trans
                                      : AppColors.appBorderColor
                                      .withOpacity(0.25))),
                          backgroundColor: AppColors.trans,
                          selected: _searchController.selectedCurriculumIndices.contains(selection.value[index].value),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _searchController.selectedCurriculumIndices.add(
                                    selection.value[index].value!); // Add to the set for multi-selection
                              } else {
                                _searchController.selectedCurriculumIndices
                                    .remove(selection.value[index].value); // Remove from the set
                              }
                            });
                          },
                          showCheckmark: false,
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Text( _searchController.preferenceController.curriculum[index].value??''),
                          ),
                          selectedColor: AppColors.appBlue,
                          // Change this to your desired color
                          labelStyle: TextStyle(
                            color: _searchController.selectedCurriculumIndices.contains(selection.value[index].value)
                                ? AppColors.white
                                : AppColors.appTextColor
                                .withOpacity(0.5), // Change text color
                          ),
                        );
                      },
                      listBuilder: ChoiceList.createWrapped(),
                    ),
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
                    if(_searchController.preferenceController.schoolType.isNotEmpty) InlineChoice<Grade>(
                      clearable: true,
                      value: _searchController.preferenceController.schoolType,
                      // onChanged: setSchoolValue,
                      itemCount:_searchController.preferenceController.schoolType.length,
                      itemBuilder:
                          (ChoiceController<Grade> selection, int index) {
                        return ChoiceChip(
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color:
                                  _searchController.selectedSchoolIndices.contains(selection.value[index].value)
                                      ? AppColors.trans
                                      : AppColors.appBorderColor.withOpacity(0.25))),
                          backgroundColor: AppColors.trans,
                          selected: _searchController.selectedSchoolIndices.contains(selection.value[index].value),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _searchController.selectedSchoolIndices.add(
                                    selection.value[index].value!); // Add to the set for multi-selection
                              } else {
                                _searchController.selectedSchoolIndices
                                    .remove( selection.value[index].value); // Remove from the set
                              }
                            });
                          },
                          showCheckmark: false,
                          label: Text(_searchController.preferenceController.schoolType[index].value??''),
                          selectedColor: AppColors
                              .appBlue,
                          // Change this to your desired color
                          labelStyle: TextStyle(
                            color: _searchController.selectedSchoolIndices.contains(selection.value[index].value)
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
                    if(_searchController.preferenceController.subject.isNotEmpty) InlineChoice<Grade>(
                      clearable: true,
                      value: _searchController.preferenceController.subject,
                      // onChanged: setSubjectValue,
                      itemCount:  _searchController.preferenceController.subject.length,
                      itemBuilder:
                          (ChoiceController<Grade> selection, int index) {
                        return ChoiceChip(
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color:
                                  _searchController.selectedSubjectIndices.contains(selection.value[index].value)
                                      ? AppColors.trans
                                      : AppColors.appBorderColor.withOpacity(0.25))),
                          backgroundColor: AppColors.trans,
                          selected: _searchController.selectedSubjectIndices.contains(selection.value[index].value),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _searchController.selectedSubjectIndices.add(
                                    selection.value[index].value!); // Add to the set for multi-selection
                              } else {
                                _searchController.selectedSubjectIndices
                                    .remove(  selection.value[index].value); // Remove from the set
                              }
                            });
                          },
                          showCheckmark: false,
                          label: Text( _searchController.preferenceController.subject[index].value??''),
                          selectedColor: AppColors
                              .appBlue,
                          // Change this to your desired color
                          labelStyle: TextStyle(
                            color: _searchController.selectedSubjectIndices.contains(selection.value[index].value)
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
                      final Map<String, dynamic>  searchData;
                      if(_searchController.selectedSaveDataIndices==''){
                        searchData=<String,dynamic >{
                          'saveSearch':_searchController.isSwitch,
                          if(_searchController.isSwitch && _searchController.saveName.text!='')...<String, dynamic>{
                            'shortName': _searchController.saveName.text,
                          },
                          'filters':<String, dynamic>{
                            'grades':_searchController.grade.toList(),
                            'subjects':_searchController.selectedSubjectIndices.toList(),
                             'schoolTypes':_searchController.selectedSchoolIndices.toList(),
                            'curriculum': _searchController.selectedCurriculumIndices.toList()
                          }
                        };}else{
                        searchData=<String,dynamic >{
                          'saveSearch':false,
                          'filters':<String, dynamic>{
                            'shortName': _searchController.selectedSaveDataIndices,
                          }
                        };
                      }
                      _searchController.search(SchoolEndpoint.SEARCH_CLASSES,searchData);
                    },
                    // ignore: avoid_bool_literals_in_conditional_expressions
                    isDisable: _searchController.selectedSchoolIndices.isNotEmpty ||
                        _searchController.selectedSubjectIndices.isNotEmpty || _searchController.grade.isNotEmpty || _searchController.selectedSaveDataIndices !=''
                        ? false
                        : true,
                  ),
                ),
              ],
            )
                : _searchController.searchClassList.isNotEmpty ? ListView.separated(
              padding: const EdgeInsets.only(
                 top: 5, bottom: 20,),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount:_searchController.searchClassList.length,
              itemBuilder: (BuildContext context, int index) {
                return   AppCardView(
                  proposals: 5,
                  cardTitle:
                  _searchController.searchClassList[index].subject,
                  date:  _searchController.searchClassList[index].classTime!=null?_searchController.searchClassList[index].classTime
                      .toString()
                      .epochToNormal():'',
                  timer: _searchController.searchClassList[index].duration
                      .toString()
                      .timeConvert(),
                  money:
                  "${ _searchController.searchClassList[index].cost ?? ''} ${ _searchController.searchClassList[index].currency ?? ''}",
                  status:  _searchController.searchClassList[index].status,
                  // isPro: true,
                  avtar: ImageConstants.teacherAvtar,
                  countryIcon: ImageConstants.countryIcon,
                  countryName: 'Kuwait',
                  reViewLength: 3,
                  teacherName:
                  _searchController.searchClassList[index].name,
                  grade: _searchController.searchClassList[index].grade,
                  minParticipants: _searchController.searchClassList[index].minParticipants,
                  maxParticipants: _searchController.searchClassList[index].maxParticipants,
                  buttonTap: () {
                    Get.toNamed(Routes.classDetailsView,
                        arguments: <String, Object?>{'classNumber': _searchController.searchClassList[index].classNumber,'backIndex':1});
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 15,
                );
              },
            ) :
            Padding(
              padding: const EdgeInsets.only(top: 60),
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
          ),
        ),
      ),
    );
  }
}


