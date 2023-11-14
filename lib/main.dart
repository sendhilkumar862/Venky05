import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:riverpod/src/framework.dart';

import 'config/routes/app_router.dart';
import 'feature/splash/view/splash_first.dart';
import 'feature/tutorial/language/language_repository.dart';
import 'product/cache/locale_manager.dart';
import 'product/constants/app/app_constants.dart';
import 'product/lang/language_manager.dart';
import 'product/network/local/key_value_storage_service.dart';
import 'product/network/local/path_provider_service.dart';
import 'product/network/networking/api_endpoint.dart';
import 'product/network/networking/api_service.dart';
import 'product/network/networking/dio_service.dart';
import 'product/network/networking/interceptors/api_interceptor.dart';
import 'product/network/networking/interceptors/logging_interceptor.dart';
import 'product/network/networking/interceptors/refresh_token_interceptor.dart';
import 'product/notifier/app_provider.dart';
import 'product/theme/theme_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the Flutter binding
  LocaleManager.prefrencesInit();
  await EasyLocalization.ensureInitialized();
  runApp(
   ProviderScope(child: EasyLocalization(
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: ApplicationConstants.LANG_ASSET_PATH,
        startLocale: LanguageManager.instance.enLocale,
        child: const MyApp(),
      ),
    )
   
   
  //   MultiProvider(
  //     providers: <SingleChildWidget>[
  //       ...ApplicationProvider.instance.dependItems,
       
  //       Provider<KeyValueStorageService>(
  //       create: (_) => KeyValueStorageService(),
  //     ),
  //     Provider<Dio>(
  //       create: (_) {
  //         final BaseOptions baseOptions = BaseOptions(
  //           baseUrl: ApiEndpoint.baseUrl,
  //         );
  //         return Dio(baseOptions);
  //       },
  //     ),
  //     Provider<DioService>(
  //       create: (BuildContext ref) {
  //         final Dio _dio = ref.watch<Dio>();
  //         final CacheOptions _cacheOptions = CacheOptions(
  //           store: HiveCacheStore(PathProviderService.path),
  //           policy: CachePolicy.noCache,
  //           maxStale: const Duration(days: 30),
  //           keyBuilder: (RequestOptions options) => options.path,
  //         );
  //         return DioService(
  //           dioClient: _dio,
  //           globalCacheOptions: _cacheOptions,
  //           interceptors: <Interceptor>[
  //             ApiInterceptor(ref as Ref<Object?>),
  //             DioCacheInterceptor(options: _cacheOptions),
  //             if (kDebugMode) LoggingInterceptor(),
  //             RefreshTokenInterceptor(ref as Ref<Object?>, dioClient: _dio),
  //           ],
  //         );
  //       },
  //     ),
  //      Provider<ApiService>(
  //       create: (BuildContext ref) {
  //         final DioService _dioService = ref.watch<DioService>();
  //         return ApiService(_dioService);
  //       },
  //     ),
       
  //     ],
  //     child: EasyLocalization(
  //       supportedLocales: LanguageManager.instance.supportedLocales,
  //       path: ApplicationConstants.LANG_ASSET_PATH,
  //       startLocale: LanguageManager.instance.enLocale,
  //       child: const MyApp(),
  //     ),
  //   ),
  );
}

class MyApp extends ConsumerWidget  {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          // theme: ref.watch<ThemeNotifier>().currentTheme,
          home: const SplashFirst(),
        );
      },
    );
  }
}
