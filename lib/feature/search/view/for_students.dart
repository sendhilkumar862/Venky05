import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../config/routes/app_router.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/cardView/app_card_view.dart';
import '../../../custom/cardView/info_card_view.dart';
import '../../../custom/choice/src/inline/list.dart';
import '../../../custom/choice/src/inline/main.dart';
import '../../../custom/choice/src/selection/controller/main.dart';
import '../../../custom/divider/divider.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/typography.dart';
import '../../home_views/views/reupload_documents.dart';


class ForStudents extends StatefulWidget {
  const ForStudents({super.key});

  @override
  State<ForStudents> createState() => _ForStudentsState();
}

class _ForStudentsState extends State<ForStudents> {
  Set<int> selectedSchoolIndices = <int>{};
  Set<int> grade = <int>{};
  Set<int> selectedSubjectIndices = <int>{};
  bool isSwitch = false;
  bool showResult = false;
  int notFound = 0;
  bool isPending = true;
  TextEditingController saveName = TextEditingController();
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

  void setGradeValue(List<String> value) {
    setState(() => gradeList = value);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: !showResult ? Column(
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
                            color:
                            grade.contains(index)
                                ? AppColors.trans
                                : AppColors.appBorderColor.withOpacity(0.25))),
                    backgroundColor: AppColors.trans,
                    selected: grade.contains(index),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          grade.add(
                              index); // Add to the set for multi-selection
                        } else {
                          grade
                              .remove(index); // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Text(gradeList[index]),
                    ),
                    selectedColor: AppColors
                        .appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: grade.contains(index)
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
                value: schoolList,
                onChanged: setSchoolValue,
                itemCount: schoolList.length,
                itemBuilder:
                    (ChoiceController<String> selection, int index) {
                  return ChoiceChip(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color:
                            selectedSchoolIndices.contains(index)
                                ? AppColors.trans
                                : AppColors.appBorderColor.withOpacity(0.25))),
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
                    selectedColor: AppColors
                        .appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: selectedSchoolIndices.contains(index)
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
                            color:
                            selectedSubjectIndices.contains(index)
                                ? AppColors.trans
                                : AppColors.appBorderColor.withOpacity(0.25))),
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
                    selectedColor: AppColors
                        .appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: selectedSubjectIndices.contains(index)
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
                  children: [
                    Text('Save Search', style: openSans.get14.w500),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: FlutterSwitch(
                        value: isSwitch,
                        height: 16.29,
                        width: 27.63,
                        toggleSize: 12,
                        activeColor: AppColors.appBlue,
                        inactiveColor: AppColors.gray.withOpacity(0.25),
                        onToggle: (bool value) {
                          setState(() {
                            isSwitch = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (isSwitch) AppTextFormField(
                controller: saveName,
                hintText: 'Enter search name',
                top: 0,
              ) else
                const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.only(bottom: 45, top: 30),

                child: AppButton(
                  title: !isSwitch ? 'Search' : 'Save Search and Show Results',
                  onPressed: () {
                    setState(() {
                      showResult = true;
                    });
                  },
                  isDisable: selectedSchoolIndices.isNotEmpty ||
                      selectedSubjectIndices.isNotEmpty || grade.isNotEmpty
                      ? false
                      : true,
                ),
              ),
            ],
          ) : notFound == 1 ? ListView.separated(
            padding: const EdgeInsets.only(
                right: 15, top: 5, bottom: 20, left: 15),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 3 ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return AppCardView(
                proposals: 5,
                cardTitle: 'Math',
                date: '12/12 12:30pm',
                timer: '1h 30m',
                money: '5.500 KWD',
                status: 'PENDING',
                isPro: true,
                avtar: ImageConstants.teacherAvtar,
                countryIcon: ImageConstants.countryIcon,
                countryName: 'Kuwait',
                reViewLength: 3,
                teacherName: 'Ahmed Ali',
                buttonTap: () {},
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 15,
              );
            },
          ) : Padding(
            padding: const EdgeInsets.only(top: 60),
            child: InfoCardVIew(
              isPending: isPending,
              isShowButton: true,
              isSupport: false,
              title: 'No Results Found!',
              subTitle:
              'No results found. Please refine your search.',
              cardColor: AppColors.white,
              buttonTitle: 'Modify Search',
              buttonTap: () {
                if (isPending) {
                  setState(() {
                    isPending = !isPending;
                  });
                } else {
                  AppRouter.push(const ReUploadDocument());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}


