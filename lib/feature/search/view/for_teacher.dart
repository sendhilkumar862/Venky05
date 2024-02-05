import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import '../../../core/api_end_points.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/cardView/details_card_view.dart';
import '../../../custom/cardView/details_card_view_student.dart';
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
import '../controller/search_controller.dart';

class ForTeacher extends StatefulWidget {
  const ForTeacher({Key? key}) : super(key: key);

  @override
  State<ForTeacher> createState() => _ForTeacherState();
}

class _ForTeacherState extends State<ForTeacher> {
  String selectedProfile = '';
  final SearchClassController _searchController=Get.put(SearchClassController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     selectedProfile = LocaleManager.getValue(StorageKeys.profile) ?? '';
    _searchController.getSavedSearch(SchoolEndpoint.GET_SEARCH_USER);
    _searchController.scrollControllerUser.addListener(pagination);
  }
  void pagination() {
    if (_searchController.scrollControllerUser.position.pixels ==
        _searchController.scrollControllerUser.position.maxScrollExtent) {
      _searchController.pagination(endPoint: selectedProfile == ApplicationConstants.tutor?SchoolEndpoint.SEARCH_STUDENTS:SchoolEndpoint.SEARCH_TUTORS);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>
       !_searchController.isSearchUser.value ?
             SingleChildScrollView(
                child: Column(
                  children: [
                    if(_searchController.savedDataUser.isNotEmpty) Padding(
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
                    if(_searchController.savedDataUser.isNotEmpty) InlineChoice<String>(
                      clearable: true,
                      value: _searchController.savedDataUser,
                      // onChanged: setGenderValue,
                      itemCount: _searchController.savedDataUser.length,
                      itemBuilder:
                          (ChoiceController<String> selection, int index) {
                        return ChoiceChip(
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color: _searchController.selectedSaveDataIndicesUser==_searchController.savedDataUser[index]
                                      ? AppColors.trans
                                      : AppColors.appBorderColor
                                      .withOpacity(0.25))),
                          backgroundColor: AppColors.trans,
                          selected: _searchController.selectedSaveDataIndicesUser==_searchController.savedDataUser[index],
                          onSelected: (bool selected) {
                            setState(() {
                              if(_searchController.selectedSaveDataIndicesUser==_searchController.savedDataUser[index]){
                                _searchController.selectedSaveDataIndicesUser='';
                              }else{
                                _searchController.selectedSaveDataIndicesUser=
                                _searchController.savedDataUser[index];
                              }

                              // Add to the set for multi-selection

                            });
                          },
                          showCheckmark: false,
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Text(_searchController.savedDataUser[index]),
                          ),
                          selectedColor: AppColors.appBlue,
                          // Change this to your desired color
                          labelStyle: TextStyle(
                            color: _searchController.selectedSaveDataIndicesUser==_searchController.savedDataUser[index]
                                ? AppColors.white
                                : AppColors.appTextColor
                                .withOpacity(0.5), // Change text color
                          ),
                        );
                      },
                      listBuilder: ChoiceList.createWrapped(),
                    ),
                    if( _searchController.selectedSaveDataIndicesUser.isEmpty)Column(
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
                                  'Select 1 or more (optional)',
                                  style: openSans.get12.w400.textColor(
                                      AppColors.appTextColor.withOpacity(0.5)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InlineChoice<String>(
                          clearable: true,
                          value: _searchController.preferenceController.masterData.value.grades!,
                          // onChanged: setGradeValue,
                          itemCount:_searchController.preferenceController.masterData.value.grades!.length,
                          itemBuilder:
                              (ChoiceController<String> selection, int index) {
                            return ChoiceChip(
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      // ignore: collection_methods_unrelated_type
                                      color: _searchController.gradeUser.contains(selection.value[index])
                                          ? AppColors.trans
                                          : AppColors.appBorderColor
                                              .withOpacity(0.25))),
                              backgroundColor: AppColors.trans,
                              selected:  _searchController.gradeUser.contains(selection.value[index]),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    _searchController.gradeUser.add(
                                        selection.value[index]); // Add to the set for multi-selection
                                  } else {
                                    _searchController.gradeUser.remove(selection.value[index]); // Remove from the set
                                  }
                                });
                              },
                              showCheckmark: false,
                              label: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                child: Text(_searchController.preferenceController.masterData.value.grades?[index]??''),
                              ),
                              selectedColor: AppColors.appBlue,
                              // Change this to your desired color
                              labelStyle: TextStyle(
                                color:  _searchController.gradeUser.contains(selection.value[index])
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
                        InlineChoice<String>(
                          clearable: true,
                          value:_searchController.preferenceController.masterData.value.schoolTypes!,
                          // onChanged: setSchoolValue,
                          itemCount:_searchController.preferenceController.masterData.value.schoolTypes!.length,
                          itemBuilder:
                              (ChoiceController<String> selection, int index) {
                            return ChoiceChip(
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color:  _searchController.selectedSchoolIndicesUser.contains( selection.value[index])
                                          ? AppColors.trans
                                          : AppColors.appBorderColor
                                              .withOpacity(0.25))),
                              backgroundColor: AppColors.trans,
                              selected: _searchController.selectedSchoolIndicesUser.contains( selection.value[index]),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    _searchController.selectedSchoolIndicesUser.add(
                                        selection.value[index]); // Add to the set for multi-selection
                                  } else {
                                    _searchController.selectedSchoolIndicesUser
                                        .remove( selection.value[index]); // Remove from the set
                                  }
                                });
                              },
                              showCheckmark: false,
                              label: Text( _searchController.preferenceController.masterData.value.schoolTypes?[index]??''),
                              selectedColor: AppColors.appBlue,
                              // Change this to your desired color
                              labelStyle: TextStyle(
                                color: _searchController.selectedSchoolIndicesUser.contains( selection.value[index])
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
                        InlineChoice<String>(
                          clearable: true,
                          value: _searchController.preferenceController.masterData.value.curriculum!,
                          // onChanged: setCurriculumValue,
                          itemCount:  _searchController.preferenceController.masterData.value.curriculum!.length,
                          itemBuilder:
                              (ChoiceController<String> selection, int index) {
                            return ChoiceChip(
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: _searchController.selectedCurriculumIndicesUser.contains( selection.value[index])
                                          ? AppColors.trans
                                          : AppColors.appBorderColor
                                              .withOpacity(0.25))),
                              backgroundColor: AppColors.trans,
                              selected: _searchController.selectedCurriculumIndicesUser.contains( selection.value[index]),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    _searchController.selectedCurriculumIndicesUser.add(
                                        selection.value[index]); // Add to the set for multi-selection
                                  } else {
                                    _searchController.selectedCurriculumIndicesUser
                                        .remove( selection.value[index]); // Remove from the set
                                  }
                                });
                              },
                              showCheckmark: false,
                              label: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                child: Text(_searchController.preferenceController.masterData.value.curriculum?[index]??''),
                              ),
                              selectedColor: AppColors.appBlue,
                              // Change this to your desired color
                              labelStyle: TextStyle(
                                color: _searchController.selectedCurriculumIndicesUser.contains( selection.value[index])
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
                                'Subject',
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
                        InlineChoice<String>(
                          clearable: true,
                          value:  _searchController.preferenceController.masterData.value.subjects!,
                          // onChanged: setSubjectValue,
                          itemCount:  _searchController.preferenceController.masterData.value.subjects!.length,
                          itemBuilder:
                              (ChoiceController<String> selection, int index) {
                            return ChoiceChip(
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: _searchController.selectedSubjectIndicesUser.contains( selection.value[index])
                                          ? AppColors.trans
                                          : AppColors.appBorderColor
                                              .withOpacity(0.25))),
                              backgroundColor: AppColors.trans,
                              selected:  _searchController.selectedSubjectIndicesUser.contains( selection.value[index]),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    _searchController.selectedSubjectIndicesUser.add(
                                        selection.value[index]); // Add to the set for multi-selection
                                  } else {
                                    _searchController.selectedSubjectIndicesUser
                                        .remove( selection.value[index]); // Remove from the set
                                  }
                                });
                              },
                              showCheckmark: false,
                              label: Text( _searchController.preferenceController.masterData.value.subjects?[index]??''),
                              selectedColor: AppColors.appBlue,
                              // Change this to your desired color
                              labelStyle: TextStyle(
                                color:  _searchController.selectedSubjectIndicesUser.contains(selection.value[index])
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
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Text('Save Search', style: openSans.get14.w500),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: FlutterSwitch(
                                  value:  _searchController.isSwitchUser,
                                  height: 16.29,
                                  width: 27.63,
                                  toggleSize: 12,
                                  activeColor: AppColors.appBlue,
                                  inactiveColor: AppColors.gray.withOpacity(0.25),
                                  onToggle: (bool value) {
                                    setState(() {
                                      _searchController.isSwitchUser = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if ( _searchController.isSwitchUser)
                           AppTextFormField(
                            hintText: 'Enter search name',
                            top: 0,
                            controller: _searchController.saveNameUser,
                          )
                        else
                          const SizedBox.shrink(),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 45, top: 30),
                      child: AppButton(
                        title: ! _searchController.isSwitchUser
                            ? 'Next for calls Details'
                            : 'Save Search and Show Results',
                        onPressed: () {

                          // ignore: unrelated_type_equality_checks
                          if(_searchController.selectedSaveDataIndicesUser==''){
                            _searchController.searchUserData=<String,dynamic >{
                              'saveSearch':_searchController.isSwitchUser,
                              if(_searchController.isSwitchUser && _searchController.saveNameUser.text!='')...<String, dynamic>{
                                'shortName': _searchController.saveNameUser.text,
                              },
                              'filters':<String, dynamic>{
                                'grades':_searchController.gradeUser.toList(),
                                'subjects':_searchController.selectedSubjectIndicesUser.toList(),
                                'schoolTypes':_searchController.selectedSchoolIndicesUser.toList(),
                                'curriculum': _searchController.selectedCurriculumIndicesUser.toList()
                              }
                            };}else{
                            _searchController.searchUserData=<String,dynamic >{
                              'saveSearch':false,
                              'filters':<String, dynamic>{
                                'shortName': _searchController.selectedSaveDataIndicesUser,
                              }
                            };
                          }
                          _searchController.searchUserData['pagination']=<String, dynamic>{
                            'pageSize':20,
                            'pageIndex': _searchController.pageUserIndex,
                            'sort': <String, dynamic>{
                              'direction': 'asc',
                              'column': 'created_at'
                            }
                          };
                          _searchController.search(selectedProfile == ApplicationConstants.tutor?SchoolEndpoint.SEARCH_STUDENTS:SchoolEndpoint.SEARCH_TUTORS, _searchController.searchUserData);
                        },
                        // ignore: avoid_bool_literals_in_conditional_expressions, unrelated_type_equality_checks
                        isDisable: _searchController.selectedSchoolIndicesUser.isNotEmpty || _searchController.selectedSubjectIndicesUser.isNotEmpty || _searchController.gradeUser.isNotEmpty  || _searchController.selectedCurriculumIndicesUser.isNotEmpty
                            ? false
                            : true,
                      ),
                    ),
                  ],
                ),
              )
            : selectedProfile == ApplicationConstants.student?Padding(
         padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
         child: _searchController.searchClassListTeacher.isNotEmpty ?GridView.builder(
           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
               maxCrossAxisExtent: 200,
               mainAxisExtent: 190,
               childAspectRatio: 3 / 2,
               crossAxisSpacing: 15,
               mainAxisSpacing: 13),
           itemCount: _searchController.searchClassListTeacher.length,
           controller: _searchController.scrollControllerUser,
           itemBuilder: (BuildContext context, int index) {
             return DetailsCardView(
                 reViewLength: 4,
                 boxShadow: AppColors.searchCardBoxShadow,
                 cardMargin: EdgeInsets.zero,
                 name: "${_searchController.searchClassListTeacher[index].firstName??''} ${_searchController.searchClassListTeacher[index].lastName??''}",
                 avatar: ImageConstants.teacherAvtar,
                 countryIcon: ImageConstants.countryIcon,
                 countryName: _searchController.searchClassListTeacher[index].nationality??'',
                 isPro: true,
                 isBookmarked: true,
                 subjects: 'Science - Accounta..');
           },
         ):
         Padding(
           padding: const EdgeInsets.only(top: 40),
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
                 _searchController.isSearchUser.value=false;
                 _searchController.searchClassList.clear();
               },
             ),
           ),
         ),
       ):Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                child: _searchController.searchClassListUser.isNotEmpty ?GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 190,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 5),
                  itemCount: _searchController.searchClassListUser.length,
                  controller: _searchController.scrollControllerUser,
                  itemBuilder: (BuildContext context, int index) {
                    return DetailsCardViewStudent(
                        name: _searchController.searchClassListUser[index].name,
                        avatar: _searchController.searchClassListUser[index].imageId?.getImageUrl('profile'),
                        isBookmarked: true,
                        grades:'Grade ${_searchController.searchClassListUser[index].grade?.join(' - ')}');
                  },
                ):
                Padding(
                  padding: const EdgeInsets.only(top: 40),
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
                        _searchController.isSearchUser.value=false;
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
