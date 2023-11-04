import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/info_card_view.dart';
import '../../../custom/divider/divider.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/wallet_view_model.dart';
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
                            return InvoiceCardView(
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
}
