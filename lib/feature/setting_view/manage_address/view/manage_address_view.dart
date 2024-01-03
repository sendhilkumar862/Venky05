import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/routes/route.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';
import '../../add_address_screen/Model/request_address_model.dart' ;
import '../../add_address_screen/controller/add_address_controller.dart';
import '../Model/get_address_model.dart' hide Location;
import '../controller/manage_controller.dart' ;

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({super.key});

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  final ManageAddressController _manageAddressController=Get.put(ManageAddressController());

  @override
  void initState() {
    // TODO: implement initState
    _manageAddressController.fetchAddressData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
      title: 'Manage Addresses',
      isTitleOnly: true,
    ),
      body: Obx(()=>
         Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
          Expanded(
            child: _manageAddressController.address.isNotEmpty?SingleChildScrollView(
              child:
                Column(
                children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _manageAddressController.address.length,
                      itemBuilder: (BuildContext context, int index) {
                        final UserAddress data =_manageAddressController.address[index];
                        return listData(index, data);
                      })
                ],
              )
            ): const Center(child: Text('No address added'),),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: AppButton(
              isDisable: false,
              onPressed: () {
                Get.delete<AddAddressController>();
                var  titleData = {
                  'title' : 'Add New Addresses',
                };
                Get.toNamed(Routes.addAddressView,arguments: titleData);
              },
              title: 'Add New Address',
            ),
          ),
        ]),
      ),
    );
  }
//==============================================================================
// ** Helper Widget **
//==============================================================================
  Widget listData(int index, UserAddress data) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: data.isDefault==1
                    ? AppColors.appBlue
                    : AppColors.gray.withOpacity(0.25),
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(data.shortName??'', style: openSans.get17.w700),
                          if (data.isDefault==1)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: const Color(0xfff0f5ff),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 8),
                                    child: Text('Default'),
                                  )),
                            ),
                        ],
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${data.address1??'' } ${data.address2??'' }' ),
                      Text('${data.city??''} ${data.state??''} ${data.country??''}'),
                      // Text('Phone No: ${data.countryCode??''} ${data.mobile??''}'),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          if(data.isDefault == 1){
                            AppUtils.showFlushBar(
                              context: Routes.navigatorKey.currentContext!,
                              message: 'Can not delete default address',
                            );
                          }else{
                            _manageAddressController.deleteAddressData(data.id!);
                          }

                        },
                        child: iconButtonWidget(
                          icon: Icons.delete_outline_rounded,
                          padding: 8,
                          bgColor: AppColors.appRed,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          var  titleData = {
                            'title' : 'Update Address',
                            'userData':data
                          };
                          Get.toNamed(Routes.addAddressView,arguments: titleData);
                          // AppRouter.push( AddAddressScreen(userData: data,title: "Update Address",));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10, right:data.isDefault==1 ? 10 : 0),
                          child: iconButtonWidget(
                            icon: Icons.edit,
                            padding: 8,
                            bgColor: AppColors.appBlue,
                          ),
                        ),
                      ),
                      if (data.isDefault != 1)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                final AddressRequestModel updatedData=AddressRequestModel(isDefault: true,shortName: data.shortName,city: data.city,state:data.state,country: data.country,address2: data.address2,address1: data.address2,location: Location(lat: data.location?.lat,long: data.location?.long));
                                _manageAddressController.updateAddressData(updatedData,data.id!);
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                  MaterialStatePropertyAll(AppColors.appBlue),
                                  shape:
                                  MaterialStatePropertyAll(StadiumBorder())),
                              child: const Text('Set Default',
                                  style: TextStyle(color: AppColors.white))),
                        )
                    ]),
              ],
            ),
          ),
        ));
  }

  Widget iconButtonWidget(
      {Color? bgColor,
        required IconData icon,
        double? iconSize,
        double? padding,
        void Function()? onPress}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor ?? AppColors.secondaryColor),
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            size: iconSize ?? 15,
            color: AppColors.white,
          )),
    );
  }
}
