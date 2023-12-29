import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> showMyDialog() async {
  return Get.dialog(CupertinoAlertDialog(
    title: const Text('Location Permission'),
    content: const Text('Hessah app needs access the location'),
    actions: <Widget>[
      CupertinoDialogAction(
        child: const Text('deny'),
        onPressed: () => Get.back(),
      ),
      CupertinoDialogAction(
          child: const Text(
            'Settings',
          ),
          onPressed: () async {
            Get.back();
            openAppSettings();
            await Geolocator.openAppSettings();
            await Geolocator.openLocationSettings();
          }),
    ],
  ));
}
