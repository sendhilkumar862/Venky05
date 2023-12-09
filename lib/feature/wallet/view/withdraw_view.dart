import 'package:dotted_border/dotted_border.dart';
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
import '../addBank/view/add_bank_view.dart';
import '../viewModel/wallets_view_model.dart';

class WithdrawView extends StatefulWidget {
  const WithdrawView({super.key});

  @override
  State<WithdrawView> createState() => _WithdrawViewState();
}

class _WithdrawViewState extends State<WithdrawView> with TickerProviderStateMixin {
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
    CommonClass('Home', 'City, Block No., Street Name, Street Name 2, HouseNo.,', 'Floor No., Apartment No.'),
    CommonClass('Work', 'City, Block No., Street Name, Street Name 2, HouseNo.,', 'Floor No., Apartment No.'),
    CommonClass('Home', 'City, Block No., Street Name, Street Name 2, HouseNo.,', 'Floor No., Apartment No.'),
    CommonClass('Work', 'City, Block No., Street Name, Street Name 2, HouseNo.,', 'Floor No., Apartment No.'),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView<WalletsViewModel>(
      viewModel: WalletsViewModel(),
      onModelReady: (WalletsViewModel walletsViewModel) {
        walletsViewModel.setContext(context);
      },
      onPageBuilder: (BuildContext context, WalletsViewModel walletsViewModel) {
        return Observer(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: AppColors.appWhite,
              appBar: HessaAppBar(
                isTitleOnly: true,
                title: 'Withdraw',
                isBack: true,
              ),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: 40.px),
                  availableBalanceCardView(),
                  AppTextFormField(
                    titleColor: (walletsViewModel.amountError.isEmpty)
                        ? AppColors.appGrey
                        : ('valid' == walletsViewModel.amountError)
                            ? AppColors.appRed
                            : AppColors.appBlue,
                    controller: walletsViewModel.withdrawController,
                    title: 'Withdraw Amount',
                    height: 10,
                    keyboardType: TextInputType.number,
                    hintText: 'Enter withdraw amount',
                    validate: (String? value) {
                      return walletsViewModel.withdrawAmountValidation(value!);
                    },
                    suffix: Padding(
                      padding: EdgeInsets.only(top: 14.px),
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
                      AppSwitch(onTap: () => walletsViewModel.onTapSwitch(), isActive: walletsViewModel.isActive)
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
                            return StatefulBuilder(builder: (context, setState) {
                              return Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                                    Text('Bank Account', style: openSans.get20.w700),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 70),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle, color: AppColors.gray.withOpacity(0.3)),
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
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            child: Text('IBAN', style: openSans.get12.w500.textColor(AppColors.gray)),
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
                                  title: 'Select',
                                  isDisable: false,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Add New Account',
                                        style: openSans.w700,
                                      ),
                                    ))
                              ]);
                            });
                          });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 5.px),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.px),
                        border: Border.all(color: AppColors.lightPurple),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [AppText('Main Account', fontWeight: FontWeight.w400), Icon(Icons.arrow_drop_down)],
                      ),
                    ),
                  ),
                  noBankAccountCardView(),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppButton(
                      title: 'Withdraw',
                      borderColor: AppColors.appBlue,
                      onPressed: (walletsViewModel.amountError == 'valid') ? () {} : () {},
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
