
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../../constants/typedefs.dart';

// Endpoints
import '../../all_providers.dart';
import '../../local/key_value_storage_service.dart';
import '../api_endpoint.dart';

// Helpers

/// A class that holds intercepting logic for refreshing expired tokens. This
/// is the last interceptor in the queue.
class RefreshTokenInterceptor extends Interceptor {

  RefreshTokenInterceptor(
    this._ref, {
    required Dio dioClient,
  }) : _dio = dioClient;

  /// An instance of [Dio] for network requests
  final Dio _dio;
  final Ref _ref;

  /// The name of the exception on which this interceptor is triggered.
  // ignore: non_constant_identifier_names
  String get TokenExpiredException => 'TokenExpiredException';

  /// This method is used to send a refresh token request if the error
  /// indicates an expired token.
  ///
  /// In case of expired token, it creates a new [Dio] instance, replicates
  /// its options and locks the current instance to prevent further requests.
  /// The new instance retrieves a new token and updates it. The original
  /// request is retried with the new token.
  ///
  /// ** NOTE: ** Any requests from original instance will trigger all attached
  /// interceptors as expected.
  ///
  /// ** The structure of response in case of errors or the refresh request is
  /// dependant on the API and may not always be the same. It might need
  /// changing according to your own API. **
  @override
  Future<void> onError(
    DioException dioError,
    ErrorInterceptorHandler handler,
  ) async {
    if (dioError.response != null) {
      if (dioError.response!.data != null) {
        final JSON headers = dioError.response!.data['headers'] as JSON;

        // Check error type to be token expired error
        final String code = headers['code'] as String;
        if (code == TokenExpiredException) {
          // Make new dio and lock old one
          final Dio tokenDio = Dio()..options = _dio.options;

          // _dio.lock();

          // Get auth details for refresh token request
          final KeyValueStorageService kVStorageService = _ref.read(keyValueStorageServiceProvider);
          // final currentUser = _read(currentStudentProvider);
          final Map<String, String> data = <String, String>{
            'erp': '',
            'password': await kVStorageService.getAuthPassword(),
            'oldToken': await kVStorageService.getAuthToken(),
          };

          // Make refresh request and get new token
          final String? newToken = await _refreshTokenRequest(
            dioError: dioError,
            handler: handler,
            tokenDio: tokenDio,
            data: data,
          );

          if (newToken == null) {
            return super.onError(dioError, handler);
          }

          // Update auth and unlock old dio
          kVStorageService.setAuthToken(newToken);

          // Make original req with new token
          final Response<JSON> response = await _dio.request<JSON>(
            dioError.requestOptions.path,
            data: dioError.requestOptions.data,
            cancelToken: dioError.requestOptions.cancelToken,
            options: Options(
              headers: <String, Object?>{'Authorization': 'Bearer $newToken'},
            ),
          );
          return handler.resolve(response);
        }
      }
    }

    // if not token expired error, forward it to try catch in dio_service
    return super.onError(dioError, handler);
  }

  /// This method sends out a request to refresh the token. Since this request
  /// uses the new [Dio] instance it needs its own logging and error handling.
  ///
  /// ** The structure of response is dependant on the API and may not always
  /// be the same. It might need changing according to your own API. **
  Future<String?> _refreshTokenRequest({
    required DioException dioError,
    required ErrorInterceptorHandler handler,
    required Dio tokenDio,
    required JSON data,
  }) async {
    debugPrint('--> REFRESHING TOKEN');
    try {
      debugPrint('\tBody: $data');

      final Response<JSON> response = await tokenDio.post<JSON>(
        ApiEndpoint.auth(AuthEndpoint.REFRESH_TOKEN),
        data: data,
      );

      debugPrint('\tStatus code:${response.statusCode}');
      debugPrint('\tResponse: ${response.data}');

      // Check new token success
      final bool success = response.data?['headers']['error'] == 0;

      if (success) {
        debugPrint('<-- END REFRESH');
        return response.data?['body']['token'] as String;
      } else {
        throw Exception(response.data?['headers']['message']);
      }
    } on Exception catch (ex) {
      // only caught here for logging
      // forward to try-catch in dio_service for handling
      debugPrint('\t--> ERROR');
      if (ex is DioException) {
        final DioException de = ex;
        debugPrint('\t\t--> Exception: ${de.error}');
        debugPrint('\t\t--> Message: ${de.message}');
        debugPrint('\t\t--> Response: ${de.response}');
      } else {
        debugPrint('\t\t--> Exception: $ex');
      }
      debugPrint('\t<-- END ERROR');
      debugPrint('<-- END REFRESH');

      return null;
    } finally {
      // _dio.close();
      //   ..unlock()
    }
  }
}
