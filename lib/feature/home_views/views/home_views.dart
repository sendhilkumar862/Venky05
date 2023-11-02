import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
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
              onProfileTap: () => AppRouter.pushNamed(Routes.PrefrencesScreen
              ),
              ),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.lightPurple,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        homeViewsModel.bottomBarItems.length,
                        (int index) => tabBarCardView(
                            homeViewsModel.bottomBarItems[index],
                            index,
                            homeViewsModel),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  homeViewsModel.bottomBarItems[homeViewsModel.selectedIndex]
                      ['screenName'],
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget tabBarCardView(
      Map<String, dynamic> content, int index, HomeViewsModel homeViewsModel) {
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
              borderRadius: BorderRadius.circular(30)),
          height: 30,
          child: AppText(
            content['title'],
            color: isSelected
                ? AppColors.appBlue
                : AppColors.appLightBlack.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
