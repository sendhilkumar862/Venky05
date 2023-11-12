import 'package:dartz/dartz.dart';

import '../../feature/preference/model/preference_model.dart';
import '../../models/response_model/error_response_model.dart';
import '../../models/response_model/login_response_model.dart';
import '../../models/response_model/reset_pass_email_response_model.dart';
import 'dio_client.dart';

class DataProvider {
  DataProvider({required DioClient dioClient}) : _dioClient = dioClient;
  final DioClient _dioClient;
  // API call for get secret key

  Future<Either<ErrorResponseModel, ResetPassEmailRespnoseModel>>
      getUserResetPassEmail({required Map<String, dynamic> data}) async {
    var response =
        await _dioClient.postApi(url: '/users/request-reset', body: data);
    return response.fold(
      (l) => Left(errorResponseModelFromJson(l)),
      (r) => Right(resetPassEmailRespnoseModelFromJson(r)),
    );
  }

  Future<Either<ErrorResponseModel, UserLoginResponseModel>> getUserLogin(
      {required Map<String, dynamic> data}) async {
    var response = await _dioClient.postApi(url: '/users/login', body: data);
    return response.fold(
      (l) => Left(errorResponseModelFromJson(l)),
      (r) => Right(userLoginResponseModelFromJson(r)),
    );
  }

  Future<Either<ErrorResponseModel, PreferenceModel>>
      getUserPreference() async {
    var response = await _dioClient.getApi(
        url: '/users/preference', isAuthorization: true);
    return response.fold(
      (l) => Left(errorResponseModelFromJson(l)),
      (r) => Right(preferenceModelFromJson(r)),
    );
  }
}
