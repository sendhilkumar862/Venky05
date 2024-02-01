import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
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
import '../../../product/cache/key_value_storeage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/utils/typography.dart';
import '../../tutorial/language/controller/language_controller.dart';
import '../../tutorial/language/model/country_model.dart';
import '../controller/search_controller.dart';


class ForStudents extends StatefulWidget {
  const ForStudents({super.key});

  @override
  State<ForStudents> createState() => _ForStudentsState();
}

class _ForStudentsState extends State<ForStudents> {
  final SearchClassController _searchController=Get.put(SearchClassController());
  final LanguageController _languageController = Get.find();
  String selectedProfile = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.getSavedSearch(SchoolEndpoint.GET_SEARCH_CLASS);
    _searchController.scrollControllerClass.addListener(pagination);
    selectedProfile = LocaleManager.getValue(StorageKeys.profile) ?? '';
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
            child:  !_searchController.isSearch.value ? SingleChildScrollView(
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
                          _searchController.selectedSubjectIndices.isNotEmpty || _searchController.grade.isNotEmpty || _searchController.selectedSaveDataIndices !=''
                          ? false
                          : true,
                    ),
                  ),
                ],
              ),
            )
                : _searchController.searchClassList.isNotEmpty ? ListView.separated(
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
            ),
        ),
      ),
    );
  }
}


