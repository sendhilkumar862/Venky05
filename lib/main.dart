import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'config/routes/app_router.dart';
import 'feature/splash/view/splash_first.dart';
import 'feature/tutorial/chat/view/chat_view.dart';
import 'feature/tutorial/messages/view/message_view.dart';
import 'feature/tutorial/mobileEnter/view/mobile_view.dart';
import 'feature/tutorial/verify_otp/verify_otp_view/verify_otp_view.dart';
import 'product/cache/locale_manager.dart';
import 'product/constants/app/app_constants.dart';
import 'product/lang/language_manager.dart';
import 'product/notifier/app_provider.dart';
import 'product/theme/theme_notifier.dart';

Future<void> main() async {
  mainContext.config = mainContext.config
      .clone(isSpyEnabled: true, disableErrorBoundaries: false);

  mainContext.spy(print);
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
           home: const SplashFirst(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
