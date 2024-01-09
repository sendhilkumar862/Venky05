import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../config/routes/route.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/calender/calender.dart';
import '../../../../custom/choice/src/modal/button.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/extension/string_extension.dart';
import '../../../../product/utils/common_function.dart';
import '../../../../product/utils/typography.dart';
import '../../../../product/utils/validators.dart';
import '../../../setting_view/add_address_screen/Model/request_address_model.dart';
import '../../../setting_view/manage_address/Model/get_address_model.dart'
    hide Location;
import '../../../setting_view/manage_address/controller/manage_controller.dart';
import '../controller/class_detail_controller.dart';

class ClassDetail extends StatefulWidget {
  const ClassDetail({super.key});

  @override
  State<ClassDetail> createState() => _ClassDetailState();
}

class _ClassDetailState extends State<ClassDetail> {
  final ClassDetailController _classDetailController =
      Get.put(ClassDetailController());
  final ManageAddressController _manageAddressController =
      Get.put(ManageAddressController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _manageAddressController.fetchAddressData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        // isBack: true,
        // trailingText: 'Cancel',
        title: 'createClass'.tr,
        // normalAppbar: true,
      ),
      body: Form(
        key: _classDetailController.formKey,
        onChanged: () {
          if (_classDetailController.formKey.currentState!.validate()) {
            setState(() {
              _classDetailController.isDisable = false;
            });
          } else {
            setState(() {
              _classDetailController.isDisable = true;
            });
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'classDetails'.tr,
                      style:
                          openSans.get20.w700.textColor(AppColors.appTextColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'participators'.tr,
                      style: openSans.get12.w400
                          .textColor(AppColors.appTextColor.withOpacity(0.5)),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: FlutterSlider(
                      rangeSlider: true,
                      values: <double>[
                        _classDetailController.lowerValue,
                        _classDetailController.upperValue
                      ],
                      max: 100,
                      min: 0,
                      // ignore: always_specify_types
                      onDragging: (int handlerIndex, lowerValue, upperValue) {
                        setState(() {
                          _classDetailController.lowerValue = lowerValue;
                          _classDetailController.upperValue = upperValue;
                        });
                      },
                      onDragCompleted: (_, __, ___) {
                        // Optional: Add any additional logic when the dragging is completed.
                      },
                      tooltip: FlutterSliderTooltip(
                        disabled: true,
                        alwaysShowTooltip: false,
                      ),
                      handler: FlutterSliderHandler(
                        decoration: const BoxDecoration(
                          color: AppColors.ctaSecondary,
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '${_classDetailController.lowerValue.toInt()}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      rightHandler: FlutterSliderHandler(
                        decoration: const BoxDecoration(
                          color: AppColors.appBlue,
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '${_classDetailController.upperValue.toInt()}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      trackBar: FlutterSliderTrackBar(
                        inactiveTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12,
                          border:
                              Border.all(width: 3, color: AppColors.tabColor),
                        ),
                        activeTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.appBlue,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('minimum'.tr,
                          style: openSans.get10.w400.textColor(
                              AppColors.appTextColor.withOpacity(0.5))),
                      Text('maximum'.tr,
                          style: openSans.get10.w400.textColor(
                              AppColors.appTextColor.withOpacity(0.5))),
                    ],
                  ),
                  AppTextFormField(
                    controller: _classDetailController.classCost,
                    keyboardType:
                        // ignore: use_named_constants
                        const TextInputType.numberWithOptions(),
                    validate: Validators.requiredValidator.call,
                    suffix: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text('kwd'.tr, style: openSans.get16.w400),
                    ),
                    hintText: 'classCost'.tr,
                  ),
                  AppTextFormField(
                    controller: _classDetailController.numberOfSession,
                    keyboardType:
                        // ignore: use_named_constants
                        const TextInputType.numberWithOptions(),
                    validate: Validators.requiredValidator.call,
                    hintText: 'numberOfSessions'.tr,
                  ),
                  AppTextFormField(
                    validate: Validators.requiredValidator.call,
                    controller: _classDetailController.dateController,
                    onTap: () {
                      calender(
                        context,
                        _classDetailController.dateController,
                      );
                    },
                    hintText: 'selectDateAndTime'.tr,
                    readOnly: true,
                    suffix: const Icon(Icons.keyboard_arrow_down_sharp,
                        color: AppColors.downArrowColor),
                  ),
                  AppTextFormField(
                    validate: Validators.requiredValidator.call,
                    suffix: const Icon(Icons.keyboard_arrow_down_sharp,
                        color: AppColors.downArrowColor),
                    hintText: 'classDuration'.tr,
                    title: 'classDuration'.tr,
                    readOnly: true,
                    controller: _classDetailController.classDurationController,
                    onTap: () {
                      bottomSheetDropDownList(
                          _classDetailController
                              .masterData.value.sessionDurations!
                              .map((el) => el.toString())
                              .toList(),
                          _classDetailController.isSelected ?? -1,
                          myValueGetter: (index) {
                        _classDetailController.isSelected = index;
                        _classDetailController.classDurationController.text =
                            _classDetailController
                                .masterData.value.sessionDurations![index]
                                .toString()
                                .timeConvert();
                        Navigator.pop(context);
                      }, isClassDuration: true);
                    },
                  ),
                  Obx(() => _manageAddressController.address.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 7),
                          child: Text(
                            'selectLocation'.tr,
                            style: TextStyle(
                                color: const Color(0xff051335).withOpacity(0.5),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      : const SizedBox.shrink()),

                  Obx(() {
                    UserAddress data = UserAddress();
                    if (_classDetailController.selectedIndex.value != 200) {
                      data = _manageAddressController
                          .address[_classDetailController.selectedIndex.value];
                    }else{
                      if(  _manageAddressController.address.length==1){
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _classDetailController.selectedIndex.value=0;
                        });

                        data = _manageAddressController.address[0];
                      }
                    }
                    _classDetailController.classLocationController.text =
                        data.shortName ?? '';
                    return SizedBox(
                      width: width,
                      child: _manageAddressController.address.isNotEmpty
                          ? GestureDetector(
                              onTap: () => locationModalBottomSheet(context),
                              child: AppTextFormField(
                                validate: Validators.requiredValidator.call,
                                suffix: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: AppColors.downArrowColor),
                                hintText: 'selectAddress'.tr,
                                title: 'classLocation'.tr,
                                readOnly: true,
                                controller: _classDetailController
                                    .classLocationController,
                                onTap: () => locationModalBottomSheet(context),
                              ),
                            )
                          : DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(15),
                              color: AppColors.appBlue,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      'noAddressFound'.tr,
                                      style: openSans.get16.w700,
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: AppButton(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderColor: AppColors.appBlue,
                                          isBorderOnly: true,
                                          textStyle: const TextStyle(
                                              color: AppColors.appBlue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                          height: 45,
                                          width: width,
                                          title: 'addAddressFound'.tr,
                                          onPressed: () {
                                            final Map<String, dynamic>
                                                titleData = {
                                              'title': 'Add New Addresses',
                                            };
                                            Get.toNamed(Routes.addAddressView,
                                                arguments: titleData);
                                          },
                                          isDisable:
                                              _classDetailController.isDisable),
                                    )
                                  ],
                                ),
                              )),
                    );
                  }),
                  // ignore: unrelated_type_equality_checks
                  if (_classDetailController.selectedProfile ==
                      ApplicationConstants.student)
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'otherParticipators'.tr,
                                style: openSans.get20.w700
                                    .textColor(AppColors.appTextColor),
                              ),
                              Text(
                                'optional'.tr,
                                style: openSans.get12.w400.textColor(
                                    AppColors.appTextColor.withOpacity(0.5)),
                              ),
                            ],
                          ),
                        ),
                        AppTextFormField(
                          top: 0,
                          controller: _classDetailController.participators2,
                          validate: _classDetailController.emailValidator.call,
                          title: 'participators2'.tr,
                          hintText: 'enterEmailAddress'.tr,
                        ),
                        AppTextFormField(
                          controller: _classDetailController.participators3,
                          validate: _classDetailController.emailValidator.call,
                          title: 'participators3'.tr,
                          hintText: 'enterEmailAddress'.tr,
                        ),
                        AppTextFormField(
                          controller: _classDetailController.participators4,
                          validate: _classDetailController.emailValidator.call,
                          title: 'participators4'.tr,
                          hintText: 'enterEmailAddress'.tr,
                        ),
                        AppTextFormField(
                          controller: _classDetailController.participators5,
                          validate: _classDetailController.emailValidator.call,
                          title: 'participators5'.tr,
                          hintText: 'enterEmailAddress'.tr,
                        ),
                      ],
                    ),
                  Obx(() {
                    final int? locationIndex =
                        _classDetailController.selectedIndex?.value;
                    return AppButton(
                      title: 'nextForClassDetails'.tr,
                      onPressed: () async {
                        if (_classDetailController.formKey.currentState!
                            .validate()) {
                          if (locationIndex != 200) {
                            final String? success =
                                await _classDetailController.createClass();
                            if (success != null) {
                              // ignore: use_build_context_synchronously
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                isDismissible: false,
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
                                      title: 'success'.tr,
                                      buttonTitle: 'done'.tr,
                                      content:
                                          'You have successfully creates a new class And awaiting proposals from teachers.',
                                      isRouting: _classDetailController.selectedProfile == ApplicationConstants.student?Routes.classDetailsView:Routes.homeViews,
                                      argument: success);
                                },
                              );
                            }
                          }
                        }
                      },
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      isDisable: _classDetailController.isDisable ||
                              locationIndex == 200
                          ? true
                          : false,
                    );
                  }),
                ]),
          ),
        ),
      ),
    );
  }

  Widget listData(int index, UserAddress data, StateSetter setState) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: _classDetailController.selectedIndex.value == index
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
                          Text(data.shortName ?? '',
                              style: openSans.get17.w700),
                          if (_classDetailController.selectedIndex.value ==
                              index)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: const Color(0xfff0f5ff),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 8),
                                    child: Text('default'.tr),
                                  )),
                            ),
                        ],
                      ),
                      Obx(() => GestureDetector(
                          onTap: () {
                            _classDetailController.selectedIndex.value = index;
                          },
                          child: _classDetailController.selectedIndex.value ==
                                  index
                              ? const ChoiceConfirmButton(
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: AppColors.appBlue,
                                  ),
                                )
                              : ChoiceConfirmButton(
                                  icon: Icon(
                                  Icons.circle_outlined,
                                  color: AppColors.gray.withOpacity(0.25),
                                ))))
                    ]),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${data.address1 ?? ''} ${data.address2 ?? ''}'),
                      Text(
                          '${data.city ?? ''} ${data.state ?? ''} ${data.country ?? ''}'),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async{
                          if (data.isDefault == 1) {
                            AppUtils.showFlushBar(
                              context: Routes.navigatorKey.currentContext!,
                              message: 'Can not delete default address',
                            );
                          } else {
                           await _manageAddressController
                                .deleteAddressData(data.id!);
                            if (_classDetailController.selectedIndex.value ==
                                index) {
                              _classDetailController.selectedIndex.value = 200;
                            }
                          }
                        },
                        child: iconButtonWidget(
                          icon: Icons.delete_outline_rounded,
                          padding: 8,
                          bgColor: AppColors.appRed,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var arguments = {
                            'title': 'Update Address',
                            'userData': data
                          };
                          Get.toNamed(Routes.addAddressView,
                              arguments: arguments);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10,
                              right:
                                  _classDetailController.selectedIndex?.value !=
                                          index
                                      ? 10
                                      : 0),
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
                                final AddressRequestModel updatedData =
                                    AddressRequestModel(
                                        isDefault: true,
                                        shortName: data.shortName,
                                        city: data.city,
                                        state: data.state,
                                        country: data.country,
                                        address2: data.address2,
                                        address1: data.address2,
                                        location: Location(
                                            lat: data.location?.lat,
                                            long: data.location?.long));
                                _manageAddressController.updateAddressData(
                                    updatedData, data.id!);
                              },
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColors.appBlue),
                                  shape: MaterialStatePropertyAll(
                                      StadiumBorder())),
                              child: const Text('Set Default',
                                  style: TextStyle(color: AppColors.white))),
                        )
                    ]),
              ],
            ),
          ),
        ));
  }

  void locationModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        // showDragHandle: true,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('classLocation'.tr, style: openSans.get20.w700),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    AppColors.downArrowColor.withOpacity(0.15)),
                            child: const Padding(
                              padding: EdgeInsets.all(3),
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
              Obx(
                () => Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _manageAddressController.address.length,
                        itemBuilder: (BuildContext context, int index) {
                          final UserAddress data =
                              _manageAddressController.address[index];
                          return listData(index, data, setState);
                        }),
                  ),
                ),
              ),
              Obx(
                () => AppButton(
                  onPressed: () => Get.back(),
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  isDisable: _classDetailController.selectedIndex?.value != 200
                      ? false
                      : true,
                  title: 'select'.tr,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                    onPressed: () {
                      final Map<String, dynamic> titleData = {
                        'title': 'Add New Addresses',
                      };
                      Get.toNamed(Routes.addAddressView, arguments: titleData);
                    },
                    child: Text(
                      'addNewAddress'.tr,
                      style: openSans.w700,
                    )),
              )
            ]);
          });
        });
  }

  Future<void> calender(
    BuildContext context,
    TextEditingController controller,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AppCalender(
              selectedTime: (DateTime selectedTime) {
                _classDetailController.selectedTimes =
                    formatTime(selectedTime).obs;
                controller.text =
                    '${_classDetailController.selectedDate} ${_classDetailController.selectedTimes}';
              },
              selectedDate: (String selectedDate) {
                _classDetailController.selectedDate.value = selectedDate;
                controller.text =
                    '${_classDetailController.selectedDate} ${_classDetailController.selectedTimes}';
              },
                startDate:DateTime.now()
            );
          },
        );
      },
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  Future<void> showTimePickerDialog(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // Handle the selected time
      final String formattedTime =
          '${selectedTime.hour}:${selectedTime.minute}';
      _classDetailController.timeController.text = formattedTime;
    }
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
          child: Padding(
            padding: EdgeInsets.all(padding ?? 5.0),
            child: Icon(
              icon,
              size: iconSize ?? 23,
              color: AppColors.white,
            ),
          )),
    );
  }

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime currentDate = DateTime.now();
    final int eligibleYear = currentDate.year - 18;

    final DateTime eligibleDate =
        DateTime(eligibleYear, currentDate.month, currentDate.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eligibleDate,
      firstDate: DateTime(1950),
      lastDate: eligibleDate,
    );
    if (picked != null) {
      controller.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  void bottomSheetDropDownList(List<String> data, int isSelected,
      {required Function(int) myValueGetter, bool? isClassDuration}) {
    final double width = MediaQuery.sizeOf(context).width;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('classDuration'.tr, style: openSans.get14.w700),
                        SizedBox(
                          width: width * 0.25,
                        ),
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    AppColors.downArrowColor.withOpacity(0.15)),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 15,
                              ),
                            ))
                      ]),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                        isClassDuration != null
                            ? data[index].timeConvert()
                            : data[index],
                        style: openSans.get16.w400
                            .textColor(AppColors.appTextColor)),
                    onTap: () {
                      myValueGetter(index);
                    },
                    trailing: isSelected == index
                        ? const Icon(
                            Icons.check_circle,
                            color: AppColors.appBlue,
                          )
                        : const SizedBox(),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
