import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/routes/route.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/choice/src/inline/list.dart';
import '../../../../custom/choice/src/inline/main.dart';
import '../../../../custom/choice/src/selection/controller/main.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';

class SchoolList {
  SchoolList({
    required this.isSelect,
    required this.title,
  });

  final String title;
  late bool isSelect;
}

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
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
    setState(() => school = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        trailingText: 'cancel'.tr,
        title: 'createClass'.tr,
        isBack: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'classInfo'.tr,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('grade'.tr,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
              ),
              InlineChoice<String>(
                clearable: true,
                value: grade,
                onChanged: setSchoolValue,
                itemCount: grade.length,
                itemBuilder: (ChoiceController<String> selection, int index) {
                  return ChoiceChip(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: isGradeSelect == index
                                ? AppColors.trans
                                : AppColors.appBorderColor)),
                    backgroundColor: AppColors.trans,
                    selected: isGradeSelect == index,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          isGradeSelect =
                              index; // Add to the set for multi-selection
                        } else {
                          isGradeSelect = -1; // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(grade[index], style: openSans.get12.w600),
                    ),
                    selectedColor: AppColors.appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: isGradeSelect == index
                          ? AppColors.white
                          : AppColors.black, // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              const Divider(),
              Text('school'.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
              InlineChoice<String>(
                clearable: true,
                value: school,
                onChanged: setSchoolValue,
                itemCount: school.length,
                itemBuilder: (ChoiceController<String> selection, int index) {
                  return ChoiceChip(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: isSchoolSelect == index
                                ? AppColors.trans
                                : AppColors.appBorderColor)),
                    backgroundColor: AppColors.trans,
                    selected: isSchoolSelect == index,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          isSchoolSelect =
                              index; // Add to the set for multi-selection
                        } else {
                          isSchoolSelect = -1; // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Text(school[index], style: openSans.get12.w600),
                    selectedColor: AppColors.appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: isSchoolSelect == index
                          ? AppColors.white
                          : AppColors.black, // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('subject'.tr,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
              ),
              InlineChoice<String>(
                clearable: true,
                value: subject,
                onChanged: setSchoolValue,
                itemCount: subject.length,
                itemBuilder: (ChoiceController<String> selection, int index) {
                  return ChoiceChip(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: isSubjectSelect == index
                                ? AppColors.trans
                                : AppColors.appBorderColor)),
                    backgroundColor: AppColors.trans,
                    selected: isSubjectSelect == index,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          isSubjectSelect =
                              index; // Add to the set for multi-selection
                        } else {
                          isSubjectSelect = -1; // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Text(subject[index], style: openSans.get12.w600),
                    selectedColor: AppColors.appBlue,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: isSubjectSelect == index
                          ? AppColors.white
                          : AppColors.black, // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              const Divider(),
              AppTextFormField(
                minLines: 4,
                maxLines: 10,
                hintText: 'classSummary'.tr,
                borderColor: AppColors.appBlue,
                titleColor: AppColors.appBlue,
                title: 'classSummary'.tr,
                top: 0,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 15,
                ),
                child: Divider(
                  height: 1,
                  color: Color(0xffC5CEEE),
                ),
              ),
              AppButton(
                isDisable: false,
                title: 'nextForClassDetails'.tr,
                onPressed: () {
                  Get.toNamed(Routes.classDetail);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmiAmount {
  EmiAmount({
    required this.std,
  });

  final String std;
}
