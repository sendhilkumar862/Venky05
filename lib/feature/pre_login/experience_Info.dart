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

class ExperienceInfo extends StatefulWidget {
  const ExperienceInfo({Key? key}) : super(key: key);

  @override
  State<ExperienceInfo> createState() => _ExperienceInfoState();
}

class _ExperienceInfoState extends State<ExperienceInfo> {
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: HessaAppBar(
        isBack: true,
        trailingText: 'Cancel',
        title: 'Complete Profile',
        isTitleOnly: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text('Experience Information',
                    style:
                        openSans.get20.w700.textColor(AppColors.appTextColor)),
              ),
              AppTextFormField(
                title: 'Education',
                hintText: 'Enter your education',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 30),
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
              const AppTextFormField(
                top: 0,
                title: 'Experience Years',
                hintText: 'Enter years of experience',
              ),
              const AppTextFormField(
                maxLines: 3,
                title: 'Experience Brief',
                hintText: 'Enter experience brief',
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
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: Text('Certificates',
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
                          'Upload Your Cetificates',
                          style: openSans.get14.w500.appBlue,
                        )),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 25),
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
              AppButton(
                  title: 'Continue To Teaching Information',
                  onPressed: () {
                    AppRouter.pushNamed(Routes.financingView);
                  },
                  isDisable: false),
            ],
          ),
        ),
      ),
    );
  }
}
