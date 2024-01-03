import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../config/routes/route.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/cache/key_value_storeage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../home/controller/home_controller.dart';
import '../controller/home_view_controller.dart';

class HomeViews extends StatefulWidget {
  const HomeViews({super.key});

  @override
  State<HomeViews> createState() => _HomeViewsState();
}

class _HomeViewsState extends State<HomeViews> with TickerProviderStateMixin {
  String selectedUserStatus = '';
  String selectedProfile = '';
  final HomeController _homeController = Get.find();
  final HomeViewController _homeViewController = Get.put(HomeViewController());
  @override
  void initState() {
    super.initState();

    selectedProfile =
        LocaleManager.getValue(StorageKeys.profile) ??'';
    selectedUserStatus =  LocaleManager.getValue(StorageKeys.userInfoStatus) ??'';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.appWhite,
        appBar: HessaAppBar(
          icon: ImageConstants.avtar,
          title: 'Welcome!',
          subTitle:
              "${_homeController.homeData.value?.firstName ?? ""} ${_homeController.homeData.value?.lastName ?? ""}",
          isSearchIconShown: !(selectedProfile == ApplicationConstants.tutor &&
              selectedUserStatus != '99'),
          onBellTap: () {
            Get.toNamed(Routes.notificationView);
          },
          onSearchTap: () {
            Get.toNamed(Routes.searchView);
          },
          onProfileTap: () {
            Get.toNamed(Routes.settingView);
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
              decoration: BoxDecoration(
                  color: AppColors.lightPurple,
                  borderRadius: BorderRadius.circular(30.px)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _homeViewController.bottomBarItems.length,
                  (int index) => tabBarCardView(
                      _homeViewController.bottomBarItems[index], index),
                ),
              ),
            ),
            SizedBox(
              height: 2.px,
            ),
            _homeViewController
                    .bottomBarItems[_homeViewController.selectedIndex.value]
                ['screenName'],
          ],
        ),
      ),
    );
  }

  Widget tabBarCardView(Map<String, dynamic> content, int index) {
    final bool isSelected = _homeViewController.selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _homeViewController.onChangeIndex(index),
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
            color: isSelected
                ? AppColors.appBlue
                : AppColors.appLightBlack.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
