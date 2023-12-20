
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide ScreenType;
import 'package:get_storage/get_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'config/routes/app_router.dart';
import 'feature/splash/view/splash_view.dart';
import 'feature/splash/controller/splash_controller.dart';
import 'locale.dart';
import 'product/cache/locale_manager.dart';
import 'product/lang/language_manager.dart';


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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
          initialBinding: initialBinding(),
          home: const SplashView(),
          // home: StudentProfileView(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
class initialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}