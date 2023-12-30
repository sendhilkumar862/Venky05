import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/cardView/warning_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../mobileEnter/controller/mobile_enter_controller.dart';
import '../../view/bottomSheets/country_code_bottom_sheet.dart';
import '../controller/add_mobile_number_controller.dart';

class AddMobileNumberView extends StatelessWidget {
  AddMobileNumberView({super.key});
  final AddMobileNumberController _addMobileNumberController =Get.put(AddMobileNumberController());
  final MobileEnterController _mobileEnterController =Get.put(MobileEnterController());
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        Scaffold(
          appBar: HessaAppBar(

            title: 'Add Mobile Number'.tr,
            isTitleOnly: true,
          ),
          bottomNavigationBar: PreLoginCommonButton(
            title: 'Add Mobile Number'.tr,
            onTap: () => _addMobileNumberController.onTapMobileSubmit(),
            isDisable: _addMobileNumberController.mobileValid != 1,
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
                          controller: _addMobileNumberController.mobileController,
                          hintText: 'Enter your new mobile number'.tr,
                          validate: _addMobileNumberController.mobileValid.value,
                          errorText: _addMobileNumberController.mobileErrorText.value,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (String value) {
                            _addMobileNumberController.validateMobile(value);
                          },
                        ),
                        SizedBox(height: 20.px),
                        if (_addMobileNumberController.responseError.isNotEmpty)
                          WarningCardView(error: _addMobileNumberController.responseError.value)
                      ],
                    ),
                  ),
                ],
              )

        ),
    );
  }
}
