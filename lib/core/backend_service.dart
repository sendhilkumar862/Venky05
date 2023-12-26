import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import '../product/constants/enums/backend_services_method_enums.dart';
import '../product/network/networking/api_endpoint.dart';
import '../product/utils/validators.dart';
import 'base_request.dart';
import 'base_response.dart';
import 'status_code.dart';

class BackendService {
  static Future<BaseResponse> post(BaseRequest request) async {
   final String authToken= await keyValueStorageService.getAuthToken();
   if(authToken!=''){
     request.header.addAll({'X-Auth-Token': authToken});
   }
   if(request.endPoint.contains('refresh-token')){
     final String authToken= await keyValueStorageService.getBioMetricStatus();
     request.header.addAll({'X-Auth-Token': authToken,
       'X-Refresh-Token':authToken});
   }
    final Dio dio = Dio();
    try {
      final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return BaseResponse(
          status: Status(type: 'error',
              message: 'No internet connection'));
      }
      final Response response;
      if(request.apiMethod==BackEndServicesEnum.POST){
      response= await dio.post(
          ApiEndpoint.baseUrl+request.endPoint,
        options: Options(
          headers: request.header,
        ),
        data: request.body,
      );}else if(request.apiMethod==BackEndServicesEnum.GET){
        response= await dio.get(
          ApiEndpoint.baseUrl+request.endPoint,
          options: Options(
            headers: request.header,
          ),
        );
      }else if(request.apiMethod==BackEndServicesEnum.PUT){
        logs('Error Message--> ${request.body}');
        response= await dio.put(
          ApiEndpoint.baseUrl+request.endPoint,
          options: Options(
            headers: request.header,
          ),
          data: request.body,
        );
      }else if(request.apiMethod==BackEndServicesEnum.DELETE){
        response= await dio.delete(
          ApiEndpoint.baseUrl+request.endPoint,
          options: Options(
            headers: request.header,
          ),
          data: request.body,
        );
      }else{
        var data = FormData.fromMap({
          'file': [
            await MultipartFile.fromFile(request.body['path'], filename: request.body['fileName'])
          ],

        });
        response= await dio.post(
          ApiEndpoint.baseUrl+request.endPoint,
          options: Options(
            headers: request.header,
          ),
          data: data,
        );
      }
      if(response.statusCode==StatusCode.success){
       return BaseResponse.fromJson(response.data);
      } else if (response.statusCode == StatusCode.badRequest) {
        return BaseResponse(
            status: Status(type: 'error',
            message: 'SomeThing went wrong'),);
      } else if (response.statusCode == StatusCode.unauthorized) {
        return BaseResponse(
          status: Status(type: 'error',
              message: 'SomeThing went wrong'),);
      } else if (response.statusCode == StatusCode.timeOut) {
        return BaseResponse(
            status: Status(type: 'error',
                message: 'SomeThing went wrong'));
      } else if (response.statusCode == StatusCode.unSuccessful) {
        return BaseResponse(
            status: Status(type: 'error',
                message: 'SomeThing went wrong'));
      } else if (response.statusCode == StatusCode.serverError) {
        return BaseResponse(
            status: Status(type: 'error',
                message: 'SomeThing went wrong'));
      } else {
        return BaseResponse(
            status: Status(type: 'error',
                message: 'SomeThing went wrong'));
      }
    } on SocketException catch (_) {
      return BaseResponse(
    status: Status(type: 'error',
    message: 'SomeThing went wrong'));
    } on TimeoutException catch (_) {
      return  BaseResponse(
    status: Status(type: 'error',
    message: 'SomeThing went wrong'));
    } catch (_) {
      return  BaseResponse(
          status: Status(type: 'error',
              message: 'SomeThing went wrong'));
    }
  }

  // static Future<BaseResponse> get(BaseRequest request) async {
  //   final String authToken= await keyValueStorageService.getAuthToken();
  //   if(authToken!=''){
  //     request.header.addAll({'X-Auth-Token': authToken});
  //   }
  //   final Dio dio = Dio();
  //   try {
  //     final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
  //     if (connectivityResult == ConnectivityResult.none) {
  //       return BaseResponse(
  //           status: Status(type: 'error',
  //               message: 'No internet connection'));
  //     }
  //     final Response response = await dio.get(
  //       ApiEndpoint.baseUrl+request.endPoint,
  //       options: Options(
  //         headers: request.header,
  //       ),
  //     );
  //     if(response.statusCode==StatusCode.success){
  //       return BaseResponse.fromJson(response.data);
  //     } else if (response.statusCode == StatusCode.badRequest) {
  //       return BaseResponse(
  //         status: Status(type: 'error',
  //             message: 'SomeThing went wrong'),);
  //     } else if (response.statusCode == StatusCode.unauthorized) {
  //       return BaseResponse(
  //         status: Status(type: 'error',
  //             message: 'SomeThing went wrong'),);
  //     } else if (response.statusCode == StatusCode.timeOut) {
  //       return BaseResponse(
  //           status: Status(type: 'error',
  //               message: 'SomeThing went wrong'));
  //     } else if (response.statusCode == StatusCode.unSuccessful) {
  //       return BaseResponse(
  //           status: Status(type: 'error',
  //               message: 'SomeThing went wrong'));
  //     } else if (response.statusCode == StatusCode.serverError) {
  //       return BaseResponse(
  //           status: Status(type: 'error',
  //               message: 'SomeThing went wrong'));
  //     } else {
  //       return BaseResponse(
  //           status: Status(type: 'error',
  //               message: 'SomeThing went wrong'));
  //     }
  //   } on SocketException catch (_) {
  //     return BaseResponse(
  //         status: Status(type: 'error',
  //             message: 'SomeThing went wrong'));
  //   } on TimeoutException catch (_) {
  //     return  BaseResponse(
  //         status: Status(type: 'error',
  //             message: 'SomeThing went wrong'));
  //   } catch (_) {
  //     return  BaseResponse(
  //         status: Status(type: 'error',
  //             message: 'SomeThing went wrong'));
  //   }
  // }
  //
  // static Future<BaseResponse> put(BaseRequest request) async {
  //   final String authToken= await keyValueStorageService.getAuthToken();
  //   if(authToken!=''){
  //     request.header.addAll({'X-Auth-Token': authToken});
  //   }
  //   final Dio dio = Dio();
  //   try {
  //     final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
  //     if (connectivityResult == ConnectivityResult.none) {
  //       return BaseResponse(
  //           status: Status(type: 'error',
  //               message: 'No internet connection'));
  //     }
  //     final Response response = await dio.put(
  //       ApiEndpoint.baseUrl+request.endPoint,
  //       options: Options(
  //         headers: request.header,
  //       ),
  //     );
  //     if(response.statusCode==StatusCode.success){
  //       return BaseResponse.fromJson(response.data);
  //     } else if (response.statusCode == StatusCode.badRequest) {
  //       return BaseResponse(
  //         status: Status(type: 'error',
  //             message: 'SomeThing went wrong'),);
  //     } else if (response.statusCode == StatusCode.unauthorized) {
  //       return BaseResponse(
  //         status: Status(type: 'error',
  //             message: 'SomeThing went wrong'),);
  //     } else if (response.statusCode == StatusCode.timeOut) {
  //       return BaseResponse(
  //           status: Status(type: 'error',
  //               message: 'SomeThing went wrong'));
  //     } else if (response.statusCode == StatusCode.unSuccessful) {
  //       return BaseResponse(
  //           status: Status(type: 'error',
  //               message: 'SomeThing went wrong'));
  //     } else if (response.statusCode == StatusCode.serverError) {
  //       return BaseResponse(
  //           status: Status(type: 'error',
  //               message: 'SomeThing went wrong'));
  //     } else {
  //       return BaseResponse(
  //           status: Status(type: 'error',
  //               message: 'SomeThing went wrong'));
  //     }
  //   } on SocketException catch (_) {
  //     return BaseResponse(
  //         status: Status(type: 'error',
  //             message: 'SomeThing went wrong'));
  //   } on TimeoutException catch (_) {
  //     return  BaseResponse(
  //         status: Status(type: 'error',
  //             message: 'SomeThing went wrong'));
  //   } catch (_) {
  //     return  BaseResponse(
  //         status: Status(type: 'error',
  //             message: 'SomeThing went wrong'));
  //   }
  // }
}
