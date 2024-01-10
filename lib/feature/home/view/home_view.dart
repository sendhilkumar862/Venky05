import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom/navgation/navbar.dart';
import '../../../custom/navgation/navbar_item.dart';
import '../../../product/cache/key_value_storeage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/context_extension.dart';
import '../../../product/utils/validators.dart';
import '../../home_views/views/home_views.dart';
import '../../preference/view/preference_view.dart';
import '../../tutorial/messages/view/message_view.dart';
import '../../wallet/walletView/view/wallet_view.dart';
import '../controller/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedProfile = '';
  final HomeController _homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    setData();
    _homeController.refreshToken();
  }

  Future<void> setData() async {
    final String token = LocaleManager.getAuthToken();
    if (token.isNotEmpty) {
      logs('Token--> $token');
      selectedProfile = LocaleManager.getValue(StorageKeys.profile) ?? '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          NavBar(
            color: Colors.white,
            showTitle: true,
            borderRadius: MediaQueryExtension(context).dynamicHeight(20),
            selectedIconColor: AppColors.appBlue,
            unselectedIconColor: AppColors.downArrowColor,
            items: <NavBarItem>[
              NavBarItem(
                selectedIconData: ImageConstants.homeHomeIconSelected,
                iconData: ImageConstants.homeHomeIcon,
                title: 'Home',
                page: const HomeViews(),
              ),
              NavBarItem(
                selectedIconData: ImageConstants.homeWalletIconSelected,
                iconData: ImageConstants.homeWalletIcon,
                title: 'Wallet',
                page: const WalletView(),
              ),
              NavBarItem(
                selectedIconData: ImageConstants.homeMessageIconSelected,
                iconData: ImageConstants.homeMessageIcon,
                title: 'Message',
                page: const MessageView(),
              )
            ],
            hapticFeedback: true,
            horizontalPadding: 40,
          ),
          Obx(() => _homeController.homeData.value?.userStatus == '4' &&
                  selectedProfile == ApplicationConstants.student
              ? Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      height: Get.height,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.95,
                            child: const PreferenceView()),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink())
        ],
      ),
    );
  }
}

class StatusUpdateNotification extends Notification {
  StatusUpdateNotification({this.message = '', this.profileStatus = ''});
  final String message;
  String profileStatus;
}
