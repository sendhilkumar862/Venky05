import 'package:dartz/dartz.dart';
import 'package:hessah/data/repo/repo_impliment.dart';

import '../../feature/preference/model/preference_model.dart';
import '../../models/response_model/error_response_model.dart';
import '../../models/response_model/login_response_model.dart';
import '../../models/response_model/reset_pass_email_response_model.dart';
import '../network/data_provider.dart';
import '../network/dio_client.dart';

class UserRepo {
  static UserRepoImpl getInstance() {
    return UserRepoImpl(
      dataProvider: DataProvider(dioClient: DioClient.instance),
    );
  }
}

abstract class UserRepository {
  Future<Either<ErrorResponseModel, ResetPassEmailRespnoseModel>>
      getUserResetPassEmail({required Map<String, dynamic> data});

  Future<Either<ErrorResponseModel, PreferenceModel>> getUserPreference();

  Future<Either<ErrorResponseModel, UserLoginResponseModel>> getUserLogin(
      {required Map<String, dynamic> data});
}
