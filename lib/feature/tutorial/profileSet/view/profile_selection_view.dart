import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hessah/product/network/local/key_value_storage_base.dart';
import 'package:hessah/product/network/local/key_value_storage_service.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../custom/appbar/appBarOnBoard.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../view/bottomSheets/about_app_bottom_view.dart';
import '../viewModel/profile_view_model.dart';

class ProfileSelectionView extends StatelessWidget {
  const ProfileSelectionView({super.key, this.continueRegistration});
  final bool? continueRegistration;

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        viewModel: ProfileViewModel(),
        onModelReady: (ProfileViewModel profileViewModel) {
          profileViewModel.setContext(context);
          profileViewModel.init();
        },
        onPageBuilder:
            (BuildContext context, ProfileViewModel profileViewModel) {
          return Observer(builder: (BuildContext context) {

            return WillPopScope(
              onWillPop: () async {
                final KeyValueStorageBase keyValueStorageBase =
                    KeyValueStorageBase();
                keyValueStorageBase.setCommon(
                    KeyValueStorageService.country, '');
                return true;
              },
              child: Scaffold(
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
                        return AboutAppBottomSheet(data: profileViewModel.data);
                      },
                    );
                  },
                  onBackTap: () {
                    final KeyValueStorageBase keyValueStorageBase =
                        KeyValueStorageBase();
                    keyValueStorageBase.setCommon(
                        KeyValueStorageService.country, '');
                    AppRouter.pop(context);
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
                        'selectYourProfile'.tr(),
                        textAlign: TextAlign.center,
                        fontSize: 24.px,
                        fontWeight: FontWeight.w800,
                      ),
                      SizedBox(
                        height: 25.px,
                      ),
                      Row(
                        children: List<Widget>.generate(
                          2,
                          (int index) => selectCardView(
                            icon: ImageConstants.graduateIcon,
                            title: profileViewModel.profileItems[index],
                            profileViewModel: profileViewModel,
                            index: index,
                            onTap: () => profileViewModel.selectProfile(index),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: PreLoginCommonButton(
                    title: 'continue'.tr(),
                    isDisable: !profileViewModel.isSelected(),
                    onTap: profileViewModel.onTapSubmit),
              ),
            );
          });
        });
  }

  Widget selectCardView(
      {String? icon,
      String? title,
      VoidCallback? onTap,
      ProfileViewModel? profileViewModel,
      int? index}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.px),
          height: 88.px,
          padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 12.px),
          decoration: BoxDecoration(
            color: index == profileViewModel!.selectedIndex
                ? AppColors.appBlue
                : AppColors.white,
            borderRadius: BorderRadius.circular(12.px),
            border: Border.all(
                color: index == profileViewModel.selectedIndex
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
                color: index != profileViewModel.selectedIndex
                    ? AppColors.appDarkBlack
                    : AppColors.white,
              ),
              SizedBox(
                width: 12.px,
              ),
              AppText(
                title ?? '',
                fontWeight: FontWeight.w400,
                color: index != profileViewModel.selectedIndex
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
