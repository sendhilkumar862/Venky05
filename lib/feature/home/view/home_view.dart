import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/navgation/navbar.dart';
import '../../../custom/navgation/navbar_item.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/context_extension.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../../product/utils/validators.dart';
import '../../home_views/views/home_views.dart';
import '../../preference/view/preference_view.dart';
import '../../tutorial/messages/view/message_view.dart';
import '../../wallet/view/wallet_view.dart';
import '../viewModel/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService = KeyValueStorageService();
  String selectedProfile = '';
  bool getPreference = true;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    final String token = await keyValueStorageService.getAuthToken();
    if (token.isNotEmpty) {
      logs('Token--> $token');
      selectedProfile = keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ?? '';
      getPreference = keyValueStorageBase.getCommon(bool, KeyValueStorageService.setPreference) ?? false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (HomeViewModel model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, HomeViewModel value) => WillPopScope(
        onWillPop: () async {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              NavBar(
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
              if (selectedProfile == ApplicationConstants.student && !getPreference)
                Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child:
                            Container(height: MediaQuery.of(context).size.height * 0.95, child: const PreferenceView()),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
