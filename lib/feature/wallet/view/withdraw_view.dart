import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hessah/feature/wallet/view/set_bottom_sheet.dart';
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
import '../../../product/utils/typography.dart';
import '../viewModel/wallet_view_model.dart';
import 'add_bank_view.dart';

class WithdrawView extends StatefulWidget {
  const WithdrawView({super.key});

  @override
  State<WithdrawView> createState() => _WithdrawViewState();
}

class _WithdrawViewState extends State<WithdrawView>
    with TickerProviderStateMixin {
  List<CommonClass> bankAccount = [
    CommonClass(
      'Main Account',
      'KW81CBKU0000000000001234560101',
      'WARBA BANK',
    ),
    CommonClass(
      'Secondary Account',
      'KW81CBKU0000000000001234560101',
      'WARBA BANK',
    ),
    CommonClass(
      'Main Account',
      'KW81CBKU0000000000001234560101',
      'WARBA BANK',
    ),
    CommonClass(
      'Secondary Account',
      'KW81CBKU0000000000001234560101',
      'WARBA BANK',
    ),
  ];
  List<CommonClass> location = [
    CommonClass(
        'Home',
        'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
    CommonClass(
        'Work',
        'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
    CommonClass(
        'Home',
        'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
    CommonClass(
        'Work',
        'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
  ];

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
                isTitleOnly: true,
                title: 'withdraw'.tr(),
                isBack: true,
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
                        : ('valid'.tr() == walletViewModel.amountError)
                            ? AppColors.appRed
                            : AppColors.appBlue,
                    controller: walletViewModel.withdrawController,
                    title: 'withdrawAmount'.tr(),
                    height: 10,
                    keyboardType: TextInputType.number,
                    hintText: 'enterWithdrawAmount'.tr(),
                    validate: (String? value) {
                      return walletViewModel.withdrawAmountValidation(value!);
                    },
                    suffix:  Padding(
                      padding: EdgeInsets.only(top: 14.px),
                      child: AppText(
                        'kwd'.tr(),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.px),
                  Row(
                    children: <Widget>[
                      AppText(
                        'withdrawAllBalance'.tr(),
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
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          useSafeArea: true,
                          isScrollControlled: true,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text('bankAccount'.tr(),
                                            style: openSans.get20.w700),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 70),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.gray
                                                      .withOpacity(0.3)),
                                              child: const Padding(
                                                padding: EdgeInsets.all(3),
                                                child: Icon(Icons.close),
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListData(
                                          commonList: bankAccount,
                                          label: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text('iban'.tr(),
                                                style: openSans.get12.w500
                                                    .textColor(AppColors.gray)),
                                          ),
                                          image: Image.asset(
                                            ImageConstants.ellipse1,
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                AppButton(
                                  onPressed: () {},
                                  title: 'select'.tr(),
                                  isDisable: false,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'addNewAccount'.tr(),
                                        style: openSans.w700,
                                      ),
                                    ))
                              ]);
                            });
                          });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.px, horizontal: 5.px),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.px),
                        border: Border.all(color: AppColors.lightPurple),
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText('mainAccount'.tr(), fontWeight: FontWeight.w400),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                  noBankAccountCardView(),
                  SizedBox(height: 160.px),
                  AppButton(
                    title: 'withdraw'.tr(),
                    borderColor: AppColors.appBlue,
                    onPressed: (walletViewModel.amountError == 'valid'.tr())
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
          'bankAccount'.tr(),
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
                 AppText(
                  'noBankAccountsFound!'.tr(),
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 10.px),
                AppButton(
                  title: 'addNewBankAccount'.tr(),
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
            'availableBalance'.tr(),
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
