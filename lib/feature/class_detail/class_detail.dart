import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../core/typography.dart';
import '../../custom/app_button/app_button.dart';
import '../../custom/app_textformfield/app_field.dart';
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
  RangeValues values = const RangeValues(40, 40);
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
    '2 Hours',
    '3 Hours',
    '4 Hours',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: myAppBar(
      //   isBack: true,
      //   trailingText: 'Cancel',
      //   titleText: 'Create class',
      // ),
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
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Class Details',
                      style: poppins.get20.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'participators',
                      style: poppins.get8.w300,
                    ),
                  ),
                  RangeSlider(
                    activeColor: AppColors.appColor,
                    max: 100,
                    values: values,
                    inactiveColor: AppColors.appBorderColor,
                    onChanged: (RangeValues value) {
                      setState(() {
                        values = value;
                      });
                    },
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
                    suffix: Icon(Icons.keyboard_arrow_down_sharp),
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
                  AppDropdown(
                    hintText: 'Class Duration',
                    validate: requiredValidator,
                    title: 'Class Duration',
                    options: classDurationList,
                    getLabel: (String value) => value,
                    value: classDuration,
                    onChanged: (String? value) {
                      classDuration = value.toString();
                    },
                  ),
                  AppDropdown(
                    hintText: 'Class address',
                    validate: requiredValidator,
                    title: 'Select Location',
                    options: dateAndTimeList,
                    getLabel: (String value) => value,
                    value: dateAndTime,
                    onChanged: (String? value) {
                      dateAndTime = value.toString();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Other Participators',
                          style: poppins.get15.w500,
                        ),
                        Text(
                          '(optional)',
                          style: poppins.get8.w300,
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
}
