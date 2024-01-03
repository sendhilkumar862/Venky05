import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hessah/feature/tutorial/view/bottomSheets/country_code_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/cardView/warning_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/image/image_constants.dart';


import '../../mobileEnter/controller/mobile_enter_controller.dart';
import '../controller/change_mobile_number_controller.dart';
class ChangeMobileNumberView extends StatelessWidget {
  ChangeMobileNumberView({super.key});
  final ChangeMobileNumberController _changeMobileNumberController =Get.put(ChangeMobileNumberController());

   final MobileEnterController _mobileEnterController =Get.put(MobileEnterController());
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        Scaffold(
          appBar: HessaAppBar(
            title: 'Change Mobile Number'.tr,
            isTitleOnly: true,
          ),
          bottomNavigationBar: PreLoginCommonButton(
            title: 'Change Mobile Number'.tr,
            onTap: () => _changeMobileNumberController.onTapMobileSubmit(),
            isDisable: _changeMobileNumberController.isButtonDisable(),
          ),
          body:
              Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 15.px),
                      children: [
                        SizedBox(height: 30.px),
                        TextFormsField(
                          prefix: _mobileEnterController.countries.isNotEmpty
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
                                        .countries[_mobileEnterController.countryIndex.value]
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
                                      .countries[_mobileEnterController.countryIndex.value].idd_code ??
                                      'select',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.px,
                                )
                              ],
                            ),
                          )
                              : const SizedBox(),
                          title: 'New Mobile Number'.tr,
                          keyboardType: TextInputType.number,
                          controller: _changeMobileNumberController.mobileController,
                          hintText: 'Enter your new mobile number'.tr,
                          validate: _changeMobileNumberController.mobileValid.value,
                          errorText: _changeMobileNumberController.mobileErrorText.value,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (String value) {
                            _changeMobileNumberController.validateMobile(value);
                          },
                        ),
                        SizedBox(height: 20.px),
                        Obx(
                              () => TextFormsField(
                            validate: _changeMobileNumberController.isWrongOldPassword.value?0:null,
                            title: 'Account Password'.tr,
                            controller: _changeMobileNumberController.accountPasswordController,
                            hintText: 'Enter Your Account Password'.tr,
                            keyboardType: TextInputType.multiline,
                            obscureText:
                            !_changeMobileNumberController.isAccountPasswordVisible.value,
                            suffixIcon: InkWell(
                              onTap: () {
                                _changeMobileNumberController.isAccountPasswordVisible.value =
                                !_changeMobileNumberController.isAccountPasswordVisible.value;
                              },
                              child: AppImageAsset(
                                image:
                                (_changeMobileNumberController.isAccountPasswordVisible.value)
                                    ? ImageConstants.eye
                                    : ImageConstants.eyeCross,
                                height: 22.px,
                              ),
                            ),
                            onChanged: (String value) {
                              _changeMobileNumberController.validatePassword(value);
                            },
                          ),
                        ),
                        SizedBox(height: 20.px),
                        if (_changeMobileNumberController.responseError.isNotEmpty)
                          WarningCardView(error: _changeMobileNumberController.responseError.value)
                      ],
                    ),
                  ),
                ],
              )

        ),
    );
  }
}