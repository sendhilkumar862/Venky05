import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/utils/validators.dart';
import '../model/response_model/reset_pass_email_response_model.dart';

part 'tutorial_view_model.g.dart';

class TutorialViewModel = _TutorialViewModelBase with _$TutorialViewModel;

abstract class _TutorialViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  String errors = '';

  @observable
  int selectedIndex = -1;

  @observable
  TextEditingController firstNameController = TextEditingController();

  @observable
  ResetPassEmailResponseModel resetPassEmailResponseModel =
      ResetPassEmailResponseModel();

  @observable
  TextEditingController forgotEmailController = TextEditingController();

  @observable
  TextEditingController emailController = TextEditingController();

  @observable
  TextEditingController lastNameController = TextEditingController();

  @observable
  List profileItems = <String>['Teacher', 'Parent/Student'];

  @action
  Future<void> forgotPassword() async {
    showLoading();
    final Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'email': forgotEmailController.text,
      };
      logs('body--> $body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/request-reset',
        data: body,
      );
      logs('status Code --> ${response.statusCode}');
      if (response.statusCode == 200) {
        hideLoading();
        resetPassEmailResponseModel =
            ResetPassEmailResponseModel.fromJson(response.data);
      } else {
        EasyLoading.dismiss();
      }
    } on DioException catch (error) {
      hideLoading();
      resetPassEmailResponseModel =
          ResetPassEmailResponseModel.fromJson(error.response!.data);
      errors = resetPassEmailResponseModel.status!.message!;
      logs('data --> ${resetPassEmailResponseModel.status!.message}');
    }
  }
}
