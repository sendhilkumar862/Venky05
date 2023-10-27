import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hessah/custom/navgation/navbar.dart';
import 'package:hessah/custom/navgation/navbar_item.dart';
import 'package:hessah/feature/preference/view/preference_view.dart';
import 'package:hessah/product/constants/colors/app_colors_constants.dart';

import '../../../../product/base/view/base_view.dart';
import '../../home_views/views/home_views.dart';
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
      onPageBuilder: (context, value) =>  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavBar(
        resizeToAvoidBottomInset: false,
        color: Colors.white,
        showTitle: true,
        borderRadius: 30,
        selectedIconColor:AppColors.primaryColor,
        unselectedIconColor: AppColors.secondaryColor,
        items: [
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
