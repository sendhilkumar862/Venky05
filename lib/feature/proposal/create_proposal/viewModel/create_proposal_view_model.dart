import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/common_function.dart';

part 'create_proposal_view_model.g.dart';

class CreateProposalViewModel = _CreateProposalViewModelBase
    with _$CreateProposalViewModel;

abstract class _CreateProposalViewModelBase extends BaseViewModel with Store {
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService =
      KeyValueStorageService();

  @observable
  String selectedProfile = '';

  @observable
  String selectedTimes = formatTime(DateTime.now());

  @observable
  String selectedDate = formatTime(DateTime.now());

  @observable
  bool isActive = false;

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    selectedProfile =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ??
            '';
  }
}
