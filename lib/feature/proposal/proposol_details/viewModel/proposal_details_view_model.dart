import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';

part 'proposal_details_view_model.g.dart';

class ProposalDetailsViewModel = _ProposalDetailsViewModelBase
    with _$ProposalDetailsViewModel;

abstract class _ProposalDetailsViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    fetchMap();
    getProfile();
  }

  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService =
      KeyValueStorageService();

  @observable
  String selectedProfile = '';

  @observable
  CameraPosition? kGooglePlex;

  @observable
  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  @action
  Future<void> fetchMap() async {
    try {
      kGooglePlex = CameraPosition(
        target: LatLng(
          double.parse('24.7136'),
          double.parse('46.6753'),
        ),
        zoom: 14.4746,
      );
    } on SocketException catch (e) {
      logs('Catch SocketException in getContactUsInfo --> ${e.message}');
    }
  }

  @action
  void getProfile() {
    selectedProfile =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ??
            ApplicationConstants.student;
  }
}
