import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/sheet/show_bottom_sheet.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../preference/view/preference_view.dart';
import '../viewsModel/home_views_model.dart';

class HomeViews extends StatefulWidget {
  const HomeViews({super.key});

  @override
  State<HomeViews> createState() => _HomeViewsState();
}

class _HomeViewsState extends State<HomeViews> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewsModel>(
      viewModel: HomeViewsModel(),
      onModelReady: (HomeViewsModel homeViewModel) {
        homeViewModel.init();
        homeViewModel.setContext(context);
      },
      onPageBuilder: (BuildContext context, HomeViewsModel homeViewsModel) {
        return Observer(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: AppColors.appWhite,
              appBar: HessaAppBar(
                icon: ImageConstants.avtar,
                title: 'Welcome!',
                subTitle: 'Abdullah Mohamed',
                onBellTap: () {
                  AppRouter.pushNamed(Routes.notificationView);
                },
                onSearchTap: () {
                  AppRouter.pushNamed(Routes.searchView);
                },
                onProfileTap: () {
                  showCommonBottomSheet(context: context, commonWidget: const PreferenceView());
                },
              ),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 30.px,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.px),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppColors.lightPurple, borderRadius: BorderRadius.circular(30.px)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        homeViewsModel.bottomBarItems.length,
                        (int index) => tabBarCardView(homeViewsModel.bottomBarItems[index], index, homeViewsModel),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.px,
                  ),
                  homeViewsModel.bottomBarItems[homeViewsModel.selectedIndex]['screenName'],
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget tabBarCardView(Map<String, dynamic> content, int index, HomeViewsModel homeViewsModel) {
    final bool isSelected = homeViewsModel.selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => homeViewsModel.onChangeIndex(index),
        child: Container(
          margin: const EdgeInsets.all(3),
          alignment: Alignment.center,
          width: 100.px,
          decoration: BoxDecoration(
              color: isSelected ? AppColors.appWhite : AppColors.lightPurple,
              borderRadius: BorderRadius.circular(30.px)),
          height: 30.px,
          child: AppText(
            content['title'],
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isSelected ? AppColors.appBlue : AppColors.appLightBlack.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
