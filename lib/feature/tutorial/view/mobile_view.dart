import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/otp/otp_text_field.dart';
import '../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../custom/text/app_text.dart';
import '../../../custom/text/country_picker.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/typography.dart';
import '../viewModel/tutorial_view_model.dart';
import 'email_view.dart';
import 'otp_view.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TutorialViewModel>(
        viewModel: TutorialViewModel(),
        onModelReady: (TutorialViewModel tutorialViewModel) {
          tutorialViewModel.setContext(context);
        },
        onPageBuilder:
            (BuildContext context, TutorialViewModel tutorialViewModel) {
          return Observer(builder: (BuildContext context) {
            return Scaffold(
              body: PreLoginCustomBody(
                widget: Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
                    children: [
                      SizedBox(height: 35.px),
                      const OnTapBack(),
                      SizedBox(height: 80.px),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppImageAsset(
                          image: ImageConstants.primaryLogoBlue,
                          height: 45.px,
                        ),
                      ),
                      SizedBox(height: 28.px),
                      AppText(
                        textAlign: TextAlign.start,
                        'Join To Hessah',
                        fontSize: 24.px,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 10.px),
                      AppTextFormField(
                        controller: tutorialViewModel.mobileController,
                        keyboardType: TextInputType.phone,
                        title: 'Mobile Number',
                        hintText: 'Enter your mobile number',
                        prefix: CountryPicker(
                          flagDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2)),
                          padding: EdgeInsets.zero,
                          onChanged: (CountryCode countryCode) {},
                          alignLeft: false,
                          dialogSize: const Size.square(550),
                          dialogTextStyle: openSans.w500.get16,
                          initialSelection: 'IN',
                          favorite: ['+91', 'IN'],
                          showDropDownButton: true,
                          textStyle: openSans.black.get12,
                        ),
                      ),
                      SizedBox(
                        height: 20.px,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: PreLoginCommonButton(
                title: 'Continue',
                onTap: () => AppRouter.pushNamed(Routes.otpView),
              ),
            );
          });
        });
  }
}
