import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../product/cache/key_value_storeage.dart';
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
      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return BaseResponse(
            status: Status(type: 'error', message: 'No internet connection'));
      }
      final Response response;
      if (request.apiMethod == BackEndServicesEnum.POST) {
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
        final List<File> body=request.body['attachments'];
        final FormData data = FormData.fromMap({
          'attachments': <MultipartFile>[
            if(body.isNotEmpty)
            await MultipartFile.fromFile(body[0].path,
                filename: body[0].path.split('/').last),
            if(body.length>=2)
            await MultipartFile.fromFile(body[1].path,
                filename: body[1].path.split('/').last),
            if(body.length>=3)
            await MultipartFile.fromFile(body[2].path,
                filename: body[2].path.split('/').last),

          ],
          if(request.body['description']!=null && request.body['ticketType']!='')
          'ticketType': request.body['ticketType'],
          if(request.body['description']!=null && request.body['description']!='')
          'description': request.body['description'],
          if(request.body['message']!=null && request.body['message']!='')
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
        final FormData data = FormData.fromMap({
          'file': <MultipartFile>[
            await MultipartFile.fromFile(request.body['path'],
                filename: request.body['fileName'])
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
      if (response.statusCode == StatusCode.success) {
        return BaseResponse.fromJson(response.data);
      } else if (response.statusCode == StatusCode.badRequest) {
        return BaseResponse(
          status: Status(type: 'error', message: 'SomeThing went wrong'),
        );
      } else if (response.statusCode == StatusCode.unauthorized) {
        return BaseResponse(
          status: Status(type: 'error', message: 'SomeThing went wrong'),
        );
      } else if (response.statusCode == StatusCode.timeOut) {
        return BaseResponse(
            status: Status(type: 'error', message: 'SomeThing went wrong'));
      } else if (response.statusCode == StatusCode.unSuccessful) {
        return BaseResponse(
            status: Status(type: 'error', message: 'SomeThing went wrong'));
      } else if (response.statusCode == StatusCode.serverError) {
        return BaseResponse(
            status: Status(type: 'error', message: 'SomeThing went wrong'));
      } else {
        return BaseResponse(
            status: Status(type: 'error', message: 'SomeThing went wrong'));
      }
    } on SocketException catch (_) {
      return BaseResponse(
          status: Status(type: 'error', message: 'SomeThing went wrong'));
    } on TimeoutException catch (_) {
      return BaseResponse(
          status: Status(type: 'error', message: 'SomeThing went wrong'));
    } on DioException catch (_) {
      return BaseResponse(
          status: Status(type: 'error', message: 'SomeThing went wrong'));
    } catch (_) {
      return BaseResponse(
          status: Status(type: 'error', message: 'SomeThing went wrong'));
    }
  }
}
