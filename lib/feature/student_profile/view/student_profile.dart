import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
        backgroundColor: Colors.white,
        body: Observer(
          builder: (BuildContext context) {
            return ListView(
              children: <Widget>[
                const SizedBox(height: 60),
                SizedBox(
                  height: 50,
                  width: 50,
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
                        color: AppColors.appColor,
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
                        color: AppColors.appColor,
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
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                )
              ],
            );
          },
        ));
  }
}
