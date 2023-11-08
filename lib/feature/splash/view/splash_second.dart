import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../custom/image/app_image_assets.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/splash_view_model.dart';

class SplashSecond extends StatelessWidget {
  const SplashSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
        viewModel: SplashViewModel(),
        onModelReady: (SplashViewModel splashViewModel) {
          splashViewModel.setContext(context);
          splashViewModel.init();
        },
        onPageBuilder: (BuildContext context, SplashViewModel homeViewsModel) {
          return Observer(builder: (BuildContext context) {
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(color: AppColors.appBlue),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    AppImageAsset(
                      image: ImageConstants.primaryLogo,
                      height: 50.px,
                    ),
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
