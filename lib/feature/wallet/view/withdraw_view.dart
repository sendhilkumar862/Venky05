import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../config/routes/app_router.dart';
import '../../../custom/amount/app_amount_view.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/switch/app_switch.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/wallet_view_model.dart';
import 'add_bank_view.dart';

class WithdrawView extends StatefulWidget {
  const WithdrawView({super.key});

  @override
  State<WithdrawView> createState() => _WithdrawViewState();
}

class _WithdrawViewState extends State<WithdrawView>
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
                title: 'Withdraw',
                isTitleOnly: true,
              ),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: 40.px),
                  availableBalanceCardView(),
                  AppTextFormField(
                    titleColor: (walletViewModel.amountError.isEmpty)
                        ? AppColors.appGrey
                        : ('valid' == walletViewModel.amountError)
                            ? AppColors.appRed
                            : AppColors.appBlue,
                    controller: walletViewModel.withdrawController,
                    title: 'Withdraw Amount',
                    height: 10,
                    keyboardType: TextInputType.number,
                    hintText: 'Enter withdraw amount',
                    validate: (String? value) {
                      return walletViewModel.withdrawAmountValidation(value!);
                    },
                    suffix: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: AppText(
                        'KWD',
                      ),
                    ),
                  ),
                  SizedBox(height: 14.px),
                  Row(
                    children: <Widget>[
                      AppText(
                        'Withdraw All Balance',
                        fontSize: 14.px,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: 8.px),
                      AppSwitch(
                          onTap: () => walletViewModel.onTapSwitch(),
                          isActive: walletViewModel.isActive)
                    ],
                  ),
                  SizedBox(height: 20.px),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.px, horizontal: 5.px),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.px),
                      border: Border.all(color: AppColors.lightPurple),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText('Main Account', fontWeight: FontWeight.w400),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                  noBankAccountCardView(),
                  SizedBox(height: 160.px),
                  AppButton(
                    title: 'Withdraw',
                    borderColor: AppColors.appBlue,
                    onPressed: (walletViewModel.amountError == 'valid')
                        ? () {}
                        : () {},
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Column noBankAccountCardView() {
    return Column(
      children: [
        AppText(
          'Bank Account',
          fontSize: 12.px,
          fontWeight: FontWeight.w400,
          color: AppColors.appGrey,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 10.px),
        DottedBorder(
          radius: const Radius.circular(15),
          borderType: BorderType.RRect,
          color: AppColors.appBlue,
          strokeWidth: 1.1,
          dashPattern: const <double>[4, 2],
          child: Container(
            padding: EdgeInsets.all(15.px),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const AppText(
                  'No Bank Accounts Found!',
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 10.px),
                AppButton(
                  title: 'Add New Bank Account',
                  height: 45.px,
                  borderRadius: BorderRadius.circular(10.px),
                  borderColor: AppColors.appBlue,
                  isBorderOnly: true,
                  onPressed: () => AppRouter.push(const AddBankView()),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container availableBalanceCardView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 15.px),
      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(10.px),
      ),
      child: Row(
        children: <Widget>[
          AppText(
            'Available Balance',
            fontSize: 12.px,
            fontWeight: FontWeight.w500,
            color: AppColors.appGrey,
          ),
          SizedBox(width: 5.px),
          AppAmountView(
            amount: '1400.100 KWD',
          )
        ],
      ),
    );
  }
}
