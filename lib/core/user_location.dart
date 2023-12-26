import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../custom/dialog/location_dialog.dart';
import '../feature/setting_view/add_address_screen/controller/add_address_controller.dart';



class LocationService {
   final AddAddressController _addAddressController =Get.find();
   Future<String?> getLatLong() async {
    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      showMyDialog();
      return null;
    } else if (permission == LocationPermission.denied) {
      showMyDialog();
      return null;
    } else {
      try {
        final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
              return 'No internet connectivity';
        }
        final Position loc = await determineCurrentPosition();
        _addAddressController.position.value=LatLng(loc.latitude, loc.longitude);
        return await getAddressFromLatLng(LatLng(loc.latitude, loc.longitude));
      } catch (_) {
        rethrow;
      }
    }
  }
   Future<Position> determineCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: always_specify_types
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // ignore: always_specify_types
      return Future.error('Please enable locations to proceed.');
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: always_specify_types
      return Future.error(
        'Location permissions are permanently denied, please enable them from settings.',
      );
    }
    return Geolocator.getCurrentPosition();
  }
   Future<String?> requestLocPermission() async {

    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      showMyDialog();
      return null;
    } else {
      try {
        final String? address = await getLatLong();
        return address;
      } catch (_) {
        rethrow;
      }
    }
  }

   Future<String?> getAddressFromLatLng(LatLng lac) async {
    try {
      final List<Placemark> p =
      await placemarkFromCoordinates(lac.latitude, lac.longitude);
      final Placemark placeMark = p[0];
      final String? name = placeMark.name;
      final String? subLocality = placeMark.subLocality;
      final String? locality = placeMark.locality;
      final String? administrativeArea = placeMark.administrativeArea;
      final String? postalCode = placeMark.postalCode;
      final String? country = placeMark.country;
      _addAddressController.address.value=p;
      final String address =
          "$name ${locality != "" ? locality : subLocality} $administrativeArea $country $postalCode";
      return address;
    } catch (e) {
      if (e is PlatformException) {
        if (e.message ==
            'A network error occurred trying to lookup the supplied coordinates (latitude: 28.530371, longitude: 77.275353).') {
        }
      } else {
        rethrow;
      }
    }
    return null;
  }
}
