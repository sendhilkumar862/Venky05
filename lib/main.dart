import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hessah/product/constants/colors/app_colors_constants.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'config/routes/app_router.dart';
import 'feature/splash/view/splash_first.dart';
import 'product/cache/locale_manager.dart';
import 'product/constants/app/app_constants.dart';
import 'product/lang/language_manager.dart';
import 'product/notifier/app_provider.dart';
import 'product/theme/theme_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the Flutter binding
  LocaleManager.prefrencesInit();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ...ApplicationProvider.instance.dependItems
      ],
      child: EasyLocalization(
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: ApplicationConstants.LANG_ASSET_PATH,
        startLocale: LanguageManager.instance.enLocale,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (BuildContext context, Orientation orientation,
          ScreenType screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          onGenerateRoute: AppRouter.generateRoute,
          locale: LanguageManager.instance.enLocale,
          supportedLocales: LanguageManager.instance.supportedLocales,
          navigatorKey: AppRouter.navigatorKey,
          theme: context.watch<ThemeNotifier>().currentTheme,
          builder: EasyLoading.init(
            builder: (buildContext, Widget? widget) {
              return widget!;
            },
          ),
          home: const SplashFirst(),
        );
      },
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45
    ..textColor = AppColors.black
    ..radius = 5
    ..backgroundColor = AppColors.white
    ..maskColor = AppColors.darkCyan
    ..indicatorColor = AppColors.black
    ..userInteractions = false
    ..dismissOnTap = false
    ..boxShadow = <BoxShadow>[]
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..indicatorType = EasyLoadingIndicatorType.circle;
}
