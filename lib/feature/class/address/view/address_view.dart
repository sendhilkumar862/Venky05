// ignore_for_file: always_specify_types, unnecessary_statements
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../custom/text/country_picker.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';
import '../viewModel/address_view_model.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  List cityOption = [
    'City 1',
    'City 2',
    'City 3',
    'City 4',
    'City 5',
    'City 6'
  ];
  bool isDisable = true;
  bool isSwitch = false;
  TextEditingController city = TextEditingController();
  TextEditingController countryCode = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedCountryCode;
  String? selectedCountryFlagUrl;

  @override
  Widget build(BuildContext context) {
    return BaseView<AddressViewModel>(
        viewModel: AddressViewModel(),
        onModelReady: (AddressViewModel addressViewModel) {
          addressViewModel.setContext(context);
          addressViewModel.init();
        },
        onPageBuilder:
            (BuildContext context, AddressViewModel addressViewModel) {
          return Scaffold(
            appBar: HessaAppBar(
              isTitleOnly: true,
              trailingText: 'cancel'.tr(),
              title: 'addNewAddress'.tr(),
              isBack: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: formKey,
                  onChanged: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isDisable = false;
                      });
                    } else {
                      setState(() {
                        isDisable = true;
                      });
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextFormField(
                        suffix: const Icon(Icons.keyboard_arrow_down),
                        readOnly: true,
                        hintText: 'selectCity'.tr(),
                        title: 'city'.tr(),
                        controller: city,
                        onTap: () {
                          bottomSheetDropDownList();
                        },
                        validate: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'pleaseSelectYourCity'.tr();
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: AppTextFormField(
                            validate: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'enterYourAddressLine1'.tr();
                              }
                              return null;
                            },
                            hintText: 'enterAddress1'.tr(),
                            title: 'address1'.tr()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: AppTextFormField(
                          hintText: 'enterAddress2'.tr(),
                          title: 'address2optional'.tr(),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: AppTextFormField(
                            controller: countryCode,
                            keyboardType: TextInputType.phone,
                            title: 'contactNumber'.tr(),
                            hintText: 'enterMobileNumber'.tr(),
                            prefix: CountryPicker(
                              flagDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2)),
                              padding: EdgeInsets.zero,
                              onChanged: (CountryCode countryCode) {},
                              alignLeft: false,
                              dialogSize: const Size.square(550),
                              dialogTextStyle: openSans.w500.get16,
                              initialSelection: 'IN',
                              favorite: ['+91', 'IN'],
                              showDropDownButton: true,
                              textStyle: openSans.black.get12,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('location'.tr()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 140.px,
                          width: double.infinity,
                          decoration:
                              const BoxDecoration(color: AppColors.appWhite),
                          child: GoogleMap(
                            markers: <Marker>{
                              Marker(
                                markerId: const MarkerId('selectLocation'),
                                position: LatLng(
                                  double.parse('24.7136'),
                                  double.parse('46.6753'),
                                ),
                              )
                            },
                            initialCameraPosition:
                                addressViewModel.kGooglePlex!,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: false,
                            onMapCreated: (GoogleMapController controllers) =>
                                addressViewModel.mapController
                                    .complete(controllers),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(children: [
                          Text('setAsDefaultAddress'.tr(),
                              style: openSans.w500),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // flutter_switch package
                            child: FlutterSwitch(
                              value: isSwitch,
                              height: 23,
                              width: 40,
                              toggleSize: 12,
                              activeColor: AppColors.appBlue,
                              inactiveColor: AppColors.gray.withOpacity(0.25),
                              onToggle: (value) {
                                setState(() {
                                  isSwitch = value;
                                });
                              },
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: AppButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                showModalBottomSheet(
                                  context: context,
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 30,
                                    // here increase or decrease in width
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  builder: (BuildContext context) {
                                    return SuccessFailsInfoDialog(
                                      title: 'success'.tr(),
                                      buttonTitle: 'done'.tr(),
                                      content:
                                          'msgSuccessfullyBookedClass'.tr(),
                                    );
                                  },
                                );
                              }
                            },
                            title: 'nextForClassDetails'.tr(),
                            isDisable: isDisable),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void bottomSheetDropDownList() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                Text('Select City', style: openSans.get20.w700),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.downArrowColor.withOpacity(0.15)),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Padding(
                          padding: EdgeInsets.all(3),
                          child: Icon(Icons.close),
                        ),
                      )),
                )
              ]),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: cityOption.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cityOption[index]),
                      onTap: () {
                        city.text = cityOption[index];
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
