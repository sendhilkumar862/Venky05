import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/switch/app_switch.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../viewModel/add_bank_view_model.dart';

class AddBankView extends StatelessWidget {
  const AddBankView({super.key});

  Widget build(BuildContext context) {
    return BaseView<AddBankViewModel>(
      viewModel: AddBankViewModel(),
      onModelReady: (AddBankViewModel addBankViewModel, WidgetRef ref) {
        addBankViewModel.setContext(context);
      },
      onPageBuilder: (BuildContext context, AddBankViewModel addBankViewModel, WidgetRef ref) {
        return Observer(
          builder: (BuildContext context) {
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
                    validate: addBankViewModel.accountValid,
                    controller: addBankViewModel.accountController,
                    hintText: 'Enter IBAN Number',
                    errorText: addBankViewModel.accountError,
                    onChanged: (String value) {
                      addBankViewModel.validateAccount(value);
                    },
                  ),
                  SizedBox(height: 15.px),
                  TextFormsField(
                    title: 'Bank Account Nickname',
                    validate: addBankViewModel.nameValid,
                    controller: addBankViewModel.nameController,
                    hintText: 'Enter nickname',
                    errorText: addBankViewModel.nameError,
                    onChanged: (String value) {
                      addBankViewModel.validateName(value);
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
                      AppSwitch(onTap: () => addBankViewModel.onTapSwitch(), isActive: addBankViewModel.isActive)
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
      },
    );
  }
}
