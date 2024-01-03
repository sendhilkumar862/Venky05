
// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../config/routes/route.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/appbar/appBarOnBoard.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../emailEnter/view/email_view.dart';
import '../Controller/onboading_controller.dart';


class OnBoardingView extends StatelessWidget {
   OnBoardingView({super.key,});
    bool continueRegistration =false;
  final OnBoadingController _boardingController=Get.put(OnBoadingController());
   @override
   void initState() {
     continueRegistration= Get.arguments['continueRegistration'];
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      appBar: AppBarOnBoard(
          title: 'exploreApp'.tr,
          backNavigate: !(continueRegistration ?? false),
          icon: ImageConstants.layersIcon,
          onTap: () => Get.toNamed(Routes.HomeScreenRoute),
          onBackTap: () {
            final KeyValueStorageBase keyValueStorageBase =
            KeyValueStorageBase();
            keyValueStorageBase.setCommon(
                KeyValueStorageService.profile, '');
           Get.back();
          }),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.px),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 400.px,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _boardingController.pageController,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.px),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: _boardingController.currentProfile ==
                              'Student'
                              ? Lottie.asset(_boardingController
                              .studentAnimation[index])
                              : Lottie.asset(_boardingController
                              .teacherAnimation[index]),
                        ),
                        AppText(
                          (_boardingController.currentProfile ==
                              'Student')
                              ? _boardingController.studentTitle[index]
                              : _boardingController.teacherTitle[index],
                          textAlign: TextAlign.center,
                          fontSize: 24.px,
                          fontWeight: FontWeight.w800,
                        ),
                        SizedBox(
                          height: 10.px,
                        ),
                        AppText(
                          (_boardingController.currentProfile ==
                              'Student')
                              ? _boardingController
                              .studentSubtitle[index]
                              : _boardingController
                              .teacherSubtitle[index],
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                          color: AppColors.appGrey,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 18.px),
            SmoothPageIndicator(
              controller: _boardingController.pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                  spacing: 8.px,
                  radius: 10.px,
                  dotWidth: 8.px,
                  dotHeight: 8.px,
                  //paintStyle: PaintingStyle.stroke,
                  dotColor: AppColors.lightPurple,
                  activeDotColor: AppColors.appBlue),
            ),
            SizedBox(
              height: 25.px,
            ),
            const Spacer(),
            AppButton(
              height: 45.px,
              borderRadius: BorderRadius.circular(10.px),
              borderColor: AppColors.appBlue,
              title: 'join'.tr,
              isDisable: false,
              onPressed: () {
                Get.toNamed(Routes.emailView);
              },
            ),
            SizedBox(height: 15.px),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.loginView),
              child: AppText(
                'login'.tr,
                fontWeight: FontWeight.w600,
                fontSize: 14.px,
                color: AppColors.appBlue,
              ),
            ),
            SizedBox(
              height: 30.px,
            )
          ],
        ),
      ),
    );
  }
}
