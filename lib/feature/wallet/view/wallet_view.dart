import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/heading_card_view.dart';
import '../../../custom/cardView/info_card_view.dart';
import '../../../custom/divider/divider.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/wallet_view_model.dart';
import 'view_all_view.dart';

class ChartSampleData {
  final String x;
  final double y;

  ChartSampleData({required this.x, required this.y});
}

class WalletView extends StatefulWidget {
  WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'Jan', y: 0.541),
      ChartSampleData(x: 'Feb', y: 0.818),
      ChartSampleData(x: 'March', y: 1.51),
      ChartSampleData(x: 'April', y: 0),
      ChartSampleData(x: 'May', y: 0),
      ChartSampleData(x: 'June', y: 0),
    ];
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
                title: 'Welcome!',
                subTitle: 'Abdullah Mohamed',
                // isPro: true,
              ),
              body: ListView(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppText(
                        '102',
                        fontSize: 24.px,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        '.500 KWD',
                        fontSize: 16.px,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  SizedBox(height: 14.px),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.px),
                    padding: EdgeInsets.all(11.px),
                    decoration: BoxDecoration(
                      color: AppColors.lightPurple,
                      borderRadius: BorderRadius.circular(10.px),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        balanceCardView(
                            title: 'Pending Balance', amount: '.000 KWD'),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.px),
                          height: 40.px,
                          width: 1.px,
                          color: AppColors.appGrey,
                        ),
                        balanceCardView(
                            title: 'Pending Balance', amount: '.000 KWD'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.px),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
                    child: Row(
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
                      ],
                    ),
                  ),
                  SizedBox(height: 25.px),
                  stateCardView(),
                  SizedBox(height: 8.px),
                  SizedBox(
                    height: 200.px,
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
                            dataSource: chartData,
                            xValueMapper: (ChartSampleData sales, _) => sales.x,
                            yValueMapper: (ChartSampleData sales, _) => sales.y,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25.px),
                  HeadingCardView(
                    title: 'Last Invoices',
                    isViewAllIcon: true,
                    onTap: () => AppRouter.push(const ViewAllView()),
                  ),
                  SizedBox(height: 18.px),
                  if (false)
                    InfoCardVIew(
                      title: 'No Invoices!',
                      subTitle: 'Book classes or create new to see invoices.',
                      buttonTitle: 'Create New Class',
                      buttonTap: () {},
                    )
                  else
                    SizedBox(
                      height: 370.px,
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return invoiceCardView(
                              title: 'Class Fees',
                              invoiceNumber: '#123456',
                              amount: '.500 KWD',
                              date: '',
                              onTap: () {},
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: EdgeInsets.only(left: 15.px),
                                child: const AppDivider());
                          },
                          itemCount: 14),
                    )
                ],
              ),
            );
          },
        );
      },
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 260.px,
                    child: Row(
                      children: <Widget>[
                        AppText(
                          title ?? '',
                          fontSize: 14.px,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            AppText(
                              '102',
                              fontSize: 14.px,
                              fontWeight: FontWeight.w700,
                            ),
                            AppText(
                              amount ?? '',
                              fontSize: 10.px,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            AppImageAsset(
                              image: ImageConstants.forwardIcon,
                              height: 14.px,
                            ),
                          ],
                        ),
                      ],
                    ),
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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    'Total Gains',
                    color: AppColors.appGrey,
                    fontSize: 12.px,
                  ),
                  SizedBox(
                    width: 6.px,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      AppText(
                        '100',
                        fontSize: 14.px,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        '.500 KWD',
                        fontSize: 10.px,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4.px),
              Row(
                children: [
                  Icon(
                    Icons.arrow_upward_outlined,
                    size: 12.px,
                    color: AppColors.appGreen,
                  ),
                  SizedBox(width: 5.px),
                  AppText('2.1%',
                      fontSize: 12.px,
                      color: AppColors.appGreen,
                      fontWeight: FontWeight.w700),
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
      children: <Widget>[
        AppText(
          title ?? '',
          textAlign: TextAlign.center,
          fontSize: 10.px,
          fontWeight: FontWeight.w400,
          color: AppColors.appGrey,
        ),
        SizedBox(height: 4.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const AppText(
              '100',
            ),
            AppText(
              amount ?? '',
              fontSize: 12.px,
            ),
          ],
        ),
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
              decoration: const BoxDecoration(
                  color: AppColors.appLightGrey, shape: BoxShape.circle),
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
              const AppDivider(),
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
