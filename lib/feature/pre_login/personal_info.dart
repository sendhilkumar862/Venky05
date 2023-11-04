import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../config/routes/app_router.dart';
import '../../config/routes/routes.dart';
import '../../custom/app_button/app_button.dart';
import '../../custom/app_textformfield/app_field.dart';
import '../../custom/appbar/appbar.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/typography.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  bool isSwitch = false;
  bool isSelected = false;
  int genderListIndex = 0;

  List<Gender> genderList = <Gender>[
    Gender(
      gender: 'Male',
      selected: false,
    ),
    Gender(
      gender: 'Female',
      selected: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: HessaAppBar(
        trailingText: 'Cancel',
        title: 'Complete Profile',
        isTitleOnly: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text('Personal Information',
                    style:
                        openSans.get20.w700.textColor(AppColors.appTextColor)),
              ),
              AppTextFormField(
                onTap: () {},
                readOnly: true,
                title: 'Nationality',
                hintText: 'Select your nationality',
                suffix: Icon(Icons.keyboard_arrow_down_sharp),
              ),
              const AppTextFormField(
                readOnly: true,
                title: 'Languages Spoken',
                hintText: 'Select spoken languages',
                suffix: Icon(Icons.keyboard_arrow_down_sharp),
              ),
              const AppTextFormField(
                readOnly: true,
                title: 'Birthday',
                hintText: 'Select your birthday',
                suffix: Icon(Icons.keyboard_arrow_down_sharp),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: <Widget>[
                    Text('Make it visible for users',
                        style: openSans.get14.w500
                            .textColor(AppColors.appTextColor)),
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
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: Text(
                  'Gender',
                  style: openSans.get12.w400
                      .textColor(AppColors.appTextColor.withOpacity(0.5)),
                ),
              ),
              gridView(),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: Text('Civil ID',
                    style: openSans.get12.w400
                        .textColor(AppColors.appTextColor.withOpacity(0.5))),
              ),
              SizedBox(
                width: width,
                height: 83,
                child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(15),
                    color: AppColors.appBlue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(Icons.cloud_upload_outlined,
                            color: AppColors.appBlue),
                        Center(
                            child: Text(
                          'Upload Civil ID',
                          style: openSans.get14.w500.appBlue,
                        )),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 40),
                  height: 64,
                  width: width,
                  decoration: BoxDecoration(
                      color: AppColors.lightPurpleTwo,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: const Icon(Icons.info,
                            size: 25, color: AppColors.downArrowColor),
                      ),
                      Expanded(
                        child: Text(
                          'Civil ID for usage of app only, and we will not share this doc with anyone.',
                          style: openSans.get12.w400.appTextColor,
                          overflow: TextOverflow.clip,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              AppButton(
                  title: 'Continue To Teaching Information',
                  onPressed: () {
                    AppRouter.pushNamed(Routes.teachingInfo);
                  },
                  isDisable: false)
            ],
          ),
        ),
      ),
    );
  }

  Widget gridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: genderList.length,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 44,
      ),
      itemCount: genderList.length,
      itemBuilder: (BuildContext context, index) {
        var data = genderList[index];
        return InkWell(
            onTap: () {
              setState(() {
                genderListIndex = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: index == genderListIndex
                      ? AppColors.appBlue
                      : AppColors.white,
                  border: Border.all(
                      color: AppColors.appBorderColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: Text(
                data.gender,
                style: openSans.w400.get14.textColor(
                  index == genderListIndex
                      ? AppColors.white
                      : AppColors.appTextColor,
                ),
              )),
            ));
      },
    );
  }
}

class Gender {
  Gender({
    required this.gender,
    required this.selected,
  });
  final String gender;
  final bool selected;
}
