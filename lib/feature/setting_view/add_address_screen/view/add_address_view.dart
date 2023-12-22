import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/common_dropdown/app_dropdown.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/typography.dart';
import '../../../tutorial/view/bottomSheets/country_code_bottom_sheet.dart';
import '../../manage_address/Model/get_address_model.dart';
import '../../manage_address/controller/manage_controller.dart';
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
      // ignore: unnecessary_statements
      _addAddressController.selectedCity.value=widget.userData?.city??'';
      _addAddressController.addressFirst.text=widget.userData?.address1??'';
      _addAddressController.addressSecond.text= widget.userData?.address2??'';
      _addAddressController.shortName.text=widget.userData?.shortName??'';
      _addAddressController.mobileController.text=widget.userData?.mobile??'';
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
                      options: _addAddressController.city,
                      title: 'City',
                      value:  '',
                      hintText:  _addAddressController.selectedCity.value==''?'Select city':_addAddressController.selectedCity.value,
                      onChanged: (String? city){
                        _addAddressController.selectedCity.value=city??'';
                      },
                    ),
                     AppTextFormField(
                       controller: _addAddressController.addressFirst,
                      title: 'Address 1',
                      hintText: 'Enter Address 1',
                    ),
                     AppTextFormField(
                      controller: _addAddressController.addressSecond,
                      title: 'Address 2 (Optional)',
                      hintText: 'Enter Address 2',
                    ),
                    SizedBox(height: 10.px),
                    TextFormsField(
                      prefix: (_addAddressController.countries.isNotEmpty)
                          ? GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder:
                                    (BuildContext context, setState) {
                                  return CountryCodeBottomsSheet(
                                      setState: setState,);
                                },
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 6.px),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(700),
                              child: AppImageAsset(
                                image: _addAddressController
                                    .countries[_addAddressController
                                    .countryIndex.value]
                                    ?.flag_url ??
                                    ImageConstants.globe,
                                fit: BoxFit.fill,
                                height: 16.px,
                                width: 16.px,
                              ),
                            ),
                            SizedBox(width: 6.px),
                            AppText(
                              _addAddressController
                                  .countries[
                              _addAddressController.countryIndex.value]
                                  ?.idd_code ??
                                  'select',
                              fontWeight: FontWeight.w400,
                              fontSize: 14.px,
                            )
                          ],
                        ),
                      )
                          : const SizedBox(),
                      title: 'mobileNumber'.tr,
                      keyboardType: TextInputType.number,
                      controller: _addAddressController.mobileController,
                      hintText: 'enterMobileAgain'.tr,
                      validate: _addAddressController.mobileValid.value,
                      errorText: _addAddressController.mobileErrorText.value,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (String value) {
                        _addAddressController.validateMobile(value);
                      },
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
                    AppTextFormField(
                      controller: _addAddressController.shortName,
                      title: 'Short Name',
                      hintText: 'Short Name',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(()=>
             AppButton(
              // ignore: avoid_bool_literals_in_conditional_expressions
              isDisable: _addAddressController.selectedCity.value!='' && _addAddressController.addressFirst!='' && _addAddressController.addressSecond!='' && _addAddressController.shortName!=''?false:true,
              onPressed: () async{
                Map data={
                  'short_name': _addAddressController.shortName.text,
                  'country_code': _addAddressController
                      .countries[
                  _addAddressController.countryIndex.value]
                      ?.idd_code,
                  'mobile': _addAddressController.mobileController.text,
                  'address1': _addAddressController.addressFirst.text,
                  'address2': _addAddressController.addressSecond.text,
                  'city': _addAddressController.selectedCity.value,
                  'state': 'New Delhi',
                  'country': 'India',
                  'location': {
                    'lat': '60',
                    'long': '30'
                  },
                  'is_default':  _addAddressController.isSwitchExperience.value
                };
                if(widget.userData!=null){
                 await _manageAddressController.updateAddressData(UserAddress(id: widget.userData?.id,
                    shortName: _addAddressController.shortName.text,
                    address1: _addAddressController.addressFirst.text,
                    address2: _addAddressController.addressSecond.text,
                    city:  _addAddressController.selectedCity.value,
                    state: widget.userData?.state??'',
                    country: widget.userData?.country??'',
                    countryCode: _addAddressController
                        .countries[
                    _addAddressController.countryIndex.value]
                        ?.idd_code,
                    mobile: _addAddressController.mobileController.text,
                    isDefault:  _addAddressController.isSwitchExperience.value?1:0,
                    location: widget.userData?.location,
                   createdAt: widget.userData?.createdAt,
                   updatedAt:  widget.userData?.updatedAt,
                   userId: widget.userData?.userId
                  ));
                  AppRouter.pop();

                }else{
                  _addAddressController.addAddress(data);
                }

              },
              title: widget.userData!=null?'Update Address':'Add New Address',
            ),
          ),
        ]),
      ),
    );
  }
}
