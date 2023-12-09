import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/amount/app_amount_view.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/info_card_view.dart';
import '../../../custom/divider/divider.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/wallets_view_model.dart';
import 'invoice_card_view.dart';
import 'invoice_filter.dart';

class ViewAllView extends StatefulWidget {
  const ViewAllView({super.key});

  @override
  State<ViewAllView> createState() => _ViewAllViewState();
}

class _ViewAllViewState extends State<ViewAllView>
    with TickerProviderStateMixin {
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
                icon: ImageConstants.avtar,
                title: 'Invoices',
                isTitleOnly: true,
              ),
              body: Column(
                children: <Widget>[
                  SizedBox(height: 35.px),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          useSafeArea: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  topLeft: Radius.circular(24))),
                          context: context,
                          builder: (BuildContext bc) {
                            return StatefulBuilder(
                                builder: (BuildContext context, setState) {
                              return const InvoiceFilter();
                            });
                          });
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          AppText(
                            'Sort / Filter',
                            fontSize: 14.px,
                            fontWeight: FontWeight.w600,
                            color: AppColors.appBlue,
                          ),
                          SizedBox(width: 4.px),
                          AppImageAsset(
                              image: ImageConstants.filterIcon, height: 20.px),
                          SizedBox(
                            width: 15.px,
                          )
                        ]),
                  ),
                  SizedBox(height: 15.px),
                  if (false)
                    InfoCardVIew(
                      title: 'No Invoices!',
                      subTitle: 'Book classes or create new to see invoices.',
                      buttonTitle: 'Create New Class',
                      buttonTap: () {},
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {

                            return invoiceCardView(
                              title: 'Class Fees',
                              invoiceNumber: '#123456',
                              amount: '100.500 KWD',
                              date: '',
                              onTap: () {},
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: EdgeInsets.only(left: 15.px),
                                child: AppDivider());
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            AppAmountView(amount: amount),
                            SizedBox(width: 18.px),
                            AppImageAsset(
                              image: ImageConstants.forwardIcon,
                              height: 14.px,
                            ),
                            SizedBox(width: 18.px)
                          ],
                        ),
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
}
