import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:hessah/config/routes/app_router.dart';
import 'package:hessah/feature/setting_view/add_address_screen/Model/request_address_model.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/calender/calender.dart';
import '../../../../custom/choice/src/modal/button.dart';
import '../../../../custom/switch/app_switch.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/enums/app_register_status_enums.dart';
import '../../../../product/utils/common_function.dart';
import '../../../../product/utils/typography.dart';
import '../../../../product/utils/validators.dart';
import '../../../setting_view/add_address_screen/controller/add_address_controller.dart';
import '../../../setting_view/add_address_screen/view/add_address_view.dart';
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
  DateTime selectedDate = DateTime.now();
  int? isSelected;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController class2DateController = TextEditingController();
  TextEditingController classCost = TextEditingController();
  TextEditingController numberOfSession = TextEditingController();
  TextEditingController participators2 = TextEditingController();
  TextEditingController participators3 = TextEditingController();
  TextEditingController participators4 = TextEditingController();
  TextEditingController participators5 = TextEditingController();
  TextEditingController classDurationController = TextEditingController();
  final EmailValidator emailValidator = EmailValidator(
      errorText: 'Enter a valid email address (e.g., name@example.com)');
  SfRangeValues sliderValue = const SfRangeValues(40, 40);
  bool isDisable = true;
  String dateAndTime = '';
  String classDuration = '';
  DateTime time = DateTime(2016, 5, 10, 22, 35);
  double _lowerValue = 20.0;
  double _upperValue = 80.0;

  bool isChecked = false;
  List<String> dateAndTimeList = <String>[
    'abs',
    'hello',
    'guys',
  ];
  List<String> classDurationList = <String>[
    '1 Hours',
    '1 Hour - 15 Minutes',
    '1 Hour - 30 Minutes',
    '1 Hour - 45 Minutes',
    '2 Hours',
    '2 Hour - 15 Minutes',
    '2 Hour - 30 Minutes',
    '2 Hour - 45 Minutes',
    '3 Hour',
  ];

  @override
  void initState() {
    _manageAddressController.fetchAddressData();
    // TODO: implement initState
    super.initState();
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
                      values: <double>[_lowerValue, _upperValue],
                      max: 100,
                      min: 0,
                      onDragging: (int handlerIndex, lowerValue, upperValue) {
                        setState(() {
                          _lowerValue = lowerValue;
                          _upperValue = upperValue;
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
                              '${_lowerValue.toInt()}',
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
                              '${_upperValue.toInt()}',
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
                    controller: classCost,
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
                    controller: numberOfSession,
                    validate: Validators.requiredValidator.call,
                    hintText: 'numberOfSessions'.tr,
                  ),
                  AppTextFormField(
                    validate: Validators.requiredValidator.call,
                    controller: dateController,
                    onTap: () {
                      calender(
                        context,
                        dateController,
                      );
                    },
                    hintText: 'selectDateAndTime'.tr,
                    readOnly: true,
                    suffix: const Icon(Icons.keyboard_arrow_down_sharp,
                        color: AppColors.downArrowColor),
                  ),
                  AppTextFormField(
                    validate: Validators.requiredValidator.call,
                    hintText: 'selectClass2DateAndTime'.tr,
                    controller: class2DateController,
                    onTap: () {
                      calender(context, class2DateController);
                    },
                    title: 'class2DateAndTime'.tr,
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
                    controller: classDurationController,
                    onTap: () {
                      bottomSheetDropDownList();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 7),
                    child: Text(
                      'selectLocation'.tr,
                      style: TextStyle(
                          color: const Color(0xff051335).withOpacity(0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Obx((){
                     UserAddress data =UserAddress() ;
                    if(_classDetailController.selectedIndex?.value!=200){
                     data =
                    _manageAddressController.address[_classDetailController.selectedIndex!.value];}
                     return SizedBox(
                      width: width,
                      child: _classDetailController.selectedIndex?.value!=200?Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.appBlue

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
                                        Text(data.shortName ?? '',
                                            style: openSans.get17.w700),

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
                                ],
                              ),
                            ),
                          )):DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(15),
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
                                      borderRadius: BorderRadius.circular(10),
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
                                        locationModalBottomSheet(context);
                                      },
                                      isDisable: isDisable),
                                )
                              ],
                            ),
                          )),
                    );}
                  ),
                  if (_classDetailController.selectedProfile ==
                      ApplicationConstants.tutor)
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 35),
                      child: Row(
                        children: <Widget>[
                          AppText(
                            'allowTheClassAtTheStudentPlace'.tr,
                            fontSize: 14.px,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: 8.px),
                          AppSwitch(
                              onTap: () {
                                _classDetailController.onTapSwitch();
                              },
                              isActive: _classDetailController.isActive.value)
                        ],
                      ),
                    ),
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
                          controller: participators2,
                          validate: emailValidator.call,
                          title: 'participators2'.tr,
                          hintText: 'enterEmailAddress'.tr,
                        ),
                        AppTextFormField(
                          controller: participators3,
                          validate: emailValidator.call,
                          title: 'participators3'.tr,
                          hintText: 'enterEmailAddress'.tr,
                        ),
                        AppTextFormField(
                          controller: participators4,
                          validate: emailValidator.call,
                          title: 'participators4'.tr,
                          hintText: 'enterEmailAddress'.tr,
                        ),
                        AppTextFormField(
                          controller: participators5,
                          validate: emailValidator.call,
                          title: 'participators5'.tr,
                          hintText: 'enterEmailAddress'.tr,
                        ),
                      ],
                    ),
                  AppButton(
                    title: 'nextForClassDetails'.tr,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                    },
                    isDisable: isDisable,
                  ),
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
                color: _classDetailController.selectedIndex?.value == index
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
                          if (_classDetailController.selectedIndex?.value ==
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
                            _classDetailController.selectedIndex?.value = index;
                          },
                          child: _classDetailController.selectedIndex?.value ==
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

                      // if (selectedIndex == index)
                      //   iconButtonWidget(
                      //       icon: Icons.done,
                      //       bgColor: AppColors.appColor,
                      //       iconSize: 18),
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
                        onTap: () {
                          if (data.isDefault == 1) {
                            AppUtils.showFlushBar(
                              context: AppRouter.navigatorKey.currentContext!,
                              message: 'Can not delete default address',
                            );
                          } else {
                            _manageAddressController
                                .deleteAddressData(data.id!);
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
                          AppRouter.push(AddAddressScreen(
                            userData: data,
                            title: "Update Address",
                          ));
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
              Obx(()=>
                AppButton(
                  onPressed: () {},
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  isDisable: _classDetailController.selectedIndex?.value!=200?false:true,
                  title: 'select'.tr,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                    onPressed: () {
                      Get.delete<AddAddressController>();
                      AppRouter.push(
                          AddAddressScreen(title: 'Add New Addresses'));
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
      timeController.text = formattedTime;
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

  void bottomSheetDropDownList() {
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
                itemCount: classDurationList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(classDurationList[index],
                        style: openSans.get16.w400
                            .textColor(AppColors.appTextColor)),
                    onTap: () {
                      isSelected = index;
                      classDurationController.text = classDurationList[index];
                      Navigator.pop(context);
                    },
                    trailing: isSelected == index
                        ? const Icon(
                            Icons.check_circle,
                            color: AppColors.appBlue,
                          )
                        : SizedBox(),
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
