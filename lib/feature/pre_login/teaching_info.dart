import 'package:flutter/material.dart';

import '../../config/routes/app_router.dart';
import '../../config/routes/routes.dart';
import '../../custom/app_button/app_button.dart';
import '../../custom/app_textformfield/app_field.dart';
import '../../custom/appbar/appbar.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/typography.dart';

class TeachingInfo extends StatefulWidget {
  const TeachingInfo({super.key});

  @override
  State<TeachingInfo> createState() => _TeachingInfoState();
}

class _TeachingInfoState extends State<TeachingInfo> {
  TextEditingController gradeController = TextEditingController();
  TextEditingController gradeController1 = TextEditingController();
  List<String> listData = <String>[
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
  List<String> listData1 = <String>[
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
  int? isSelected;
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(top: 30),
              child: Text('Teaching Information',
                  style: openSans.get20.w700.appTextColor),
            ),
            AppTextFormField(
              controller: gradeController,
              onTap: () {
                bottomSheetDropDownList(
                    listData: listData, ghhgj: gradeController);
              },
              top: 10,
              readOnly: true,
              title: 'Grade',
              hintText: 'Select grade/s',
              suffix: Icon(Icons.keyboard_arrow_down),
            ),
            AppTextFormField(
              controller: gradeController1,
              onTap: () {
                bottomSheetDropDownList(
                    listData: listData1, ghhgj: gradeController1);
              },
              readOnly: true,
              title: 'Subject Taught',
              hintText: 'Select subject/s',
              suffix: Icon(Icons.keyboard_arrow_down),
            ),
            const AppTextFormField(
              readOnly: true,
              title: 'School Type',
              hintText: 'Select school type',
              suffix: Icon(Icons.keyboard_arrow_down),
            ),
            const AppTextFormField(
              readOnly: true,
              title: 'Curriculum',
              hintText: 'Select curriculum',
              suffix: Icon(Icons.keyboard_arrow_down),
            ),
            const AppTextFormField(
              readOnly: true,
              title: 'Type Of Class',
              hintText: 'Select class type',
              suffix: Icon(Icons.keyboard_arrow_down),
            ),
            AppButton(
                title: 'Continue Experience Information',
                onPressed: () {
                  AppRouter.pushNamed(Routes.experienceInfo);
                },
                isDisable: false)
          ],
        ),
      ),
    );
  }

  void bottomSheetDropDownList(
      {required List<String> listData, required TextEditingController ghhgj}) {
    final double width = MediaQuery.sizeOf(context).width;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                      return ListTile(
                        title: Text(listData[index],
                            style: openSans.get16.w400
                                .textColor(AppColors.appTextColor)),
                        onTap: () {
                          setState(() {
                            isSelected = index;
                            ghhgj.text = listData[index];
                          });
                        },
                        trailing: isSelected == index
                            ? const Icon(
                                Icons.check_circle,
                                color: AppColors.appBlue,
                              )
                            : const SizedBox(),
                      );
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
