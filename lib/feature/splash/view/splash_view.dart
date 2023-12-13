import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../custom/image/app_image_assets.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/validators.dart';
import '../viewModel/splash_view_model.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logs('Current Screen--> $runtimeType');

    return BaseView<SplashViewModel>(
        viewModel: SplashViewModel(),
        onModelReady: (SplashViewModel splashViewModel, WidgetRef ref) {
          splashViewModel.setContext(context);
          splashViewModel.init();
        },
        onPageBuilder: (BuildContext context, SplashViewModel homeViewsModel, WidgetRef ref) {
          return Observer(builder: (BuildContext context) {
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(color: AppColors.appBlue),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Lottie.asset(ImageConstants.splash, height: 400.px),
                    const Column(
                      children: <Widget>[
                        Expanded(
                          child: AppImageAsset(
                            image: ImageConstants.splashBG,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: AppImageAsset(
                            image: ImageConstants.splashBG,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: AppImageAsset(
                            image: ImageConstants.splashBG,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
