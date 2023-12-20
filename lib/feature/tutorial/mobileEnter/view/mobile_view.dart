
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/cardView/warning_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../view/bottomSheets/country_code_bottom_sheet.dart';
import '../Controller/Controller.dart';


class MobileView extends StatelessWidget {
   MobileView({super.key});
  final MobileEnterController _mobileEnterController =Get.put(MobileEnterController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
       Scaffold(
        bottomNavigationBar: PreLoginCommonButton(
          title: 'continue'.tr,
          onTap: () => _mobileEnterController.onTapMobileSubmit(),
          isDisable: _mobileEnterController.mobileValid != 1,
        ),
        body: PreLoginCustomBody(
          widget: Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.px),
              children: [
                SizedBox(height: 10.px),
                SafeArea(bottom: false, child: OnTapBack()),
                SizedBox(height: 60.px),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppImageAsset(
                      image: ImageConstants.primaryLogoBlue,
                      height: 45.px),
                ),
                SizedBox(height: 28.px),
                AppText(
                  textAlign: TextAlign.start,
                  'join'.tr,
                  fontSize: 24.px,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 10.px),
                TextFormsField(
                  prefix: (_mobileEnterController.countries.isNotEmpty)
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
                                 );
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
                            image: _mobileEnterController
                                .countries[_mobileEnterController
                                .countryIndex]
                                .flag_url ??
                                ImageConstants.globe,
                            fit: BoxFit.fill,
                            height: 16.px,
                            width: 16.px,
                          ),
                        ),
                        SizedBox(width: 6.px),
                        AppText(
                          _mobileEnterController
                              .countries[
                          _mobileEnterController.countryIndex]
                              ?.idd_code ??
                              'select',
                          fontWeight: FontWeight.w400,
                          fontSize: 14.px,
                        )
                      ],
                    ),
                  )
                      : const SizedBox(),
                  title: 'mobileNumber'.tr,
                  keyboardType: TextInputType.number,
                  controller: _mobileEnterController.mobileController,
                  hintText: 'enterMobileAgain'.tr,
                  validate: _mobileEnterController.mobileValid.value,
                  errorText: _mobileEnterController.mobileErrorText.value,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (String value) {
                    _mobileEnterController.validateMobile(value);
                  },
                ),
                SizedBox(height: 20.px),
                if (_mobileEnterController.responseError.isNotEmpty)
                  WarningCardView(error: _mobileEnterController.responseError.value)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
