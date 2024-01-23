import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart' hide ScreenType;
import 'package:get_storage/get_storage.dart';
import 'package:mirrorfly_plugin/flychat.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'config/config.dart';
import 'config/routes/route.dart';
import 'feature/splash/controller/splash_controller.dart';
import 'feature/splash/view/splash_view.dart';
import 'locale.dart';
import 'product/lang/language_manager.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Initialize the Flutter binding
    await Mirrorfly.initializeSDK(
        // baseUrl: Config.mirrorFlyBaseURL,
        licenseKey: Config.mirrorFlyLicenceKey,
        iOSContainerID: Config.bundleId);
  } catch (e) {
    // await Mirrorfly.initializeSDK(
    //      licenseKey: Config.mirrorFlyLicenceKey,
    //      iOSContainerID: Config.bundleId);}catch(e){
    if (kDebugMode) {
      print(e);
    }
  }
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
          // ignore: always_specify_types
          localizationsDelegates: const <LocalizationsDelegate>[
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
          fallbackLocale: LanguageManager.instance.arLocale,
          getPages: Routes.router,
          // theme: context.watch<ThemeNotifier>().currentTheme,
          initialBinding: InitialBinding(),
          home: const SplashView(),
          // home: StudentProfileView(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
