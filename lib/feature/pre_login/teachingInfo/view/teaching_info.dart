import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';
import '../viewModel/teaching_info_view_model.dart';

class TeachingInfo extends StatefulWidget {
  const TeachingInfo({super.key});

  @override
  State<TeachingInfo> createState() => _TeachingInfoState();
}

class _TeachingInfoState extends State<TeachingInfo> {
  TextEditingController gradeController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController curriculumController = TextEditingController();
  TextEditingController classTypeController = TextEditingController();
  int? isSelected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final TeachingInfoViewModel teachingInfoStore = Provider.of<TeachingInfoViewModel>(context);
    return BaseView<TeachingInfoViewModel>(
        viewModel: TeachingInfoViewModel(),
        onModelReady: (TeachingInfoViewModel model, WidgetRef ref) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, TeachingInfoViewModel teachingInfoStore,WidgetRef ref ) {
          return Scaffold(
            appBar: HessaAppBar(
              isBack: true,
              trailingText: 'Cancel',
              title: 'Complete Profile',
              isTitleOnly: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 28),
                    child: Text('Teaching Information', style: openSans.get20.w700.appTextColor),
                  ),
                  AppTextFormField(
                    controller: gradeController,
                    onTap: () {
                      bottomSheetDropDownList(
                          listData: teachingInfoStore.gradeList ,
                          selectedList: teachingInfoStore.selectedGrade,
                          teachingInfoStore: teachingInfoStore,
                          onTap: (int index) {
                            teachingInfoStore.addGrade(teachingInfoStore.gradeList[index]);
                            gradeController.text = teachingInfoStore
                                .listToCommaSeparatedString(teachingInfoStore.selectedGrade)
                                .replaceAll(',', ' -');
                          });
                    },
                    top: 10,
                    readOnly: true,
                    title: 'Grade',
                    hintText: 'Select grade/s',
                    suffix: const Icon(Icons.keyboard_arrow_down),
                  ),
                  AppTextFormField(
                    controller: subjectController,
                    onTap: () {
                      bottomSheetDropDownList(
                        listData: teachingInfoStore.subjectList ,
                        selectedList: teachingInfoStore.selectedSubject,
                        teachingInfoStore: teachingInfoStore,
                        onTap: (int index) {
                          teachingInfoStore.addSubject(teachingInfoStore.subjectList[index]);
                          subjectController.text = teachingInfoStore
                              .listToCommaSeparatedString(teachingInfoStore.selectedSubject)
                              .replaceAll(',', ' -');
                        },
                      );
                    },
                    readOnly: true,
                    title: 'Subject Taught',
                    hintText: 'Select subject/s',
                    suffix: Icon(Icons.keyboard_arrow_down),
                  ),
                  AppTextFormField(
                    controller: schoolController,
                    onTap: () {
                      bottomSheetDropDownList(
                        listData: teachingInfoStore.schoolTypeList ,
                        selectedList: teachingInfoStore.selectedSchoolType,
                        teachingInfoStore: teachingInfoStore,
                        onTap: (int index) {
                          teachingInfoStore.addSchoolType(teachingInfoStore.schoolTypeList[index]);
                          schoolController.text = teachingInfoStore
                              .listToCommaSeparatedString(teachingInfoStore.selectedSchoolType)
                              .replaceAll(',', ' -');
                        },
                      );
                    },
                    readOnly: true,
                    title: 'School Type',
                    hintText: 'Select school type',
                    suffix: Icon(Icons.keyboard_arrow_down),
                  ),
                  AppTextFormField(
                    controller: curriculumController,
                    onTap: () {
                      bottomSheetDropDownList(
                        listData: teachingInfoStore.curriculumTypeList,
                        selectedList: teachingInfoStore.selectedCurriculum,
                        teachingInfoStore: teachingInfoStore,
                        onTap: (int index) {
                          teachingInfoStore.addCurriculum(teachingInfoStore.curriculumTypeList[index]);
                          curriculumController.text = teachingInfoStore
                              .listToCommaSeparatedString(teachingInfoStore.selectedCurriculum)
                              .replaceAll(',', ' -');
                        },
                      );
                    },
                    readOnly: true,
                    title: 'Curriculum',
                    hintText: 'Select curriculum',
                    suffix: Icon(Icons.keyboard_arrow_down),
                  ),
                  AppTextFormField(
                    controller: classTypeController,
                    onTap: () {
                      bottomSheetDropDownList(
                        listData: teachingInfoStore.classTypeList ,
                        selectedList: teachingInfoStore.selectedClassType,
                        teachingInfoStore: teachingInfoStore,
                        onTap: (int index) {
                          teachingInfoStore.addClassType(teachingInfoStore.classTypeList[index]);
                          classTypeController.text = teachingInfoStore
                              .listToCommaSeparatedString(teachingInfoStore.selectedClassType)
                              .replaceAll(',', ' -');
                        },
                      );
                    },
                    readOnly: true,
                    title: 'Type Of Class',
                    hintText: 'Select class type',
                    suffix: Icon(Icons.keyboard_arrow_down),
                  ),
                  SizedBox(height: 40.px),
                  AppButton(
                      title: 'Continue Experience Information',
                      onPressed: () {
                       teachingInfoStore.teachingInformationUpdate();
                      },
                      isDisable: false)
                      // teachingInfoStore.selectedCurriculum.isNotEmpty && teachingInfoStore.selectedSchoolType.isNotEmpty && teachingInfoStore.selectedClassType.isNotEmpty && teachingInfoStore.selectedGrade.isNotEmpty && teachingInfoStore.schoolTypeList.isNotEmpty ?false:true)
                ],
              ),
            ),
          );
        });
  }

  void bottomSheetDropDownList({
    required List<String> listData,
    required List<String> selectedList,
    required TeachingInfoViewModel teachingInfoStore,
    required Function(int) onTap,
  }) {
    final double width = MediaQuery.sizeOf(context).width;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                        Text('Class Duration', style: openSans.get14.w700),
                        SizedBox(
                          width: width * 0.25,
                        ),
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.downArrowColor.withOpacity(0.15)),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 15,
                              ),
                            ))
                      ]),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemCount: listData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Observer(builder: (_) {
                        return ListTile(
                          title: Text(listData[index], style: openSans.get16.w400.textColor(AppColors.appTextColor)),
                          onTap: () {
                            onTap(index); // Pass the value to the onTap function
                          },
                          trailing: selectedList.contains(listData[index])
                              ? const Icon(
                                  Icons.check_circle,
                                  color: AppColors.appBlue,
                                )
                              : Icon(
                                  Icons.circle_outlined,
                                  color: AppColors.downArrowColor.withOpacity(0.25),
                                ),
                        );
                      });
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
