import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Interceptors
import 'local/key_value_storage_service.dart';
import 'local/path_provider_service.dart';

// Services
import 'networking/api_endpoint.dart';
import 'networking/api_service.dart';
import 'networking/dio_service.dart';
import 'networking/interceptors/api_interceptor.dart';
import 'networking/interceptors/logging_interceptor.dart';
import 'networking/interceptors/refresh_token_interceptor.dart';


final keyValueStorageServiceProvider = Provider<KeyValueStorageService>(
  (ref) => KeyValueStorageService(),
);

final _dioProvider = Provider<Dio>((ref) {
  final baseOptions = BaseOptions(
    baseUrl: ApiEndpoint.baseUrl,
  );
  return Dio(baseOptions);
});

final _dioServiceProvider = Provider<DioService>((ref) {
  final _dio = ref.watch(_dioProvider);
  final _cacheOptions = CacheOptions(
    store: HiveCacheStore(PathProviderService.path),
    policy: CachePolicy.noCache, // Bcz we force cache on-demand in repositories
    maxStale: const Duration(days: 30), // No of days cache is valid
    keyBuilder: (options) => options.path,
  );
  return DioService(
    dioClient: _dio,
    globalCacheOptions: _cacheOptions,
    interceptors: [
      // Order of interceptors very important
      ApiInterceptor(ref),
      DioCacheInterceptor(options: _cacheOptions),
      if (kDebugMode) LoggingInterceptor(),
      RefreshTokenInterceptor(ref, dioClient: _dio)
    ],
  );
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final _dioService = ref.watch(_dioServiceProvider);
  return ApiService(_dioService);
});
