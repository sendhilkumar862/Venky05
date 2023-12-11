import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/constants/typedefs.dart';
import '../../../product/network/all_providers.dart';
import '../../../product/network/networking/api_endpoint.dart';
import '../../../product/network/networking/api_service.dart';
import 'model/country_model.dart';


final languageRepositoryProvider = Provider<LanguageRepository>((ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return LanguageRepository(apiService: _apiService);
});

class LanguageRepository {

  LanguageRepository({
    required ApiService apiService,
  }) : _apiService = apiService;
  final ApiService _apiService;

  Future<List<Country>> fetchAll({JSON? queryParameters}) async {
    return _apiService.getCollectionData<Country>(
      endpoint: ApiEndpoint.country(Public.COUNTRY),
      queryParams: queryParameters,
      cachePolicy: CachePolicy.forceCache,
      converter: Country.fromJson,
    );
  }
}
