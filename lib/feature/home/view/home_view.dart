import 'package:flutter/material.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/navgation/navbar.dart';
import '../../../custom/navgation/navbar_item.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/extension/context_extension.dart';
import '../../home_views/views/home_views.dart';
import '../../preference/view/preference_view.dart';
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
      onPageBuilder: (BuildContext context, HomeViewModel value) =>  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavBar(
        color: Colors.white,
        showTitle: true,
        borderRadius: MediaQueryExtension(context).dynamicHeight(20),
        selectedIconColor:AppColors.primaryColor,
        unselectedIconColor: AppColors.secondaryColor,
        items: <NavBarItem>[
          NavBarItem(
            iconData: Icons.home,
            title: 'Home',
            page: const HomeViews(),
          ),
          NavBarItem(
            iconData: Icons.account_circle,
            title: 'Account',
            page: const PreferenceView(),
          ),
           NavBarItem(
            iconData: Icons.message_rounded,
            title: 'Message',
            page: Container(),
          )
        ],
        hapticFeedback: true,
        horizontalPadding: 40,
      ),
    ),
    );
  }
}
