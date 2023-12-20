import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/amount/app_amount_view.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../custom/divider/divider.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../home_views/views/tabs/classes_view.dart';
import '../../view/invoice_card_view.dart';
import '../../view/view_all_view.dart';
import '../../view/withdraw.dart';
import '../../view/withdraw_view.dart';
import '../viewModel/wallet_view_model.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> with TickerProviderStateMixin {
  bool isStudent = false;
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  String selectedProfile = '';
  String selectedUserStatus = '';
  bool isPending = false;

  @override
  void initState() {
    super.initState();
    selectedProfile =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ?? '';
    selectedUserStatus=keyValueStorageBase.getCommon(String, KeyValueStorageService.userInfoStatus) ?? '';
  }

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
                  icon: (!walletViewModel.isProfileTeacher) ? ImageConstants
                      .avtar : ImageConstants.teacherAvtar,
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  isSearchIconShown: !(selectedProfile == ApplicationConstants.tutor && selectedUserStatus != '99'),
                  title: 'Welcome!',
                  subTitle: 'Abdullah Mohamed',
                  isPro: walletViewModel.isProfileTeacher,
                ),
                body: selectedProfile == ApplicationConstants.tutor
                    ? Padding(
                  padding: const EdgeInsets.only(top: 64.0),
                  child: const ClassesView(),
                )
                    :ListView(
                  children: <Widget>[
                    SizedBox(height: 30.px),
                    AppText(
                      'Available Balance',
                      textAlign: TextAlign.center,
                      color: AppColors.appGrey,
                      fontSize: 12.px,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 5.px),
                    AppAmountView(amount: '100.500 KWD',
                        firstFontSize: 24.px,
                        decimalSize: 16.px),
                    SizedBox(height: 14.px),
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.100,
                      margin: EdgeInsets.symmetric(horizontal: 15.px),
                      padding: EdgeInsets.all(11.px),
                      decoration: BoxDecoration(
                        color: AppColors.lightPurple,
                        borderRadius: BorderRadius.circular(10.px),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // from teachers and students view conditionally manage
                        children: (!walletViewModel.isProfileTeacher)
                            ? <Widget>[
                          balanceCardView(title: 'Active Classes\nBooked',
                              amount: '100.000 KWD'),
                          AppDivider(isVerticle: true),
                          balanceCardView(title: 'New Classes\nCreated',
                              amount: '100.000 KWD'),
                          AppDivider(isVerticle: true),
                          balanceCardView(
                              title: 'Pending\nPayment', amount: '100.000 KWD'),
                        ]
                            : <Widget>[
                          balanceCardView(
                              title: 'Pending Balance', amount: '100.000 KWD'),
                          AppDivider(isVerticle: true),
                          balanceCardView(
                              title: 'Pending Withdraw', amount: '100.000 KWD'),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.px),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.px),
                      child: walletViewModel.isProfileTeacher
                          ? screenButton(
                          onTap: () {
                            AppRouter.push(WithDrawScreen());
                          },
                          title: 'Top Up Wallet',
                          icon: ImageConstants.walletIcon)
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          screenButton(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  constraints: const BoxConstraints(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25.px),
                                      topLeft: Radius.circular(25.px),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return const BookingBottomSheet();
                                  },
                                );
                              },
                              title: 'Bank Accounts',
                              icon: ImageConstants.walletIcon),
                          SizedBox(width: 15.px),
                          screenButton(
                              onTap: () => AppRouter.push(const WithdrawView()),
                              title: 'Withdraw',
                              icon: ImageConstants.walletIcon),
                        ],
                      ),
                    ),
                    if(!walletViewModel.isProfileTeacher)SizedBox(
                        height: 25.px),
                    if(!walletViewModel.isProfileTeacher)chartCardView(
                        walletViewModel: walletViewModel),
                    SizedBox(height: 25.px),
                    HeadingCardView(
                      title: 'Last Invoices',
                      isViewAllIcon: true,
                      onTap: () => AppRouter.push(const ViewAllView()),
                    ),
                    SizedBox(height: 18.px),
                    SizedBox(
                      height: 370.px,
                      child: ListView.separated(
                        itemCount: 14,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          // if item is zero the condition will be menage//
                          return (false)
                              ? InfoCardVIew(
                            title: 'No Invoices!',
                            subTitle: 'Book classes or create new to see invoices.',
                            buttonTitle: 'Create New Class',
                            buttonTap: () {},
                          )
                              : InvoiceCardView(
                            title: 'Class Fees',
                            invoiceNumber: '#123456',
                            amount: '.500 KWD',
                            date: '',
                            onTap: () {
                              AppRouter.pushNamed(Routes.invoiceDetails);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(padding: EdgeInsets.only(left: 15.px),
                              child: AppDivider());
                        },
                      ),
                    )
                  ],
                ),
              );

          }
          );
      },
    );
  }

  Widget chartCardView({WalletViewModel? walletViewModel}) {
    return Column(
      children: <Widget>[
        stateCardView(),
        SizedBox(height: 8.px),
        SizedBox(
          height: 160.px,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.px),
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(),
              series: <ColumnSeries<ChartSampleData, String>>[
                ColumnSeries<ChartSampleData, String>(
                  isVisibleInLegend: true,
                  width: 0.5,
                  color: AppColors.appPurple,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5.px),
                    topLeft: Radius.circular(5.px),
                  ),
                  dataSource: walletViewModel!.chartData,
                  xValueMapper: (ChartSampleData sales, _) => sales.x,
                  yValueMapper: (ChartSampleData sales, _) => sales.y,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget invoiceCardView({
    String? date,
    String? title,
    String? invoiceNumber,
    String? amount,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 15.px),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 4.px,
          ),
          if (date!.isNotEmpty)
            AppText(
              date,
              textAlign: TextAlign.start,
              color: AppColors.gray,
              fontSize: 12.px,
              fontWeight: FontWeight.w700,
            ),
          if (date!.isNotEmpty)
            SizedBox(
              height: 8.px,
            ),
          Row(
            children: <Widget>[
              if (title == 'Class Fees')
                CircleAvatar(
                    backgroundColor: AppColors.appLightRedTwo,
                    radius: 23.px,
                    child: AppImageAsset(
                      image: ImageConstants.readBookIcon,
                      height: 21.px,
                    ))
              else
                CircleAvatar(
                  backgroundColor: AppColors.greenBG,
                  radius: 23.px,
                  child: AppImageAsset(
                    image: ImageConstants.walletIcon,
                    height: 21.px,
                  ),
                ),
              SizedBox(width: 15.px),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        AppText(
                          title ?? '',
                          fontSize: 14.px,
                        ),
                        const Spacer(),
                        Row(
                          children: <Widget>[
                            AppAmountView(amount: amount),
                            const SizedBox(
                              width: 18,
                            ),
                            AppImageAsset(
                              image: ImageConstants.forwardIcon,
                              height: 14.px,
                            ),
                          ],
                        ),
                        SizedBox(width: 18.px)
                      ],
                    ),
                    SizedBox(
                      height: 4.px,
                    ),
                    AppText(
                      'Invoice No. $invoiceNumber',
                      fontSize: 10.px,
                      fontWeight: FontWeight.w400,
                      color: AppColors.appGrey,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.px,
          ),
        ],
      ),
    );
  }

  Widget stateCardView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  AppText(
                    'Total Gains',
                    color: AppColors.appGrey,
                    fontSize: 12.px,
                  ),
                  SizedBox(
                    width: 6.px,
                  ),
                  AppAmountView(
                    amount: '100.000 KWD',
                  )
                ],
              ),
              SizedBox(height: 4.px),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_upward_outlined,
                    size: 12.px,
                    color: AppColors.appGreen,
                  ),
                  SizedBox(width: 5.px),
                  AppText('2.1%', fontSize: 12.px, color: AppColors.appGreen, fontWeight: FontWeight.w700),
                  AppText(
                    'vs last Month',
                    fontSize: 12.px,
                    fontWeight: FontWeight.w700,
                  )
                ],
              )
            ],
          ),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 3.px),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.px),
              border: Border.all(color: AppColors.gray),
            ),
            child: AppText(
              '2023',
              fontSize: 12.px,
              fontWeight: FontWeight.w700,
              color: AppColors.appGrey,
            ),
          )
        ],
      ),
    );
  }

  Widget balanceCardView({String? title, String? amount}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          title ?? '',
          textAlign: TextAlign.center,
          fontSize: 10.px,
          fontWeight: FontWeight.w400,
          color: AppColors.appGrey,
        ),
        SizedBox(height: 4.px),
        AppAmountView(amount: amount, fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget screenButton({VoidCallback? onTap, String? title, String? icon}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.px),
          height: 35.px,
          decoration: BoxDecoration(
            color: AppColors.appBlue,
            borderRadius: BorderRadius.circular(12.px),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppImageAsset(
                image: icon ?? '',
                color: AppColors.appWhite,
                height: 18.px,
              ),
              SizedBox(width: 6.px),
              AppText(
                title ?? '',
                color: AppColors.appWhite,
                fontSize: 14.px,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChartSampleData {
  ChartSampleData({required this.x, required this.y});

  final String x;
  final double y;
}

class BookingBottomSheet extends StatelessWidget {
  const BookingBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.px, right: 15.px),
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.px),
          topRight: Radius.circular(30.px),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(top: 14.px),
              alignment: Alignment.center,
              height: 25.px,
              width: 25.px,
              decoration: const BoxDecoration(color: AppColors.appLightGrey, shape: BoxShape.circle),
              child: const AppImageAsset(
                image: ImageConstants.closeIcon,
                height: 20,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 28.px,
              ),
              AppText(
                'Booking Confirmation',
                fontSize: 14.px,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 23.px,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  'Payment Method',
                  fontSize: 16.px,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 18.px,
              ),
              Row(
                children: <Widget>[
                  AppImageAsset(
                    image: ImageConstants.kNetLogo,
                    height: 20.px,
                  ),
                  SizedBox(width: 8.px),
                  AppImageAsset(
                    image: ImageConstants.visaLogo,
                    height: 12.px,
                  ),
                  SizedBox(width: 8.px),
                  AppImageAsset(
                    image: ImageConstants.mastercardLogo,
                    height: 20.px,
                  ),
                  SizedBox(width: 8.px),
                  AppImageAsset(
                    image: ImageConstants.applePayLogo,
                    height: 20.px,
                  ),
                  SizedBox(width: 8.px),
                  AppImageAsset(
                    image: ImageConstants.gPayLogo,
                    height: 20.px,
                  ),
                  SizedBox(width: 8.px),
                ],
              ),
              SizedBox(
                height: 18.px,
              ),
              AppDivider(),
              SizedBox(
                height: 18.px,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  'Payment Method',
                  fontSize: 16.px,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 14.px),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppText(
                    'Amount to pay',
                    fontSize: 12.px,
                    color: AppColors.appGrey,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const AppText('10'),
                      AppText(
                        '.000 KWD',
                        fontSize: 12.px,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20.px,
              ),
              AppButton(
                height: 45.px,
                title: 'Pay',
                borderColor: AppColors.appBlue,
                borderRadius: BorderRadius.circular(10.px),
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
