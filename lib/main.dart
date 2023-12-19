
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'config/routes/app_router.dart';
import 'feature/splash/view/splash_view.dart';
import 'locale.dart';
import 'product/cache/locale_manager.dart';
import 'product/constants/app/app_constants.dart';
import 'product/lang/language_manager.dart';
// import 'product/theme/theme_notifier.dart';

Future<void> main() async {
  mainContext.config = mainContext.config
      .clone(isSpyEnabled: true, disableErrorBoundaries: false);
  await GetStorage.init();
  mainContext.spy(print);
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the Flutter binding
  LocaleManager.prefrencesInit();
  runApp(
    const MyApp(),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveSizer(
      builder: (BuildContext context, Orientation orientation,
          ScreenType screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            CountryLocalizations.delegate,
          ],
          onGenerateRoute: AppRouter.generateRoute,
          locale: LanguageManager.instance.enLocale,
          supportedLocales: LanguageManager.instance.supportedLocales,
          navigatorKey: AppRouter.navigatorKey,
          translations: Messages(),
            fallbackLocale:LanguageManager.instance.enLocale,
          // theme: context.watch<ThemeNotifier>().currentTheme,
          home: const SplashView(),
          // home: StudentProfileView(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
