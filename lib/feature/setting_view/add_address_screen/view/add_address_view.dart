import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/common_dropdown/app_dropdown.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';
import '../../manage_address/Model/get_address_model.dart'hide Location;
import '../../manage_address/controller/manage_controller.dart';
import '../Model/request_address_model.dart' ;
import '../controller/add_address_controller.dart';


class AddAddressScreen extends StatefulWidget {
  final UserAddress? userData;
  final String title;
   AddAddressScreen({Key? key,this.userData,required this.title}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final AddAddressController _addAddressController=Get.put(AddAddressController());
  final ManageAddressController _manageAddressController=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    _addAddressController.fetchFullData();
    if(widget.userData!=null){
      _addAddressController.isTap=false;
      // ignore: unnecessary_statements
      _addAddressController.selectedCity.value=widget.userData?.city??'';
      _addAddressController.addressFirst.text=widget.userData?.address1??'';
      _addAddressController.addressSecond.text= widget.userData?.address2??'';
      _addAddressController.shortName.text=widget.userData?.shortName??'';
      // _addAddressController.mobileController.text=widget.userData?.mobile??'';
      _addAddressController.isSwitchExperience.value=widget.userData?.isDefault==1?true:false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
      title: widget.title,
      isTitleOnly: true,
    ),
      body:  Obx(()=>
         Column(children: <Widget>[
           Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    AppDropdown(
                      options: _addAddressController.city.value,
                      title: 'Area',
                      hintStyle:widget.title=='Update Address'? openSans.black.w500.get16.textColor(AppColors.appTextColor): openSans.w400
                          .textColor(AppColors.appTextColor.withOpacity(0.25))
                          .get14,
                      value:  '',
                      hintText:  _addAddressController.selectedCity.value==''?'Select Area':_addAddressController.selectedCity.value,
                      onChanged: (String? city){
                        _addAddressController.selectedCity.value=city??'';
                      },
                    ),
                     AppTextFormField(
                       controller: _addAddressController.addressFirst,
                      title: 'Address 1',
                      hintText: 'Enter Address 1',
                       onChanged: (v){
                         setState(() {

                         });
                       },
                    ),
                     AppTextFormField(
                      controller: _addAddressController.addressSecond,
                      title: 'Address 2 (Optional)',
                      hintText: 'Enter Address 2',
                       onChanged: (v){
                         setState(() {

                         });
                       },
                    ),
                    // TextFormsField(
                    //   prefix: (_addAddressController.countries.isNotEmpty)
                    //       ? GestureDetector(
                    //     onTap: () {
                    //       showModalBottomSheet(
                    //         isScrollControlled: true,
                    //         context: context,
                    //         shape: const RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.vertical(
                    //             top: Radius.circular(25.0),
                    //           ),
                    //         ),
                    //         builder: (BuildContext context) {
                    //           return StatefulBuilder(
                    //             builder:
                    //                 (BuildContext context, setState) {
                    //               return CountryCodeBottomsSheet(
                    //                   setState: setState,);
                    //             },
                    //           );
                    //         },
                    //       );
                    //     },
                    //     child: Row(
                    //       children: [
                    //         SizedBox(width: 6.px),
                    //         ClipRRect(
                    //           borderRadius: BorderRadius.circular(700),
                    //           child: AppImageAsset(
                    //             image: _addAddressController
                    //                 .countries[_addAddressController
                    //                 .countryIndex.value]
                    //                 ?.flag_url ??
                    //                 ImageConstants.globe,
                    //             fit: BoxFit.fill,
                    //             height: 16.px,
                    //             width: 16.px,
                    //           ),
                    //         ),
                    //         SizedBox(width: 6.px),
                    //         AppText(
                    //           _addAddressController
                    //               .countries[
                    //           _addAddressController.countryIndex.value]
                    //               ?.idd_code ??
                    //               'select',
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 14.px,
                    //         )
                    //       ],
                    //     ),
                    //   )
                    //       : const SizedBox(),
                    //   title: 'mobileNumber'.tr,
                    //   keyboardType: TextInputType.number,
                    //   controller: _addAddressController.mobileController,
                    //   hintText: 'enterMobileAgain'.tr,
                    //   validate: _addAddressController.mobileValid.value,
                    //   errorText: _addAddressController.mobileErrorText.value,
                    //   inputFormatters: <TextInputFormatter>[
                    //     FilteringTextInputFormatter.digitsOnly
                    //   ],
                    //   onChanged: (String value) {
                    //     _addAddressController.validateMobile(value);
                    //     setState(() {
                    //
                    //     });
                    //   },
                    // ),

                    AppTextFormField(
                      controller: _addAddressController.shortName,
                      title: 'Short Name',
                      hintText: 'Short Name',
                      onChanged: (val){
                        setState(() {

                        });
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text('Location',style:  TextStyle(
                        color:  AppColors.appTextColor.withOpacity(0.5),
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w400),),
                      ),
                    ),
                    Obx(()=>
                       Container(
                        height: 150.px,
                        width: double.infinity,
                        padding: const EdgeInsets.only(top:12),
                        decoration:
                        const BoxDecoration(color: AppColors.appWhite),
                        child: GoogleMap(
                          markers: <Marker>{
                            Marker(
                              markerId: const MarkerId('riyadh1'),
                              position: _addAddressController.position.value,
                            )
                          },
                           initialCameraPosition:CameraPosition(
                             target: LatLng(
                               double.parse('24.7136'),
                               double.parse('46.6753'),
                             ),
                             zoom: 3,
                           ),
                            onTap: (value)async{
                              _addAddressController.isTap=true;
                            _addAddressController.position.value=value;
                            _addAddressController.getAddress(value);
                              _addAddressController.googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                                  CameraPosition(target: value, zoom: 5)));
                            },
                          // proposalDetailsViewModel.kGooglePlex!,
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: true,
                          onMapCreated: (GoogleMapController controllers) {
                            _addAddressController.googleMapController=controllers;
                              _addAddressController.controllerGoogleMap
                                  .complete(controllers);

                          }
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: <Widget>[
                          Text('Set as Default Address', style: openSans.get14.w500.textColor(AppColors.appTextColor)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Obx(()=>
                                FlutterSwitch(
                                  value: _addAddressController.isSwitchExperience.value,
                                  height: 16.29,
                                  width: 27.63,
                                  toggleSize: 12,
                                  activeColor: AppColors.appBlue,
                                  inactiveColor: AppColors.gray.withOpacity(0.25),
                                  onToggle: (bool value) {
                                    _addAddressController.isSwitchExperience.value = value;
                                  },
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(()=>
             AppButton(
              // ignore: avoid_bool_literals_in_conditional_expressions
              isDisable: (_addAddressController.selectedCity.value!='' && _addAddressController.addressFirst.text!='' && _addAddressController.addressSecond.text!='' && _addAddressController.shortName.text!='')?false:true,
              onPressed: () async{
                if(_addAddressController.selectedCity.value!='' && _addAddressController.addressFirst.text!='' && _addAddressController.addressSecond.text!='' && _addAddressController.shortName.text!=''){
                 if(widget.userData!=null){
                 await _manageAddressController.updateAddressData(AddressRequestModel(
                    shortName: _addAddressController.shortName.text,
                    address1: _addAddressController.addressFirst.text,
                    address2: _addAddressController.addressSecond.text,
                    city:   _addAddressController.selectedCity.value,
                    state: _addAddressController.isTap?_addAddressController.address[0].administrativeArea:widget.userData?.state??'',
                    country: _addAddressController.isTap?_addAddressController.address[0].country:widget.userData?.country??'',
                    isDefault:  _addAddressController.isSwitchExperience.value,
                    location: _addAddressController.isTap?Location(lat:_addAddressController.position.value.latitude.toString(),long:  _addAddressController.position.value.longitude.toString(),):Location(lat:widget.userData?.location?.lat,long:  widget.userData?.location?.long,),
                  ),widget.userData!.id!);
                  AppRouter.pop();

                }else{
                  _addAddressController.addAddress(AddressRequestModel(shortName:_addAddressController.shortName.text,address1: _addAddressController.addressFirst.text,address2:_addAddressController.addressSecond.text,country: _addAddressController.address[0].country,city: _addAddressController.selectedCity.value,state: _addAddressController.address[0].administrativeArea,isDefault: _addAddressController.isSwitchExperience.value,location: Location(lat:_addAddressController.position.value.latitude.toString(),long:_addAddressController.position.value.longitude.toString())  )
                  );
                }}

              },
              title: widget.userData!=null?'Update Address':'Add New Address',
            ),
          ),
        ]),
      ),
    );
  }
}
