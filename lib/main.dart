import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart' hide ScreenType;
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'config/routes/route.dart';
import 'feature/splash/controller/splash_controller.dart';
import 'feature/splash/view/splash_view.dart';
import 'locale.dart';
import 'product/lang/language_manager.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the Flutter binding
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
            GlobalMaterialLocalizations
                .delegate, // uses `flutter_localizations`
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // onGenerateRoute: Routes.generateRoute,
          locale: LanguageManager.instance.enLocale,
          supportedLocales: LanguageManager.instance.supportedLocales,
           navigatorKey: Routes.navigatorKey,
          translations: Messages(),
            initialRoute: Routes.AppRootRoute,
            fallbackLocale:LanguageManager.instance.arLocale,
          getPages:Routes.router,
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
