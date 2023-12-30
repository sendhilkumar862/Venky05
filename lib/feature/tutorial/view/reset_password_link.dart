import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/typography.dart';
import '../tutorial_controller/tutorial_controller.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TutorialController _tutorialController =Get.put(TutorialController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        isBack: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Lottie.asset(ImageConstants.mailApproved,
                          height: 150, width: 150)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('Reset Password Link Sent',
                        style: openSans.get16.w700.appTextColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Password reset link sent! Please check your email and follow the instructions to reset your password.',
                      style: openSans.get14.w400
                          .textColor(AppColors.appTextColor.withOpacity(0.5)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      "Didn't receive the link?",
                      style: openSans.get12.w400
                          .textColor(AppColors.appTextColor.withOpacity(0.5)),
                    ),
                  ),
                  TextButton.icon(
                      onPressed: () {
                        _tutorialController.forgotPassword();
                      },
                      icon: const Icon(
                        Icons.cached_outlined,
                        color: AppColors.appBlue,
                      ),
                      label: Text(
                        'Resend Again',
                        style: openSans.get14.w600.textColor(AppColors.appBlue),
                      )),
                ],
              ),
            ),
            AppButton(
                isDisable: false, title: 'Back to Login', onPressed: () =>    AppRouter.pushNamedPopUntil( context,  route: Routes.loginView),)
          ],
        ),
      ),
    );
  }
}
