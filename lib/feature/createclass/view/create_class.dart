import 'package:flutter/material.dart';

import '../../../core/typography.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/choice/src/inline/list.dart';
import '../../../custom/choice/src/inline/main.dart';
import '../../../custom/choice/src/selection/controller/main.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../class_detail/class_detail.dart';

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
  Set<int> isGradeSelect = <int>{};
  Set<int> isSchoolSelect = <int>{};
  Set<int> isSubjectSelect = <int>{};

  void setSchoolValue(List<String> value) {
    setState(() => school = value);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    // var std
    // List<EmiAmount> emiData = [
    //   EmiAmount(std:"6 Month" ),
    // ];
    return Scaffold(
      appBar: HessaAppBar(
        trailingText: 'Cancel',
        titleText: 'Create Class',
        normalAppbar: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Class Info',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text('Grade',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
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
                            color: isGradeSelect.contains(index)
                                ? AppColors.trans
                                : AppColors.appBorderColor)),
                    backgroundColor: AppColors.trans,
                    selected: isGradeSelect.contains(index),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          isGradeSelect
                              .add(index); // Add to the set for multi-selection
                        } else {
                          isGradeSelect.remove(index); // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(grade[index], style: poppins.get12.w600),
                    ),
                    selectedColor: AppColors.appColor,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: isGradeSelect.contains(index)
                          ? AppColors.white
                          : AppColors.black, // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              const Divider(),
              const Text('School',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              InlineChoice<String>(
                clearable: true,
                value: school,
                onChanged: setSchoolValue,
                itemCount: school.length,
                itemBuilder: (ChoiceController<String> selection, int index) {
                  return ChoiceChip(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: isSchoolSelect.contains(index)
                                ? AppColors.trans
                                : AppColors.appBorderColor)),
                    backgroundColor: AppColors.trans,
                    selected: isSchoolSelect.contains(index),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          isSchoolSelect
                              .add(index); // Add to the set for multi-selection
                        } else {
                          isSchoolSelect.remove(index); // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Text(school[index], style: poppins.get12.w600),
                    selectedColor: AppColors.appColor,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: isSchoolSelect.contains(index)
                          ? AppColors.white
                          : AppColors.black, // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Subject',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
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
                            color: isSubjectSelect.contains(index)
                                ? AppColors.trans
                                : AppColors.appBorderColor)),
                    backgroundColor: AppColors.trans,
                    selected: isSubjectSelect.contains(index),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          isSubjectSelect
                              .add(index); // Add to the set for multi-selection
                        } else {
                          isSubjectSelect.remove(index); // Remove from the set
                        }
                      });
                    },
                    showCheckmark: false,
                    label: Text(subject[index], style: poppins.get12.w600),
                    selectedColor: AppColors.appColor,
                    // Change this to your desired color
                    labelStyle: TextStyle(
                      color: isSubjectSelect.contains(index)
                          ? AppColors.white
                          : AppColors.black, // Change text color
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(),
              ),
              const Divider(),
              const AppTextFormField(
                minLines: 4,
                maxLines: 10,
                hintText: 'Class Summary',
                borderColor: AppColors.appColor,
                titleColor: AppColors.appColor,
                title: 'Class Summary',
                top: 0,
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
                  title: 'Next for Class Details',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClassDetail()),
                    );
                  },
                  isDisable: false)
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
