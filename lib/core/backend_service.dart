import 'dart:async';
import 'dart:io';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:http_parser/http_parser.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mime/mime.dart';
import '../config/routes/route.dart';
import '../product/cache/local_manager.dart';
import '../product/constants/enums/backend_services_method_enums.dart';
import '../product/utils/validators.dart';
import 'api_end_points.dart';
import 'base_request.dart';
import 'base_response.dart';
import 'status_code.dart';

class BackendService {
  static Future<BaseResponse> post(BaseRequest request) async {
    final String authToken = LocaleManager.getAuthToken();
    if (authToken != '') {
      request.header.addAll({'X-Auth-Token': authToken});
    }
    final Dio dio = Dio();
    try {
      // final ConnectivityResult connectivityResult =
      //     await Connectivity().checkConnectivity();
      final bool isConnected = await InternetConnectionChecker().hasConnection;
      // if (connectivityResult == ConnectivityResult.none) {
      if (!isConnected) {
        return BaseResponse(
            status: Status(type: 'error', message: 'No internet connection'));
      }
      final Response response;
      if (request.apiMethod == BackEndServicesEnum.POST) {
        print("checking URL:::${ApiEndpoint.baseUrl + request.endPoint} ");
        response = await dio.post(
          ApiEndpoint.baseUrl + request.endPoint,
          options: Options(
            headers: request.header,
          ),
          data: request.body,
        );
      } else if (request.apiMethod == BackEndServicesEnum.GET) {
        response = await dio.get(
          ApiEndpoint.baseUrl + request.endPoint,
          options: Options(
            headers: request.header,
          ),
        );
      } else if (request.apiMethod == BackEndServicesEnum.PUT) {
        logs('Error Message--> ${request.body}');
        response = await dio.put(
          ApiEndpoint.baseUrl + request.endPoint,
          options: Options(
            headers: request.header,
          ),
          data: request.body,
        );
      } else if (request.apiMethod == BackEndServicesEnum.DELETE) {
        response = await dio.delete(
          ApiEndpoint.baseUrl + request.endPoint,
          options: Options(
            headers: request.header,
          ),
          data: request.body,
        );
      } else if (request.apiMethod == BackEndServicesEnum.CUSTOM) {
        final List<File> body = request.body['attachments'];
        final FormData data = FormData.fromMap({
          'attachments': <MultipartFile>[
            if (body.isNotEmpty)
              await MultipartFile.fromFile(body[0].path,
                  filename: body[0].path.split('/').last),
            if (body.length >= 2)
              await MultipartFile.fromFile(body[1].path,
                  filename: body[1].path.split('/').last),
            if (body.length >= 3)
              await MultipartFile.fromFile(body[2].path,
                  filename: body[2].path.split('/').last),
          ],
          if (request.body['description'] != null &&
              request.body['ticketType'] != '')
            'ticketType': request.body['ticketType'],
          if (request.body['description'] != null &&
              request.body['description'] != '')
            'description': request.body['description'],
          if (request.body['message'] != null && request.body['message'] != '')
            'message': request.body['message'],
        });

        response = await dio.post(
          ApiEndpoint.baseUrl + request.endPoint,
          options: Options(
            headers: request.header,
          ),
          data: data,
        );
      } else {
        final String contentType=await getContentType(request.body['path']);
        // ignore: always_specify_types
        final List contentTypeList=contentType.split('/');
        final FormData data = FormData.fromMap({
          'file': <MultipartFile>[
            await MultipartFile.fromFile(request.body['path'],
                filename: request.body['fileName'],
            contentType: MediaType(contentTypeList[0],contentTypeList[1]))
          ],
        });
        response = await dio.post(
          ApiEndpoint.baseUrl + request.endPoint,
          options: Options(
            headers: request.header,
          ),
          data: data,
        );
      }
      return BaseResponse.fromJson(response.data);
    } on SocketException catch (_) {
      return BaseResponse(
          status: Status(type: 'error', message: 'SocketException'));
    } on TimeoutException catch (_) {
      return BaseResponse(status: Status(type: 'error', message: 'Time out'));
    } on DioException catch (e) {
      if (e.response?.statusCode == StatusCode.badRequest) {
        return BaseResponse(
          status: Status(type: 'error', message: 'Bad request'),
        );
      } else if (e.response?.statusCode == StatusCode.unauthorized) {
        LocaleManager.removeAuthToken();
        LocaleManager.removeCreatedClassToken();
        await Get.deleteAll();
        Get.offAllNamed(Routes.loginView);
        return BaseResponse(
          status: Status(type: 'error', message: 'UnAuthorized user'),
        );
      } else if (e.response?.statusCode == StatusCode.timeOut) {
        return BaseResponse(status: Status(type: 'error', message: 'Time out'));
      } else if (e.response?.statusCode == StatusCode.unSuccessful) {
        return BaseResponse(
            status: Status(type: 'error', message: 'SomeThing went wrong'));
      } else if (e.response?.statusCode == StatusCode.serverError) {
        return BaseResponse(
            status: Status(type: 'error', message: 'Internal server error'));
      } else {
        return BaseResponse(
            status: Status(type: 'error', message: 'SomeThing went wrong'));
      }
    } catch (_) {
      return BaseResponse(
          status: Status(type: 'error', message: 'SomeThing went wrong'));
    }
  }

  static Future<String> getContentType(String filePath, {String defaultMimeType = 'application/octet-stream'}) async {
    try {
      File file = File(filePath);

      // Check if the file exists
      if (!await file.exists()) {
        return defaultMimeType;
      }

      // Use the 'mime' package to determine the content type
      String mimeType = lookupMimeType(filePath) ?? defaultMimeType;
      if (mimeType == null) {

        return defaultMimeType;
      }return mimeType;
    } catch (e) {
      return defaultMimeType;
    }
  }
}
