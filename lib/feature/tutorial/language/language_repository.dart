import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../product/constants/typedefs.dart';
import '../../../product/network/all_providers.dart';
import '../../../product/network/networking/api_endpoint.dart';
import '../../../product/network/networking/api_service.dart';
import 'country_model.dart';
import 'language_view_model.dart';

final languageRepositoryProvider = Provider<LanguageRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return LanguageRepository(apiService: _apiService);
});

class LanguageRepository {
  final ApiService _apiService;

  LanguageRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<Country>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<Country>(
      endpoint: ApiEndpoint.country(Public.COUNTRY),
      queryParams: queryParameters,
      cachePolicy: CachePolicy.forceCache,
      converter: Country.fromJson,
    );
  }
}
