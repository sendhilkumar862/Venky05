import 'package:dartz/dartz.dart';

import '../../feature/preference/model/preference_model.dart';
import '../../models/response_model/error_response_model.dart';
import '../../models/response_model/login_response_model.dart';
import '../../models/response_model/reset_pass_email_response_model.dart';
import '../network/data_provider.dart';
import 'repo.dart';

class UserRepoImpl extends UserRepository {
  UserRepoImpl({required DataProvider dataProvider})
      : _dataProvider = dataProvider;

  final DataProvider _dataProvider;

  @override
  Future<Either<ErrorResponseModel, ResetPassEmailRespnoseModel>>
      getUserResetPassEmail({required Map<String, dynamic> data}) {
    return _dataProvider.getUserResetPassEmail(data: data);
  }

  @override
  Future<Either<ErrorResponseModel, PreferenceModel>> getUserPreference() {
    return _dataProvider.getUserPreference();
  }

  @override
  Future<Either<ErrorResponseModel, UserLoginResponseModel>> getUserLogin(
      {required Map<String, dynamic> data}) {
    return _dataProvider.getUserLogin(data: data);
  }
}
