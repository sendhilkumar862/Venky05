import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';
import '../controller/teaching_info_controller.dart';

class TeachingInfo extends StatefulWidget {
  const TeachingInfo({super.key});

  @override
  State<TeachingInfo> createState() => _TeachingInfoState();
}

class _TeachingInfoState extends State<TeachingInfo> {
  final TeachingInfoController _teachingInfoController = Get.put(TeachingInfoController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final TeachingInfoViewModel teachingInfoStore = Provider.of<TeachingInfoViewModel>(context);
    return Scaffold(
      appBar: HessaAppBar(
        trailingText: 'Cancel',
        title: 'Complete Profile',
        isTitleOnly: true,
        trailingTap: ()=> Navigator.popUntil(context, ModalRoute.withName(Routes.HomeScreenRoute)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Text('Teaching Information',
                  style: openSans.get20.w700.appTextColor),
            ),
            AppTextFormField(
              controller: _teachingInfoController.gradeController,
              onTap: () {
                bottomSheetDropDownList(
                    listData: _teachingInfoController.gradeList,
                    selectedList: _teachingInfoController.selectedGrade,
                    onTap: (int index) {
                      setState(() {
                        _teachingInfoController
                            .addGrade(_teachingInfoController.gradeList[index]);
                        _teachingInfoController.gradeController.text =
                            _teachingInfoController
                                .listToCommaSeparatedString(
                                _teachingInfoController.selectedGrade)
                                .replaceAll(',', ' -');
                      });
                    });
              },
              top: 10,
              readOnly: true,
              title: 'Grade',
              hintText: 'Select grade/s',
              suffix: const Icon(Icons.keyboard_arrow_down),
            ),
            AppTextFormField(
              controller: _teachingInfoController.subjectController,
              onTap: () {
                bottomSheetDropDownList(
                  listData: _teachingInfoController.subjectList,
                  selectedList: _teachingInfoController.selectedSubject,
                  onTap: (int index) {
                    setState(() {
                      _teachingInfoController.addSubject(
                          _teachingInfoController.subjectList[index]);
                      _teachingInfoController.subjectController.text =
                          _teachingInfoController
                              .listToCommaSeparatedString(
                              _teachingInfoController.selectedSubject)
                              .replaceAll(',', ' -');
                    });
                  },
                );
              },
              readOnly: true,
              title: 'Subject Taught',
              hintText: 'Select subject/s',
              suffix: const Icon(Icons.keyboard_arrow_down),
            ),
            AppTextFormField(
              controller: _teachingInfoController.schoolController,
              onTap: () {
                bottomSheetDropDownList(
                  listData: _teachingInfoController.schoolTypeList,
                  selectedList: _teachingInfoController.selectedSchoolType,
                  onTap: (int index) {
                    setState(() {
                      _teachingInfoController.addSchoolType(
                          _teachingInfoController.schoolTypeList[index]);
                      _teachingInfoController.schoolController.text =
                          _teachingInfoController
                              .listToCommaSeparatedString(
                              _teachingInfoController.selectedSchoolType)
                              .replaceAll(',', ' -');
                    });
                  },
                );
              },
              readOnly: true,
              title: 'School Type',
              hintText: 'Select school type',
              suffix: const Icon(Icons.keyboard_arrow_down),
            ),
            AppTextFormField(
              controller: _teachingInfoController.curriculumController,
              onTap: () {
                bottomSheetDropDownList(
                  listData: _teachingInfoController.curriculumTypeList,
                  selectedList: _teachingInfoController.selectedCurriculum,
                  onTap: (int index) {
                    _teachingInfoController.addCurriculum(
                        _teachingInfoController.curriculumTypeList[index]);
                    _teachingInfoController.curriculumController.text =
                        _teachingInfoController
                            .listToCommaSeparatedString(
                            _teachingInfoController.selectedCurriculum)
                            .replaceAll(',', ' -');
                  },
                );
              },
              readOnly: true,
              title: 'Curriculum',
              hintText: 'Select curriculum',
              suffix: const Icon(Icons.keyboard_arrow_down),
            ),
            AppTextFormField(
              controller: _teachingInfoController.classTypeController,
              onTap: () {
                bottomSheetDropDownList(
                  listData: _teachingInfoController.classTypeList,
                  selectedList: _teachingInfoController.selectedClassType,
                  onTap: (int index) {
                    setState(() {
                      _teachingInfoController.addClassType(
                          _teachingInfoController.classTypeList[index]);
                      _teachingInfoController.classTypeController.text =
                          _teachingInfoController
                              .listToCommaSeparatedString(
                              _teachingInfoController.selectedClassType)
                              .replaceAll(',', ' -');
                    });
                  },
                );
              },
              readOnly: true,
              title: 'Type Of Class',
              hintText: 'Select class type',
              suffix: Icon(Icons.keyboard_arrow_down),
            ),
            SizedBox(height: 40.px),
            Observer(builder: (_) {
              return AppButton(
                  title: 'Continue Experience Information',
                  onPressed: () {
                    if( _teachingInfoController.gradeController.text.isNotEmpty &&
                        _teachingInfoController
                            .classTypeController.text.isNotEmpty &&
                        _teachingInfoController
                            .curriculumController.text.isNotEmpty &&
                        _teachingInfoController
                            .schoolController.text.isNotEmpty &&
                        _teachingInfoController
                            .subjectController.text.isNotEmpty
                    ) {
                      _teachingInfoController.teachingInformationUpdate();
                    }
                  },
                  isDisable:
                  _teachingInfoController.gradeController.text.isNotEmpty &&
                      _teachingInfoController
                          .classTypeController.text.isNotEmpty &&
                      _teachingInfoController
                          .curriculumController.text.isNotEmpty &&
                      _teachingInfoController
                          .schoolController.text.isNotEmpty &&
                      _teachingInfoController
                          .subjectController.text.isNotEmpty
                      ? false
                      : true);
            })

            // teachingInfoStore.selectedCurriculum.isNotEmpty && teachingInfoStore.selectedSchoolType.isNotEmpty && teachingInfoStore.selectedClassType.isNotEmpty && teachingInfoStore.selectedGrade.isNotEmpty && teachingInfoStore.schoolTypeList.isNotEmpty ?false:true)
          ],
        ),
      ),
    ) ;
  }

  void bottomSheetDropDownList({
    required List<String> listData,
    required List<String> selectedList,
    required Function(int) onTap,
  }) {
    final double width = MediaQuery.sizeOf(context).width;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('Class Duration', style: openSans.get14.w700),
                            SizedBox(
                              width: width * 0.25,
                            ),
                            Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.downArrowColor
                                        .withOpacity(0.15)),
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
                          title: Text(listData[index],
                              style: openSans.get16.w400
                                  .textColor(AppColors.appTextColor)),
                          onTap: () {

                            onTap(
                                index);
                            setState((){});// Pass the value to the onTap function
                          },
                          trailing: selectedList.contains(listData[index])
                              ? const Icon(
                                  Icons.check_circle,
                                  color: AppColors.appBlue,
                                )
                              : Icon(
                                  Icons.circle_outlined,
                                  color: AppColors.downArrowColor
                                      .withOpacity(0.25),
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
