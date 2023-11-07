import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../tutorial/view/language_view.dart';
import '../viewModel/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        AppRouter.push(const SecondSplash());
      },
    );
  }

  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
        viewModel: SplashViewModel(),
        onModelReady: (SplashViewModel splashViewModel) {
          splashViewModel.setContext(context);
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
                      image: ImageConstants.starWhite,
                      height: 100.px,
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

class SecondSplash extends StatefulWidget {
  const SecondSplash({super.key});

  @override
  State<SecondSplash> createState() => _SecondSplashState();
}

class _SecondSplashState extends State<SecondSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        AppRouter.push(const LanguageView());
      },
    );
  }

  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
        viewModel: SplashViewModel(),
        onModelReady: (SplashViewModel splashViewModel) {
          splashViewModel.setContext(context);
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
