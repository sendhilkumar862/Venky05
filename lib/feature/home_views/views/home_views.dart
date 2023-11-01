import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/image/app_image_assets.dart';
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
  Widget tabBarCardView(
      Map<String, dynamic> content, int index, HomeViewsModel value) {
    final bool isSelected = value.selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => value.onChangeIndex(index),
        child: Container(
          margin: const EdgeInsets.only(left: 4, top: 4, bottom: 4, right: 4),
          alignment: Alignment.center,
          width: 100,
          decoration: BoxDecoration(
              color: isSelected ? AppColors.appWhite : AppColors.lightPurple,
              borderRadius: BorderRadius.circular(30)),
          height: 30,
          child: AppText(
            content['title'],
            color: isSelected ? AppColors.appBlue : AppColors.appLightBlack,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewsModel>(
      viewModel: HomeViewsModel(),
      onModelReady: (HomeViewsModel model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, HomeViewsModel homeViewModel) {
        return Observer(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: AppColors.appWhite,
              appBar: HessaAppBar(
                icon: ImageConstants.avtar,
                title: 'Welcome!',
                subTitle: 'Abdullah Mohamed',
                onProfileTap: () {
                  showCommonBottomSheet(
                      context: context, commonWidget: const PreferenceView());
                },
              ),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 35,
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
                          homeViewModel.bottomBarItems.length,
                          (int index) => tabBarCardView(
                              homeViewModel.bottomBarItems[index],
                              index,
                              homeViewModel)),
                    ),
                  ),
                  homeViewModel.bottomBarItems[homeViewModel.selectedIndex]
                      ['screenName']
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class CardView extends StatelessWidget {
  const CardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.appWhite,
          border: Border.all(color: AppColors.appLightGrey)),
      child: Column(
        children: <Widget>[
          const Row(
            children: <Widget>[
              AppText(
                'Math',
                fontWeight: FontWeight.w800,
                fontSize: 20,
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              tagCarView('Grade 2', ImageConstants.groupIcon),
              tagCarView('British', ImageConstants.groupIcon),
              tagCarView('Group', ImageConstants.groupIcon),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              infoCardView(ImageConstants.dateIcon, '12/12 12:30pm'),
              infoCardView(ImageConstants.timerIcon, '1h 30m'),
              infoCardView(ImageConstants.moneyIcon, '5.500 KWD'),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.lightPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(children: <Widget>[
              // AppImageAsset(
              //   image: ImageConstants.avtar,
              //   height: 30,
              // ),
            ]),
          )
        ],
      ),
    );
  }

  Padding infoCardView(String icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        children: <Widget>[
          AppImageAsset(
            image: icon,
            height: 12,
          ),
          const SizedBox(
            width: 4,
          ),
          AppText(
            title,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }

  Container tagCarView(String title, String icon) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          AppImageAsset(
            image: icon,
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: AppText(
              title,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
