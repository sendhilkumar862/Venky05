import 'package:flutter/material.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/navgation/navbar.dart';
import '../../../custom/navgation/navbar_item.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/context_extension.dart';
import '../../home_views/views/home_views.dart';
import '../../preference/view/preference_view.dart';
import '../../tutorial/messages/view/message_view.dart';
import '../../wallet/view/wallet_view.dart';
import '../viewModel/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (HomeViewModel model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, HomeViewModel value) => MaterialApp(
        home: NavBar(
          color: Colors.white,
          showTitle: true,
          borderRadius: MediaQueryExtension(context).dynamicHeight(20),
          selectedIconColor: AppColors.appBlue,
          unselectedIconColor: AppColors.appDarkBlack,
          items: <NavBarItem>[
            NavBarItem(
              iconData: ImageConstants.homeHomeIcon,
              title: 'Home',
              page: const HomeViews(),
            ),
            NavBarItem(
              iconData: ImageConstants.homeWalletIcon,
              title: 'Wallet',
              page: WalletView(),
            ),
            NavBarItem(
              iconData: ImageConstants.homeMessageIcon,
              title: 'Message',
              page: MessageView(),
            )
          ],
          hapticFeedback: true,
          horizontalPadding: 40,
        ),
      ),
    );
  }
}
