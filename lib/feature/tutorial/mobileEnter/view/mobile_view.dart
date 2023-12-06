import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/cardView/warning_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/validators.dart';
import '../../view/bottomSheets/country_code_bottom_sheet.dart';
import '../viewModel/mobile_view_model.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MobileViewModel>(
      viewModel: MobileViewModel(),
      onModelReady: (MobileViewModel mobileViewModel) {
        mobileViewModel.setContext(context);
        mobileViewModel.data = ModalRoute.of(context)!.settings.arguments! as Map;
        mobileViewModel.arguments['userId'] = mobileViewModel.data['userId'];
        logs('argue--> ${mobileViewModel.data}');
        mobileViewModel.init();
      },
      onPageBuilder: (BuildContext context, MobileViewModel mobileViewModel) {
        return Observer(
          //warnWhenNoObservables: false,
          builder: (BuildContext context) {
            return Scaffold(
              bottomNavigationBar: PreLoginCommonButton(
                title: 'continue'.tr(),
                onTap: () => mobileViewModel.onTapMobileSubmit(),
               isDisable: mobileViewModel.mobileValid != 1,
              ),
              body: PreLoginCustomBody(
                widget: Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
                    children: [
                      SizedBox(height: 10.px),
                       SafeArea(bottom: false, child: OnTapBack()),
                      SizedBox(height: 80.px),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppImageAsset(
                            image: ImageConstants.primaryLogoBlue,
                            height: 45.px),
                      ),
                      SizedBox(height: 28.px),
                      AppText(
                        textAlign: TextAlign.start,
                        'join'.tr(),
                        fontSize: 24.px,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 10.px),
                      TextFormsField(
                        prefix: (mobileViewModel.countries.isNotEmpty)
                            ? GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0),
                                      ),
                                    ),
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder:
                                            (BuildContext context, setState) {
                                          return CountryCodeBottomsSheet(
                                              setState: setState,
                                              mobileViewModel: mobileViewModel);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    SizedBox(width: 6.px),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(700),
                                      child: AppImageAsset(
                                        image: mobileViewModel
                                                .countries[mobileViewModel
                                                    .countryIndex]
                                                ?.flag_url ??
                                            ImageConstants.globe,
                                        fit: BoxFit.fill,
                                        height: 16.px,
                                        width: 16.px,
                                      ),
                                    ),
                                    SizedBox(width: 6.px),
                                    AppText(
                                      mobileViewModel
                                              .countries[
                                                  mobileViewModel.countryIndex]
                                              ?.idd_code ??
                                          'select',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.px,
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        title: 'mobileNumber'.tr(),
                        keyboardType: TextInputType.number,
                        controller: mobileViewModel.mobileController,
                        hintText: 'enterMobileAgain'.tr(),
                        validate: mobileViewModel.mobileValid,
                        errorText: mobileViewModel.mobileErrorText,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        onChanged: (String value) {
                      mobileViewModel.validateMobile(value);
                        },
                      ),
                      SizedBox(height: 20.px),
                      if (mobileViewModel.responseError.isNotEmpty)
                        WarningCardView(error: mobileViewModel.enterMobileModel.status!.message)

                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
