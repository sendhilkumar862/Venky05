import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../core/typography.dart';
import '../../custom/app_button/app_button.dart';
import '../../custom/app_textformfield/app_field.dart';
import '../../custom/appbar/appbar.dart';
import '../../custom/common_dropdown/app_dropdown.dart';
import '../../product/constants/colors/app_colors_constants.dart';

class ClassDetail extends StatefulWidget {
  const ClassDetail({super.key});

  @override
  State<ClassDetail> createState() => _ClassDetailState();
}

class _ClassDetailState extends State<ClassDetail> {
  var selectedDate = DateTime.now();
  final RequiredValidator requiredValidator =
      RequiredValidator(errorText: 'This field is required');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  TextEditingController classCost = TextEditingController();
  TextEditingController numberOfSession = TextEditingController();
  TextEditingController participators2 = TextEditingController();
  TextEditingController participators3 = TextEditingController();
  TextEditingController participators4 = TextEditingController();
  TextEditingController participators5 = TextEditingController();
  TextEditingController classDurationController = TextEditingController();
  SfRangeValues value = SfRangeValues(40, 40);
  double sliderValue = 50.0;
  bool isDisable = true;
  String dateAndTime = '';
  String classDuration = '';
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
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: HessaAppBar(
        isBack: true,
        trailingText: 'Cancel',
        titleText: 'Create class',
        normalAppbar: true,
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
                      'Class Details',
                      style:
                          poppins.get20.w700.textColor(AppColors.appTextColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'participators',
                      style: poppins.get12.w400
                          .textColor(AppColors.appTextColor.withOpacity(0.5)),
                    ),
                  ),
                  SfRangeSlider(
                    max: 100.0,
                    values: value,
                    interval: 20,
                    minorTicksPerInterval: 1,
                    onChanged: (SfRangeValues values) {
                      setState(() {
                        value = values;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Minimum',
                          style: poppins.get10.w400.textColor(
                              AppColors.appTextColor.withOpacity(0.5))),
                      Text('Maximum',
                          style: poppins.get10.w400.textColor(
                              AppColors.appTextColor.withOpacity(0.5))),
                    ],
                  ),
                  AppTextFormField(
                    controller: classCost,
                    keyboardType: const TextInputType.numberWithOptions(),
                    validate: requiredValidator,
                    suffix: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text('KWD', style: poppins.get16.w400),
                    ),
                    hintText: 'Class Cost',
                  ),
                  AppTextFormField(
                    controller: numberOfSession,
                    validate: requiredValidator,
                    hintText: 'Number Of Sessions',
                  ),
                  AppTextFormField(
                    controller: dateController,
                    onTap: () {
                      selectDate(context);
                    },
                    hintText: 'select Date and Time',
                    readOnly: true,
                    suffix: Icon(Icons.keyboard_arrow_down_sharp,
                        color: AppColors.downArrowColor),
                  ),
                  AppDropdown(
                    hintText: 'select Date and Time',
                    validate: requiredValidator,
                    title: 'Class Date and Time',
                    options: dateAndTimeList,
                    getLabel: (String value) => value,
                    value: DateFormat('dd-MM-yyyy').format(selectedDate),
                    onChanged: (String? value) {
                      dateAndTime = value.toString();
                    },
                  ),
                  AppDropdown(
                    hintText: 'select Class 2 Date and Time',
                    validate: requiredValidator,
                    title: 'Class 2 Date and Time',
                    options: dateAndTimeList,
                    getLabel: (String value) => value,
                    value: dateAndTime,
                    onChanged: (String? value) {
                      dateAndTime = value.toString();
                    },
                  ),
                  AppTextFormField(
                    suffix: Icon(Icons.keyboard_arrow_down_sharp,
                        color: AppColors.downArrowColor),
                    hintText: 'Class Duration',
                    title: 'Class Duration',
                    readOnly: true,
                    controller: classDurationController,
                    onTap: () {
                      bottomSheetDropDownList();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 7),
                    child: Text(
                      'Select Location',
                      style: TextStyle(
                          color: const Color(0xff051335).withOpacity(0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(15),
                        color: AppColors.appColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                'No Address Found!',
                                style: poppins.get16.w700,
                              )),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: AppButton(
                                    borderRadius: BorderRadius.circular(10),
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    borderColor: AppColors.appColor,
                                    isBorderOnly: true,
                                    textStyle: const TextStyle(
                                        color: AppColors.appColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                    height: 45,
                                    width: width,
                                    title: 'Add Address Found',
                                    onPressed: () {},
                                    isDisable: isDisable),
                              )
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Other Participators',
                          style: poppins.get20.w700
                              .textColor(AppColors.appTextColor),
                        ),
                        Text(
                          '(optional)',
                          style: poppins.get12.w400.textColor(
                              AppColors.appTextColor.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),
                  AppTextFormField(
                    top: 0,
                    controller: participators2,
                    validate: requiredValidator,
                    title: 'participators 2',
                    hintText: 'Enter email address',
                  ),
                  AppTextFormField(
                    controller: participators3,
                    validate: requiredValidator,
                    title: 'participators 3',
                    hintText: 'Enter email address',
                  ),
                  AppTextFormField(
                    controller: participators4,
                    validate: requiredValidator,
                    title: 'participators 4',
                    hintText: 'Enter email address',
                  ),
                  AppTextFormField(
                    controller: participators5,
                    validate: requiredValidator,
                    title: 'participators 5',
                    hintText: 'Enter email address',
                  ),
                  AppButton(
                    title: 'Next for calls Details',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                    },
                    isDisable: isDisable,
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
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
      selectedDate = picked;
      dateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  void bottomSheetDropDownList() {
    showModalBottomSheet(
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                Text('Class Duration', style: poppins.get14.w700),
                const SizedBox(width: 80),
                Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.appTextColor),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Padding(
                        padding: EdgeInsets.all(3),
                        child: Icon(Icons.close),
                      ),
                    ))
              ]),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, index) {
                    return const Divider();
                  },
                  itemCount: classDurationList.length,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      title: Text(classDurationList[index],
                          style: poppins.get16.w400
                              .textColor(AppColors.appTextColor)),
                      onTap: () {
                        classDurationController.text = classDurationList[index];
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
