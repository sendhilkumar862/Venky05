import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_button/app_button.dart';

import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/switch/app_switch.dart';
import '../../../../custom/text/app_text.dart';

import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../controller/add_bank_controller.dart';


class AddBankView extends StatelessWidget {
   AddBankView({super.key});
  final AddBankController _addBankController=Get.put(AddBankController());
  Widget build(BuildContext context) {
    return Obx(()
    {
      return Scaffold(
        backgroundColor: AppColors.appWhite,
        appBar: HessaAppBar(
          icon: ImageConstants.avtar,
          title: 'Add Bank Account',
          isTitleOnly: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.px),
          children: [
            SizedBox(height: 15.px),
            TextFormsField(
              title: 'Enter IBAN Number',
              validate: _addBankController.accountValid.value,
              controller: _addBankController.accountController,
              hintText: 'Enter IBAN Number',
              errorText: _addBankController.accountError.value,
              onChanged: (String value) {
                _addBankController.validateAccount(value);
              },
            ),
            SizedBox(height: 15.px),
            TextFormsField(
              title: 'Bank Account Nickname',
              validate: _addBankController.nameValid.value,
              controller: _addBankController.nameController,
              hintText: 'Enter nickname',
              errorText: _addBankController.nameError.value,
              onChanged: (String value) {
                _addBankController.validateName(value);
              },
            ),
            SizedBox(height: 14.px),
            Row(
              children: <Widget>[
                AppText(
                  'Set as Default Account',
                  fontSize: 14.px,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 8.px),
                AppSwitch(onTap: () => _addBankController.onTapSwitch(), isActive: _addBankController.isActive.value)
              ],
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                title: 'Add Bank Account',
                borderColor: AppColors.appBlue,
                onPressed: () {},
              ),
              SizedBox(height: 30.px),
            ],
          ),
        ),
      );
    },
    );
  }
}
