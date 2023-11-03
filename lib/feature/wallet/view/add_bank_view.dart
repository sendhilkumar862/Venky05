import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/switch/app_switch.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/wallet_view_model.dart';

class AddBankView extends StatefulWidget {
  const AddBankView({super.key});

  @override
  State<AddBankView> createState() => _AddBankViewState();
}

class _AddBankViewState extends State<AddBankView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<WalletViewModel>(
      viewModel: WalletViewModel(),
      onModelReady: (WalletViewModel walletViewModel) {
        walletViewModel.setContext(context);
      },
      onPageBuilder: (BuildContext context, WalletViewModel walletViewModel) {
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
                  AppTextFormField(
                    titleColor: (walletViewModel.accountError.isEmpty)
                        ? AppColors.appGrey
                        : ('valid' == walletViewModel.accountError)
                            ? AppColors.appBlue
                            : AppColors.appRed,
                    controller: walletViewModel.accountNumberController,
                    title: 'Enter IBAN Number',
                    height: 10,
                    hintText: 'Enter IBAN Number',
                    validate: (String? value) {
                      return walletViewModel.accountNumberValidation(value!);
                    },

                  ),
                  SizedBox(height: 5.px),
                  AppTextFormField(
                    titleColor: (walletViewModel.nameError.isEmpty)
                        ? AppColors.appGrey
                        : ('valid' == walletViewModel.nameError)
                            ? AppColors.appRed
                            : AppColors.appBlue,
                    controller: walletViewModel.nameController,
                    title: 'Bank Account Nickname',
                    height: 10,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter nickname',
                    validate: (String? value) {
                      return walletViewModel.nameValidation(value!);
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
                      AppSwitch(
                          onTap: () => walletViewModel.onTapSwitch(),
                          isActive: walletViewModel.isActive)
                    ],
                  ),
                  SizedBox(height: 280.px),
                  AppButton(
                    title: 'Add Bank Account',
                    borderColor: AppColors.appBlue,
                    onPressed: () {},
                  ),
                  SizedBox(height: 30.px),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
