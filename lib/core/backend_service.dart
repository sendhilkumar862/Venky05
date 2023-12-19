import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import '../product/network/networking/api_endpoint.dart';
import 'base_request.dart';
import 'base_response.dart';
import 'status_code.dart';

class BackendService {
  static Future<BaseResponse> post(BaseRequest request) async {
   final String authToken= await keyValueStorageService.getAuthToken();
   if(authToken!=''){
     request.header.addAll({'X-Auth-Token': authToken});
   }
    final Dio dio = Dio();
    try {
      final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return BaseResponse(
          status: Status(type: 'error',
              message: 'No internet connection'));
      }
      final Response response = await dio.post(
          ApiEndpoint.baseUrl+request.endPoint,
        options: Options(
          headers: request.header,
        ),
        data: request.body,
      );
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

  // static Future<BaseResponse> get(BaseRequestGet request) async {
  //   Map<String, String> header = {};
  //   try {
  //     var connectivityResult = await (Connectivity().checkConnectivity());
  //     if (connectivityResult == ConnectivityResult.none) {
  //       throw const ShopeezException(
  //           StatusCode.noInternet, "No internet connection!");
  //     }
  //     String? token = GetStorage().read("token");
  //     request.header.forEach((key, value) {
  //       header[key] = value;
  //     });
  //     if (token != null) {
  //       header["Authorization"] = "token $token";
  //     }
  //     if (_meController.user?.longitude != null) {
  //       header["latitude"] = _meController.user!.latitude!.toString();
  //       header["longitude"] = _meController.user!.longitude!.toString();
  //     }
  //     header.addAll(hmackHeader("", HttpMethod.GET));
  //     http.Response resp = await http.get(
  //         Uri.parse('${request.baseUrl}${request.endPoint}'),
  //         headers: header);
  //     dynamic myResp;
  //     if (resp.statusCode != 500) {
  //       myResp = json.decode(utf8.decode(resp.bodyBytes));
  //     }
  //     if (resp.statusCode == StatusCode.success) {
  //       return BaseResponse(
  //           data: myResp, isSuccess: true, statusCode: StatusCode.success);
  //     } else if (resp.statusCode == StatusCode.create) {
  //       return BaseResponse(
  //         data: myResp,
  //         isSuccess: true,
  //         statusCode: StatusCode.create,
  //       );
  //     } else if (resp.statusCode == StatusCode.unauthorized) {
  //       return BaseResponse(
  //           isSuccess: false,
  //           statusCode: StatusCode.unauthorized,
  //           error: myResp["detail"]);
  //     } else if (resp.statusCode == StatusCode.badRequest) {
  //       return BaseResponse(
  //           isSuccess: false,
  //           statusCode: StatusCode.badRequest,
  //           error: myResp["error"] ?? myResp["response"]);
  //     } else if (resp.statusCode == StatusCode.notFound) {
  //       return BaseResponse(
  //           isSuccess: false,
  //           statusCode: resp.statusCode,
  //           error: myResp["error"]);
  //     } else if (resp.statusCode == StatusCode.timeOut) {
  //       throw const ShopeezException(504, "Something went wrong!");
  //     } else if (resp.statusCode == StatusCode.serverError) {
  //       throw const ShopeezException(
  //           StatusCode.serverError, "Internal server error");
  //     } else {
  //       throw const ShopeezException(
  //           StatusCode.serverError, "Internal server error");
  //     }
  //   } on SocketException catch (_) {
  //     throw const ShopeezException(
  //         StatusCode.noInternet, "No Internet connection!");
  //   } on TimeoutException catch (_) {
  //     throw const ShopeezException(
  //         StatusCode.noInternet, "No Internet connection!");
  //   } catch (_) {
  //     rethrow;
  //   }
  // }

  // static Future<BaseResponse> put(BaseRequestPost request) async {
  //   Map<String, String> header = {};
  //   try {
  //     var connectivityResult = await (Connectivity().checkConnectivity());
  //     if (connectivityResult == ConnectivityResult.none) {
  //       throw const ShopeezException(
  //           StatusCode.noInternet, "No internet connection!");
  //     }
  //     String? token = GetStorage().read("token");
  //     request.header.forEach((key, value) {
  //       header[key] = value;
  //     });
  //     if (token != null) {
  //       header["Authorization"] = "token $token";
  //     }
  //     if (header["latitude"] == null && _meController.user?.longitude != null) {
  //       header["latitude"] = _meController.user!.latitude!.toString();
  //       header["longitude"] = _meController.user!.longitude!.toString();
  //     }
  //     header.addAll(hmackHeader(json.encode(request.body), HttpMethod.PUT));
  //     http.Response resp = await http.put(
  //         Uri.parse('${request.baseUrl}${request.endPoint}'),
  //         body: json.encode(request.body),
  //         headers: header);
  //     dynamic myResp;
  //     if (resp.statusCode != 500) {
  //       myResp = json.decode(utf8.decode(resp.bodyBytes));
  //     }
  //     if (resp.statusCode == StatusCode.success) {
  //       return BaseResponse(
  //         data: myResp,
  //         isSuccess: true,
  //         statusCode: StatusCode.success,
  //       );
  //     } else if (resp.statusCode == StatusCode.create) {
  //       return BaseResponse(
  //         data: myResp,
  //         isSuccess: true,
  //         statusCode: StatusCode.success,
  //       );
  //     } else if (resp.statusCode == StatusCode.badRequest) {
  //       return BaseResponse(
  //           isSuccess: false,
  //           statusCode: StatusCode.badRequest,
  //           error: myResp["error"] ?? myResp["phone_number"][0] ?? "");
  //     } else if (resp.statusCode == StatusCode.timeOut) {
  //       throw const ShopeezException(StatusCode.timeOut, "Time Out");
  //     } else if (resp.statusCode == StatusCode.unSuccessful) {
  //       throw ShopeezException(StatusCode.timeOut, myResp["reason"]);
  //     } else if (resp.statusCode == StatusCode.serverError) {
  //       throw const ShopeezException(
  //           StatusCode.serverError, "Internal server error");
  //     } else {
  //       throw const ShopeezException(
  //           StatusCode.serverError, "Internal server error");
  //     }
  //   } on SocketException catch (_) {
  //     throw const ShopeezException(
  //         StatusCode.noInternet, "No Internet connection!");
  //   } on TimeoutException catch (_) {
  //     throw const ShopeezException(
  //         StatusCode.noInternet, "No Internet connection!");
  //   } catch (_) {
  //     rethrow;
  //   }
  // }
  //
  // static Future<BaseResponse> delete(BaseRequestPost request) async {
  //   Map<String, String> header = {};
  //   try {
  //     var connectivityResult = await (Connectivity().checkConnectivity());
  //     if (connectivityResult == ConnectivityResult.none) {
  //       throw const ShopeezException(
  //           StatusCode.noInternet, "No internet connection!");
  //     }
  //     String? token = GetStorage().read("token");
  //     request.header.forEach((key, value) {
  //       header[key] = value;
  //     });
  //     if (token != null) {
  //       header["Authorization"] = "token $token";
  //     }
  //     header.addAll(hmackHeader(json.encode(""), HttpMethod.DELETE));
  //     http.Response resp = await http.delete(
  //         Uri.parse('${request.baseUrl}${request.endPoint}'),
  //         headers: header);
  //     Map<String, dynamic> myResp = {};
  //     if (resp.statusCode != 500) {
  //       myResp = json.decode(utf8.decode(resp.bodyBytes));
  //     }
  //     if (resp.statusCode == StatusCode.success) {
  //       return BaseResponse(
  //         data: myResp,
  //         isSuccess: true,
  //         statusCode: StatusCode.success,
  //       );
  //     } else if (resp.statusCode == StatusCode.create) {
  //       return BaseResponse(
  //         data: myResp,
  //         isSuccess: true,
  //         statusCode: StatusCode.success,
  //       );
  //     } else if (resp.statusCode == StatusCode.badRequest) {
  //       return BaseResponse(
  //           isSuccess: false,
  //           statusCode: StatusCode.badRequest,
  //           error: myResp["error"] ?? "");
  //     } else if (resp.statusCode == StatusCode.timeOut) {
  //       throw const ShopeezException(StatusCode.timeOut, "Time Out");
  //     } else if (resp.statusCode == StatusCode.unSuccessful) {
  //       throw ShopeezException(StatusCode.timeOut, myResp["reason"]);
  //     } else if (resp.statusCode == StatusCode.serverError) {
  //       throw const ShopeezException(
  //           StatusCode.serverError, "Internal server error");
  //     } else {
  //       throw const ShopeezException(
  //           StatusCode.serverError, "Internal server error");
  //     }
  //   } on SocketException catch (_) {
  //     throw const ShopeezException(
  //         StatusCode.noInternet, "No Internet connection!");
  //   } on TimeoutException catch (_) {
  //     throw const ShopeezException(
  //         StatusCode.noInternet, "No Internet connection!");
  //   } catch (_) {
  //     rethrow;
  //   }
  // }
  //
  // static Future<BaseResponse> putFileUpload(BaseRequestPost request) async {
  //   Map<String, String> header = {};
  //   try {
  //     var connectivityResult = await (Connectivity().checkConnectivity());
  //     if (connectivityResult == ConnectivityResult.none) {
  //       throw const ShopeezException(
  //           StatusCode.noInternet, "No internet connection!");
  //     }
  //     String? token = GetStorage().read("token");
  //     form.FormData formData;
  //     if (request.body["imageData"] is File) {
  //       formData = form.FormData.fromMap(
  //         {
  //           "file": form.MultipartFile.fromBytes(
  //               request.body["imageData"].readAsBytesSync(),
  //               filename:
  //                   request.body["imageData"].path.split('/').removeLast()),
  //         },
  //       );
  //     } else {
  //       formData = form.FormData.fromMap(
  //         {
  //           "file": form.MultipartFile.fromBytes(
  //               request.body["imageData"]["data"],
  //               filename: request.body["imageData"]["filePath"]),
  //         },
  //       );
  //     }
  //
  //     request.header.forEach((key, value) {
  //       header[key] = value;
  //     });
  //     if (token != null) {
  //       header["Authorization"] = "token $token";
  //     }
  //     header.addAll(hmackHeader("{}", HttpMethod.POST));
  //     form.Dio dio = form.Dio();
  //     dio.options.headers.addAll(header);
  //     var resp = await dio.post(
  //       Uri.encodeFull('${request.baseUrl}${request.endPoint}'),
  //       data: formData,
  //     );
  //
  //     Map<String, dynamic> myResp = resp.data[0];
  //     if (resp.statusCode == StatusCode.success) {
  //       return BaseResponse(
  //         data: myResp,
  //         isSuccess: true,
  //         statusCode: StatusCode.success,
  //       );
  //     } else if (resp.statusCode == StatusCode.badRequest) {
  //       return BaseResponse(
  //           isSuccess: false,
  //           statusCode: StatusCode.badRequest,
  //           error: myResp["error"]);
  //     } else if (resp.statusCode == StatusCode.timeOut) {
  //       throw const ShopeezException(StatusCode.timeOut, "Time Out");
  //     } else if (resp.statusCode == StatusCode.unSuccessful) {
  //       throw ShopeezException(StatusCode.timeOut, myResp["reason"]);
  //     } else if (resp.statusCode == StatusCode.serverError) {
  //       throw const ShopeezException(
  //           StatusCode.serverError, "Internal server error");
  //     } else {
  //       throw const ShopeezException(
  //           StatusCode.serverError, "Internal server error");
  //     }
  //   } on SocketException catch (_) {
  //     throw const ShopeezException(
  //         StatusCode.noInternet, "No Internet connection!");
  //   } on TimeoutException catch (_) {
  //     throw const ShopeezException(
  //         StatusCode.noInternet, "No Internet connection!");
  //   } catch (_) {
  //     rethrow;
  //   }
  // }
  //
  // static Future<BaseResponse> putMultipleFileUpload(
  //     BaseRequestPost request) async {
  //   Map<String, String> header = {};
  //   try {
  //     var connectivityResult = await (Connectivity().checkConnectivity());
  //     if (connectivityResult == ConnectivityResult.none) {
  //       throw const ShopeezException(
  //           StatusCode.noInternet, "No internet connection!");
  //     }
  //     String? token = GetStorage().read("token");
  //     form.FormData? formData;
  //     if (!kIsWeb) {
  //       formData = form.FormData.fromMap(
  //         {
  //           "fileType": "I",
  //         },
  //       );
  //       for (int i = 0; i < request.body["imageData"].length; i++) {
  //         formData.files.addAll([
  //           MapEntry(
  //             "file",
  //             form.MultipartFile.fromBytes(
  //                 request.body["imageData"][i].readAsBytesSync(),
  //                 filename: request.body["imageData"][i].path
  //                     .split('/')
  //                     .removeLast()),
  //           )
  //         ]);
  //       }
  //     } else {
  //       formData = form.FormData.fromMap(
  //         {
  //           "fileType": "I",
  //         },
  //       );
  //       for (int i = 0; i < request.body["imageData"]["data"].length; i++) {
  //         formData.files.addAll([
  //           MapEntry(
  //             "file",
  //             form.MultipartFile.fromBytes(
  //                 await request.body["imageData"]["data"][i],
  //                 filename: request.body["imageData"]["filePath"][i]),
  //           )
  //         ]);
  //       }
  //     }
  //
  //     request.header.forEach((key, value) {
  //       header[key] = value;
  //     });
  //     if (token != null) {
  //       header["Authorization"] = "token $token";
  //     }
  //     header.addAll(hmackHeader("{}", HttpMethod.POST));
  //     form.Dio dio = form.Dio();
  //     dio.options.headers.addAll(header);
  //     var resp = await dio.post(
  //       Uri.encodeFull('${request.baseUrl}${request.endPoint}'),
  //       data: formData,
  //     );
  //
  //     if (resp.statusCode == StatusCode.success) {
  //       return BaseResponse(
  //         data: resp.data,
  //         isSuccess: true,
  //         statusCode: StatusCode.success,
  //       );
  //     } else if (resp.statusCode == StatusCode.badRequest) {
  //       return BaseResponse(
  //           isSuccess: false,
  //           statusCode: StatusCode.badRequest,
  //           error: resp.data["error"] ?? "");
  //     } else if (resp.statusCode == StatusCode.timeOut) {
  //       throw const ShopeezException(StatusCode.timeOut, "Time Out");
  //     } else if (resp.statusCode == StatusCode.unSuccessful) {
  //       throw ShopeezException(
  //           StatusCode.timeOut, resp.data["error"]["reason"]);
  //     } else if (resp.statusCode == StatusCode.serverError) {
  //       throw const ShopeezException(
  //           StatusCode.serverError, "Internal server error");
  //     } else {
  //       throw const ShopeezException(
  //           StatusCode.serverError, "Internal server error");
  //     }
  //   } on SocketException catch (_) {
  //     throw const ShopeezException(
  //         StatusCode.noInternet, "No Internet connection!");
  //   } on TimeoutException catch (_) {
  //     throw const ShopeezException(
  //         StatusCode.noInternet, "No Internet connection!");
  //   } catch (_) {
  //     rethrow;
  //   }
  // }
}
