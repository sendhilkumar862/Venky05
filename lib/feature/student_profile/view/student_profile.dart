import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../custom/appbar/appbar.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/student_profile_view_model.dart';

class StudentProfileView extends StatefulWidget {
  const StudentProfileView({super.key});

  @override
  State<StudentProfileView> createState() => _StudentProfileViewState();
}

class _StudentProfileViewState extends State<StudentProfileView> {
  StudentProfileViewModel studentProfileViewModel = StudentProfileViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HessaAppBar(
          isTitleOnly: true,
          title: 'User Profile',
        ),
        backgroundColor: Colors.white,
        body: Observer(
          builder: (BuildContext context) {
            return ListView(
              children: <Widget>[
                const SizedBox(height: 60),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: const AppImageAsset(
                        image: ImageConstants.avtar,
                      )),
                ),
                const SizedBox(height: 10),
                const AppText(
                  'User Name',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appDarkBlack,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.appBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppImageAsset(
                              image: ImageConstants.messageIcon,
                              height: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            AppText(
                              'Message',
                              color: AppColors.appWhite,
                              fontSize: 14,
                            ),
                          ]),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.appBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppImageAsset(
                              image: ImageConstants.saveIcon,
                              height: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            AppText(
                              'Message',
                              color: AppColors.appWhite,
                              fontSize: 14,
                            ),
                          ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.px,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.px),
                  padding: EdgeInsets.all(15.px),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.lightPurple),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          AppText(
                            'Attended Classes ',
                            fontSize: 10.px,
                            color: AppColors.appGrey,
                          ),
                          AppText(
                            '48',
                            fontSize: 14.px,
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                      SizedBox(width: 25.px),
                      Column(
                        children: [
                          AppText(
                            'Created Classes',
                            fontSize: 10.px,
                            color: AppColors.appGrey,
                          ),
                          AppText(
                            '14',
                            fontSize: 14.px,
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.px,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.px),
                  padding: EdgeInsets.all(15.px),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.lightPurple),
                      color: AppColors.lightPurple),
                  child: Column(crossAxisAlignment: ,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              AppText(
                                'Grade',
                                fontSize: 10.px,
                                color: AppColors.appGrey,
                              ),
                              AppText(
                                'High School - University',
                                fontSize: 14.px,
                                fontWeight: FontWeight.w700,
                              )
                            ],
                          ),
                          SizedBox(width: 25.px),
                          Column(
                            children: [
                              AppText(
                                'School',
                                fontSize: 10.px,
                                color: AppColors.appGrey,
                              ),
                              AppText(
                                'Private - Public',
                                fontSize: 14.px,
                                fontWeight: FontWeight.w700,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
