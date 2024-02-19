
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../custom/appbar/appBarOnBoard.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/cache/key_value_storage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../view/bottomSheets/about_app_bottom_view.dart';
import '../Controller/profile_set_controller.dart';

class ProfileSelectionView extends StatelessWidget {
   ProfileSelectionView({super.key, });
   bool continueRegistration=false;
  final ProfileSetController _profileSetController= Get.put(ProfileSetController());

   @override
   void initState() {
     continueRegistration = Get.arguments['continueRegistration'];
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      appBar: AppBarOnBoard(
        backNavigate: !(continueRegistration ?? false),
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
              return AboutAppBottomSheet(data: _profileSetController.data);
            },
          );
        },
        onBackTap: () {
          LocaleManager.setValue( StorageKeys.country,'');
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.px),
        child: Column(
          children: <Widget>[
            SizedBox(height: 80.px),
            Lottie.asset(ImageConstants.profileManager,
                height: 210.px),
            SizedBox(
              height: 15.px,
            ),
            AppText(
              'selectYourProfile'.tr,
              textAlign: TextAlign.center,
              fontSize: 24.px,
              fontWeight: FontWeight.w800,
            ),
            SizedBox(
              height: 25.px,
            ),
            Obx((){
              return Row(
                children: List<Widget>.generate(
                  2,
                      (int index) => selectCardView(
                    icon: index==0?ImageConstants.graduateIcon:ImageConstants.parentIcon,
                    title: _profileSetController.profileItems[index],
                    index: index,
                    onTap: () => _profileSetController.selectProfile(index),
                  ),
                ),
              );}
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(()=>
       PreLoginCommonButton(
            title: 'continue'.tr,
            // ignore: avoid_bool_literals_in_conditional_expressions
            isDisable: _profileSetController.selectedIndex.value!=2?false:true,
            onTap: _profileSetController.onTapSubmit),
      ),
    );
  }

  Widget selectCardView(
      {String? icon,
      String? title,
      VoidCallback? onTap,
      int? index}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.px),
          height: 88.px,
          padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 12.px),
          decoration: BoxDecoration(
            color: index == _profileSetController.selectedIndex.value
                ? AppColors.appBlue
                : AppColors.white,
            borderRadius: BorderRadius.circular(12.px),
            border: Border.all(
                color: index == _profileSetController.selectedIndex.value
                    ? AppColors.appBlue
                    : AppColors.lightPurple,
                width: 1.5.px),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              AppImageAsset(
                image: icon!,
                height: 25.px,
                color: index != _profileSetController.selectedIndex.value
                    ? AppColors.appDarkBlack
                    : AppColors.white,
              ),
              SizedBox(
                width: 12.px,
              ),
              AppText(
                title ?? '',
                fontWeight: FontWeight.w400,
                color: index != _profileSetController.selectedIndex.value
                    ? AppColors.appDarkBlack
                    : AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
