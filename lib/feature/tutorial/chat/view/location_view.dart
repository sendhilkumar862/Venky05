

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../product/constants/colors/app_colors_constants.dart';
import '../controller/location_controller.dart';

class LocationSentView extends StatefulWidget {
  const LocationSentView({Key? key}) : super(key: key);

  @override
  State<LocationSentView> createState() => _LocationSentViewState();
}

class _LocationSentViewState extends State<LocationSentView> {

  final LocationController _locationController=Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Location'),
          automaticallyImplyLeading: true,
        ),
        body:SafeArea(
          child: Obx(
                ()=> Column(
              children: [
                Expanded(
                  child:GoogleMap(
                    markers: {_locationController.marker.value},
                    // on below line setting camera position
                    initialCameraPosition: _locationController.kGoogle.value,
                    // on below line we are setting markers on the map
                    //markers: Set<Marker>.of(controller.marker),
                    // on below line specifying map type.
                    mapType: MapType.normal,
                    // on below line setting user location enabled.
                    //myLocationEnabled: true,
                    // on below line setting compass enabled.
                    //compassEnabled: true,
                    // on below line specifying controller on map complete.
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController mapController)=>_locationController.onMapCreated(mapController),
                    onTap: (latLng)=>_locationController.onTap(latLng),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Obx(
                              ()=>_locationController.address1.value.isNotEmpty ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Send this Location',style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.normal),),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(_locationController.address1.value,style: const TextStyle(color: AppColors.black,fontSize: 16,fontWeight: FontWeight.w700),),
                              ),
                              Text(_locationController.address2.value,style: const TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.normal),),
                            ],
                          ) : const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: FloatingActionButton.small(onPressed: (){
                        if(_locationController.location.value.latitude!=0){
                          //sent Location Message
                          Get.back(result: _locationController.location.value);
                        }
                      },
                        backgroundColor: AppColors.appBlue,
                        child: const Icon(Icons.arrow_forward_rounded,color: Colors.white,size: 18,),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
