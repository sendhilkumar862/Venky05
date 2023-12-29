import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../product/utils/validators.dart';

class AddressClassController extends GetxController{

  CameraPosition? kGooglePlex;


  Completer<GoogleMapController> mapController =
  Completer<GoogleMapController>();



  @override
  void onInit() {
    super.onInit();
    fetchMap();
  }


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
