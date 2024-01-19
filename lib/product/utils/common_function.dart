

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

String formatTime(DateTime dateTime) {
  // Use intl package to format the time in 12-hour format
  final formattedTime = DateFormat('h:mm a').format(dateTime);
  return formattedTime;
}
bool handlePermissionResult(PermissionStatus status) {
  if (status.isGranted) {
   return true;
  } else if (status.isDenied) {
    return true;
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
    return false;
  }else{
    return false;
  }

}
Future<String?> captureImage() async {
  final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxHeight: 800,
      maxWidth: 800);
  if (pickedFile != null) {
   // ignore: unnecessary_await_in_return
   return await cropImage(pickedFile);
  }
}
Future<String?> cropImage(XFile? pickedFile) async {
  if (pickedFile != null) {
    try {
      final CroppedFile? cropFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          compressFormat: ImageCompressFormat.png,
          compressQuality: 30,
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
          uiSettings: <PlatformUiSettings>[
            AndroidUiSettings(
              hideBottomControls: false,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            ),
          ]);
      if (cropFile != null) {
      return  cropFile.path;
        // setState(() async {});
      }
    } catch (e) {
      print('Error cropping image: $e');
      return null;
    }
  }
}