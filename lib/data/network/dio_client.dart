import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as enc;

import '../../product/cache/locale_manager.dart';
import '../../product/constants/app/app_constants.dart';

class DioClient {
  static final DioClient instance = DioClient._internal();

  final Dio _dio = Dio();

  final BaseOptions options = BaseOptions(
    baseUrl: 'http://167.99.93.83/api/v1',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );

  factory DioClient() {
    return instance;
  }

  DioClient._internal() {
    _dio.options = options;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          print(error.message);
          return handler.next(error);
        },
      ),
    );
  }

  final iv = enc.IV.fromLength(8);
  final encrypt = enc.Encrypter(enc.Salsa20(enc.Key.fromLength(32)));

//==============================================================================
// ** Header Function  **
//==============================================================================

  Future<Options> _headers({bool? isAuthorization = false}) async {
    String? accessToken =
        LocaleManager.instance.getStringValue(LocaleManager.accessToken);

    if (accessToken == "jhythj") {
      return Future.value(Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    } else if (isAuthorization == true) {
      return Options(
        headers: {
          'Content-Type': ' application/json',
          'X-Auth-Token':
              'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI5Iiwicm9sZSI6IlN0dWRlbnQiLCJqdGkiOiI3MTViMDFjMS0yNWIzLTQ5MWItODU0ZS1lOWE5MTdlOTllOTciLCJpYXQiOjE2OTk2MTM0NzAsImV4cCI6MTY5OTY5OTg3MCwiYXVkIjoiOSIsImlzcyI6Imhlc3NhIn0.hJ_rTBKmM_aJ7Tro5OyA1yXiGmDlqSnCDZ34FOTxBznI36-ZVOFzbnpoH8ZhUJ0X3qgQRezZ1EqfbLUx0l2cMwE96JPkRdB1Wj3vUnIZ2mpJLDMKiWBvU6AteFpxhXb6-fS3xhDyCdkjvZWvc1lCsuz7RHU0YRWeCo-qd6BMwezroXmowWR9b6oTeClSeHzZnR1PFo_bDfjCrQVBI5ow-Hcn1DdaIU0AUDymbOrvpU2TK-ahdAYJ_7boJ9ELh7oRfcsQghDBJ7EhrR0b79JuBfR_Ieqbnfs6HoK-GWINe-Hx_ZNrghq2HZl4sRgH1xq7LLo368-BXs1QxQzmN7rMsQ',
          //'Authorization': 'Bearer $accessToken',
        },
      );
    } else {
      return Options(
        headers: {'Content-Type': ' application/json'},
      );
    }
  }

//==============================================================================
// ** Get Auth Token Function  **
//==============================================================================

//==============================================================================
// ** Get call Function  **
//==============================================================================

  Future<Either<String, String>> getApi(
      {required String url, bool? isAuthorization}) async {
    try {
      var res = await _dio.get(
        url,
        options: await _headers(isAuthorization: isAuthorization),
      );
      // ResponseModel response = setResponseObject(
      //     res.statusCode ?? StatusCodeConstants.statusOkCode,
      //     json.encode(res.data),
      //     res.headers);

      if (StatusCodeConstants.successCodes.contains(res.statusCode)) {
        return Right(json.encode(res.data));
      } else if (StatusCodeConstants.authorityCodes.contains(res.statusCode)) {
        return await getApi(url: url);
      } else {
        return Left(json.encode(res.data));
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

//==============================================================================
// ** Post call Function  **
//==============================================================================

  Future<Either<String, String>> postApi(
      {required String url, dynamic body}) async {
    try {
      var res = await _dio.post(
        url,
        options: await _headers(),
        data: body,
      );
      /* ResponseModel response = setResponseObject(
          res.statusCode ?? StatusCodeConstants.statusOkCode,
          json.encode(res.data),
          res.headers);*/
      if (StatusCodeConstants.successCodes.contains(res.statusCode)) {
        return Right(json.encode(res.data));
      } else if (StatusCodeConstants.authorityCodes.contains(res.statusCode)) {
        // Calling a API for get token if got the state unauthorized
        return await postApi(url: url, body: body);
      } else {
        return Left(json.encode(res.data));
      }
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {
        // Retry the API call
        print('Status code:${e.response?.statusCode}');
        return await postApi(url: url, body: body);
      } else if (e is DioError && e.response?.statusCode == 422) {
        print('Status code:${e.response?.statusCode}');
        return Left(json.encode(e.response));
      } else if (e is DioError && e.response?.statusCode == 400) {
        print('Status code:${e.response?.statusCode}');
        return Left(json.encode(e.response));
      } else {
        print('Caught an exception: $e');
        return Left(e.toString());
      }
    }
  }

//==============================================================================
// ** Put call Function  **
//==============================================================================

  Future<Either<String, String>> putApi(
      {required String url, String? body}) async {
    try {
      var res =
          await _dio.put(url, options: await _headers(isAuthorization: true));
      if (res.statusCode == 201 ||
          res.statusCode == 202 ||
          res.statusCode == 204) {
        return const Right('Success');
      } else {
        return const Left('Fail');
      }
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {
        // Retry the API call
        return await putApi(url: url, body: body);
      }
      if (e is DioError && e.response?.statusCode == 422) {
        return Left(e.response!.toString());
      }
      if (e is DioError && e.response?.statusCode == 304) {
        return Left(e.response!.toString());
      }
      return Left(e.toString());
    }
  }

//==============================================================================
// ** Delete call Function  **
//==============================================================================

  Future<Either<String, String>> deleteApi({required String url}) async {
    try {
      var res = await _dio.delete(url,
          options: await _headers(isAuthorization: true));

      if (res.statusCode == 201 ||
          res.statusCode == 202 ||
          res.statusCode == 204) {
        return const Right('Success');
      } else {
        return const Left('Fail');
      }
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {
        // Retry the API call
        return await deleteApi(url: url);
      }
      return Left(e.toString());
    }
  }

//==============================================================================
// ** Manage Response call Function  **
//==============================================================================

  // ResponseModel setResponseObject(
  //   int statusCode,
  //   String body,
  //   _ResponseHeadersModel,
  // ) {
  //   try {
  //     if (StatusCodeConstants.badRequestCodes.contains(statusCode)) {
  //       return ResponseModel(body: emptyString, headers: _ResponseHeadersModel);
  //     } else if (StatusCodeConstants.authorityCodes.contains((statusCode))) {
  //       return ResponseModel(
  //         body: emptyString,
  //         headers: _ResponseHeadersModel.,
  //       );
  //     } else if (StatusCodeConstants.errorCodes.contains(statusCode)) {
  //       return ResponseModel(
  //         body: emptyString,
  //         headers: _ResponseHeadersModel,
  //       );
  //     } else if (StatusCodeConstants.notFoundCode.contains(statusCode)) {
  //       return ResponseModel(
  //         body: emptyString,
  //         headers: _ResponseHeadersModel,
  //       );
  //     } else if (StatusCodeConstants.successCodes.contains(statusCode)) {
  //       return ResponseModel(
  //         headers: _ResponseHeadersModel,
  //         body: body,
  //       );
  //     }
  //   } catch (e) {
  //     return ResponseModel(
  //       body: emptyString,
  //       headers: _ResponseHeadersModel,
  //     );
  //   }
  //
  //   return ResponseModel(
  //     body: emptyString,
  //     headers: _ResponseHeadersModel,
  //   );
  // }
}
