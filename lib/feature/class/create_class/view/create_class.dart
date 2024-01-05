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
import '../../class_detail/controller/class_detail_controller.dart';

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
  final ClassDetailController _classDetailController =Get.put(ClassDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        trailingText: 'cancel'.tr,
        title: 'createClass'.tr,
        isBack: false,
      ),
      body: Obx(()=>
          _classDetailController.masterData.value.schoolTypes!=null?
          SingleChildScrollView(
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
                if(_classDetailController.masterData.value.grades!=null)InlineChoice<String>(
                  clearable: true,
                  value: _classDetailController.masterData.value.grades!,
                  // onChanged: _classDetailController.setSchoolValue,
                  itemCount: _classDetailController.masterData.value.grades!.length,
                  itemBuilder: (ChoiceController<String> selection, int index) {
                    return ChoiceChip(
                      shape: StadiumBorder(
                          side: BorderSide(
                              color: _classDetailController.isGradeSelect == index
                                  ? AppColors.trans
                                  : AppColors.appBorderColor)),
                      backgroundColor: AppColors.trans,
                      selected: _classDetailController.isGradeSelect == index,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _classDetailController.isGradeSelect =
                                index; // Add to the set for multi-selection
                          } else {
                            _classDetailController.isGradeSelect = -1; // Remove from the set
                          }
                        });
                      },
                      showCheckmark: false,
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(_classDetailController.masterData.value.grades![index], style: openSans.get12.w600),
                      ),
                      selectedColor: AppColors.appBlue,
                      // Change this to your desired color
                      labelStyle: TextStyle(
                        color: _classDetailController.isGradeSelect == index
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
                  value:_classDetailController.masterData.value.schoolTypes!,
                  // onChanged: _classDetailController.setSchoolValue,
                  itemCount: _classDetailController.masterData.value.schoolTypes!.length,
                  itemBuilder: (ChoiceController<String> selection, int index) {
                    return ChoiceChip(
                      shape: StadiumBorder(
                          side: BorderSide(
                              color: _classDetailController.isSchoolSelect == index
                                  ? AppColors.trans
                                  : AppColors.appBorderColor)),
                      backgroundColor: AppColors.trans,
                      selected: _classDetailController.isSchoolSelect == index,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _classDetailController.isSchoolSelect =
                                index; // Add to the set for multi-selection
                          } else {
                            _classDetailController.isSchoolSelect = -1; // Remove from the set
                          }
                        });
                      },
                      showCheckmark: false,
                      label: Text(_classDetailController.masterData.value.schoolTypes![index], style: openSans.get12.w600),
                      selectedColor: AppColors.appBlue,
                      // Change this to your desired color
                      labelStyle: TextStyle(
                        color: _classDetailController.isSchoolSelect == index
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
                  value: _classDetailController.masterData.value.subjects!,
                  // onChanged: _classDetailController.setSchoolValue,
                  itemCount: _classDetailController.masterData.value.subjects!.length,
                  itemBuilder: (ChoiceController<String> selection, int index) {
                    return ChoiceChip(
                      shape: StadiumBorder(
                          side: BorderSide(
                              color: _classDetailController.isSubjectSelect == index
                                  ? AppColors.trans
                                  : AppColors.appBorderColor)),
                      backgroundColor: AppColors.trans,
                      selected: _classDetailController.isSubjectSelect == index,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _classDetailController.isSubjectSelect =
                                index; // Add to the set for multi-selection
                          } else {
                            _classDetailController.isSubjectSelect = -1; // Remove from the set
                          }
                        });
                      },
                      showCheckmark: false,
                      label: Text(_classDetailController.masterData.value.subjects![index], style: openSans.get12.w600),
                      selectedColor: AppColors.appBlue,
                      // Change this to your desired color
                      labelStyle: TextStyle(
                        color: _classDetailController.isSubjectSelect == index
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
                  controller:  _classDetailController.classSummaryController,
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
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  isDisable: _classDetailController.isGradeSelect!=-1 && _classDetailController.isSchoolSelect!=-1 && _classDetailController.isSubjectSelect!=-1?  false:true,
                  title: 'nextForClassDetails'.tr,
                  onPressed: () {
                    if(_classDetailController.isGradeSelect!=-1 && _classDetailController.isSchoolSelect!=-1 && _classDetailController.isGradeSelect!=-1) {
                      Get.toNamed(Routes.classDetail);
                    }
                  },
                )
              ],
            ),
          ),
        ):
          const SizedBox.shrink(),
      ),
    );
  }
}
