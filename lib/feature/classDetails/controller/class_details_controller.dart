import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/utils/validators.dart';
import '../modal/class_detail_model.dart';
import '../repository/get_class_details_repository.dart';

class ClassDetailsController extends GetxController{

  final GetClassDetailRepository _getClassDetailRepository = GetClassDetailRepository();

  @override
  void onInit() {
    super.onInit();
    fetchMap();
    getClassDetails(Get.arguments);
  }
  CameraPosition? kGooglePlex;

  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  //AIzaSyBT8CFEhdKhFteNf6L4NaY3Z3UKFfpRy2w


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

   Rx<ClassDetailsModel?> classData =  ClassDetailsModel().obs;

  Future<void> getClassDetails(String id) async {
    showLoading();
    final BaseResponse classDataResponse = await _getClassDetailRepository.getClassDetail(id);
    if (classDataResponse.status?.type == 'success') {
      final  Map<String, dynamic> classDetailData=classDataResponse.data!.item! as Map<String ,dynamic>;
       classData.value = ClassDetailsModel.fromJson(classDetailData);
    }
    hideLoading();
  }

}

