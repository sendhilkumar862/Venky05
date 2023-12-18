import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/base/model/base_model.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../model/home_model.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase extends BaseViewModel with Store {
  @override
  Future<void> setContext(BuildContext context) async {
    viewModelContext = context;
  }

  @observable
  HomeModel? homeData;

  @override
  void init() {
    fetchData();
  }

  Future<Options> _headers() async {
    final KeyValueStorageService keyValueStorageService =
        KeyValueStorageService();
    final String token = await keyValueStorageService.getAuthToken();
    return Options(
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
    );
  }

  @action
  Future<void> fetchData() async {
    final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    showLoading();
    final Dio dio = Dio();
    try {
      final Response response = await dio.get(
        'http://167.99.93.83/api/v1/users/dashboard/details',
        options: await _headers(),
      );
      if (response.statusCode == 200) {
        final BaseResponse<HomeModel> baseResponse =
            BaseResponse<HomeModel>.fromJson(
                response.data as Map<String, dynamic>, HomeModel.fromJson);
        keyValueStorageBase.setCommon(KeyValueStorageService.userInfoStatus,
            baseResponse.data.item?.userStatus);
        homeData = baseResponse.data.item;
        hideLoading();
      } else {
        hideLoading();
      }
    } on DioException {
      hideLoading();
    }
  }
}
