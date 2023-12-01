import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../product/utils/validators.dart';

part 'class_details_view_model.g.dart';

class ClassDetailsViewModel = _ClassDetailsViewModelBase with _$ClassDetailsViewModel;

abstract class _ClassDetailsViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    fetchMap();
  }

  @observable
  CameraPosition? kGooglePlex;

  @observable
  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  //AIzaSyBT8CFEhdKhFteNf6L4NaY3Z3UKFfpRy2w

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
}
