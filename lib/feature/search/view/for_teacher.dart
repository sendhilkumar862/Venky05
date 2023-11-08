import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/cardView/details_card_view.dart';
import '../../../custom/choice/src/inline/list.dart';
import '../../../custom/choice/src/inline/main.dart';
import '../../../custom/choice/src/selection/controller/main.dart';
import '../../../custom/divider/divider.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/typography.dart';

class ForTeacher extends StatefulWidget {
  const ForTeacher({Key? key}) : super(key: key);

  @override
  State<ForTeacher> createState() => _ForTeacherState();
}

class _ForTeacherState extends State<ForTeacher> {
  Set<int> selectedSchoolIndices = <int>{};
  Set<int> grade = <int>{};
  Set<int> selectedSubjectIndices = <int>{};
  Set<int> selectedGenderIndices = <int>{};
  Set<int> selectedCurriculumIndices = <int>{};
  bool showResult = false;
  bool isSwitch = false;
  List<String> subjectList = <String>[
    'Arabic',
    'Math',
    'Science',
    'Islamic',
    'Physics',
    'Chemistry',
    'English',
    'French',
    'Deutsch',
    'Arts',
  ];
  List<String> gradeList = <String>[
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
  List<String> schoolList = <String>[
    'Public',
    'Private',
  ];
  List<String> genderList = <String>[
    'Male',
    'Female',
  ];
  List<String> curriculumList = <String>[
    'Arabic',
    'American',
    'British',
  ];

  void setGradeValue(List<String> value) {
    setState(() => gradeList = value);
  }

  void setCurriculumValue(List<String> value) {
    setState(() => curriculumList = value);
  }

  void setGenderValue(List<String> value) {
    setState(() => genderList = value);
  }

  void setSchoolValue(List<String> value) {
    setState(() => schoolList = value);
  }

  void setSubjectValue(List<String> value) {
    setState(() => subjectList = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !showResult
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'gender'.tr(),
                          style: openSans.get16.w700
                              .textColor(AppColors.appTextColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'optional'.tr(),
                            style: openSans.get12.w400.textColor(
                                AppColors.appTextColor.withOpacity(0.5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InlineChoice<String>(
                    clearable: true,
                    value: genderList,
                    onChanged: setGenderValue,
                    itemCount: genderList.length,
                    itemBuilder:
                        (ChoiceController<String> selection, int index) {
                      return ChoiceChip(
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: selectedGenderIndices.contains(index)
                                    ? AppColors.trans
                                    : AppColors.appBorderColor
                                        .withOpacity(0.25))),
                        backgroundColor: AppColors.trans,
                        selected: selectedGenderIndices.contains(index),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              selectedGenderIndices.add(
                                  index); // Add to the set for multi-selection
                            } else {
                              selectedGenderIndices
                                  .remove(index); // Remove from the set
                            }
                          });
                        },
                        showCheckmark: false,
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(genderList[index]),
                        ),
                        selectedColor: AppColors.appBlue,
                        // Change this to your desired color
                        labelStyle: TextStyle(
                          color: selectedGenderIndices.contains(index)
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
                          'grade'.tr(),
                          style: openSans.get16.w700
                              .textColor(AppColors.appTextColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'select1OrMoreOptional'.tr(),
                            style: openSans.get12.w400.textColor(
                                AppColors.appTextColor.withOpacity(0.5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InlineChoice<String>(
                    clearable: true,
                    value: gradeList,
                    onChanged: setGradeValue,
                    itemCount: gradeList.length,
                    itemBuilder:
                        (ChoiceController<String> selection, int index) {
                      return ChoiceChip(
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: grade.contains(index)
                                    ? AppColors.trans
                                    : AppColors.appBorderColor
                                        .withOpacity(0.25))),
                        backgroundColor: AppColors.trans,
                        selected: grade.contains(index),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              grade.add(
                                  index); // Add to the set for multi-selection
                            } else {
                              grade.remove(index); // Remove from the set
                            }
                          });
                        },
                        showCheckmark: false,
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(gradeList[index]),
                        ),
                        selectedColor: AppColors.appBlue,
                        // Change this to your desired color
                        labelStyle: TextStyle(
                          color: grade.contains(index)
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
                          'school'.tr(),
                          style: openSans.get16.w700
                              .textColor(AppColors.appTextColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'optional'.tr(),
                            style: openSans.get12.w400.textColor(
                                AppColors.appTextColor.withOpacity(0.5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InlineChoice<String>(
                    clearable: true,
                    value: schoolList,
                    onChanged: setSchoolValue,
                    itemCount: schoolList.length,
                    itemBuilder:
                        (ChoiceController<String> selection, int index) {
                      return ChoiceChip(
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: selectedSchoolIndices.contains(index)
                                    ? AppColors.trans
                                    : AppColors.appBorderColor
                                        .withOpacity(0.25))),
                        backgroundColor: AppColors.trans,
                        selected: selectedSchoolIndices.contains(index),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              selectedSchoolIndices.add(
                                  index); // Add to the set for multi-selection
                            } else {
                              selectedSchoolIndices
                                  .remove(index); // Remove from the set
                            }
                          });
                        },
                        showCheckmark: false,
                        label: Text(schoolList[index]),
                        selectedColor: AppColors.appBlue,
                        // Change this to your desired color
                        labelStyle: TextStyle(
                          color: selectedSchoolIndices.contains(index)
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
                          'curriculum'.tr(),
                          style: openSans.get20.w700
                              .textColor(AppColors.appTextColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'optional'.tr(),
                            style: openSans.get12.w400.textColor(
                                AppColors.appTextColor.withOpacity(0.5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InlineChoice<String>(
                    clearable: true,
                    value: curriculumList,
                    onChanged: setCurriculumValue,
                    itemCount: curriculumList.length,
                    itemBuilder:
                        (ChoiceController<String> selection, int index) {
                      return ChoiceChip(
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: selectedCurriculumIndices.contains(index)
                                    ? AppColors.trans
                                    : AppColors.appBorderColor
                                        .withOpacity(0.25))),
                        backgroundColor: AppColors.trans,
                        selected: selectedCurriculumIndices.contains(index),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              selectedCurriculumIndices.add(
                                  index); // Add to the set for multi-selection
                            } else {
                              selectedCurriculumIndices
                                  .remove(index); // Remove from the set
                            }
                          });
                        },
                        showCheckmark: false,
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(curriculumList[index]),
                        ),
                        selectedColor: AppColors.appBlue,
                        // Change this to your desired color
                        labelStyle: TextStyle(
                          color: selectedCurriculumIndices.contains(index)
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
                          'subject'.tr(),
                          style: openSans.get16.w700
                              .textColor(AppColors.appTextColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'optional'.tr(),
                            style: openSans.get12.w400.textColor(
                                AppColors.appTextColor.withOpacity(0.5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InlineChoice<String>(
                    clearable: true,
                    value: subjectList,
                    onChanged: setSubjectValue,
                    itemCount: subjectList.length,
                    itemBuilder:
                        (ChoiceController<String> selection, int index) {
                      return ChoiceChip(
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: selectedSubjectIndices.contains(index)
                                    ? AppColors.trans
                                    : AppColors.appBorderColor
                                        .withOpacity(0.25))),
                        backgroundColor: AppColors.trans,
                        selected: selectedSubjectIndices.contains(index),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              selectedSubjectIndices.add(
                                  index); // Add to the set for multi-selection
                            } else {
                              selectedSubjectIndices
                                  .remove(index); // Remove from the set
                            }
                          });
                        },
                        showCheckmark: false,
                        label: Text(subjectList[index]),
                        selectedColor: AppColors.appBlue,
                        // Change this to your desired color
                        labelStyle: TextStyle(
                          color: selectedSubjectIndices.contains(index)
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
                      children: [
                        Text('saveSearch'.tr(), style: openSans.get14.w500),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: FlutterSwitch(
                            value: isSwitch,
                            height: 16.29,
                            width: 27.63,
                            toggleSize: 12,
                            activeColor: AppColors.appBlue,
                            inactiveColor: AppColors.gray.withOpacity(0.25),
                            onToggle: (value) {
                              setState(() {
                                isSwitch = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSwitch)
                    AppTextFormField(
                      hintText: 'enterSearchName'.tr(),
                      top: 0,
                    )
                  else
                    SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45, top: 30),
                    child: AppButton(
                      title: !isSwitch
                          ? 'nextForCallsDetails'.tr()
                          : 'saveSearchAndShowResults'.tr(),
                      onPressed: () {
                        setState(() {
                          showResult = true;
                        });
                      },
                      isDisable: selectedSchoolIndices.isNotEmpty ||
                              selectedSubjectIndices.isNotEmpty ||
                              grade.isNotEmpty
                          ? false
                          : true,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 190,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 13),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return DetailsCardView(
                      reViewLength: 4,
                      boxShadow: AppColors.searchCardBoxShadow,
                      cardMargin: EdgeInsets.zero,
                      name: 'userName'.tr(),
                      avatar: ImageConstants.teacherAvtar,
                      countryIcon: ImageConstants.countryIcon,
                      countryName: 'Kuwait',
                      isPro: true,
                      isBookmarked: true,
                      subjects: 'science'.tr());
                },
              ),
            ),
    );
  }
}
