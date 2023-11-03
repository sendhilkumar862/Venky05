import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hessah/config/routes/app_router.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/choice/src/modal/button.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';
import '../../../../product/utils/validators.dart';
import '../../address/view/address_view.dart';
import '../viewModel/class_detail_view_model.dart';

class ClassDetail extends StatefulWidget {
  const ClassDetail({super.key});

  @override
  State<ClassDetail> createState() => _ClassDetailState();
}

class _ClassDetailState extends State<ClassDetail> {
  var selectedDate = DateTime.now();
  int? isSelected;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
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
  List<Address> location = <Address>[
    Address('Home', 'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
    Address('Work', 'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
    Address('Home', 'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
    Address('Work', 'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
  ];
  int? selectedIndex;
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
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return BaseView<ClassDetailViewModel>(
        viewModel: ClassDetailViewModel(),
        onModelReady: (ClassDetailViewModel model) {
          model.setContext(context);
        },
        onPageBuilder: (BuildContext context, ClassDetailViewModel value) {
          return MaterialApp(
            title: 'Flutter Demo',
            home: Scaffold(
              appBar: HessaAppBar(
                // isBack: true,
                // trailingText: 'Cancel',
                // titleText: 'Create class',
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
                              'Class Details',
                              style: openSans.get20.w700
                                  .textColor(AppColors.appTextColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'participators',
                              style: openSans.get12.w400.textColor(
                                  AppColors.appTextColor.withOpacity(0.5)),
                            ),
                          ),
                          SfRangeSlider(
                            max: 100.0,
                            values: sliderValue,
                            interval: 20,
                            minorTicksPerInterval: 1,
                            onChanged: (SfRangeValues values) {
                              setState(() {
                                sliderValue = values;
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Minimum',
                                  style: openSans.get10.w400.textColor(
                                      AppColors.appTextColor.withOpacity(0.5))),
                              Text('Maximum',
                                  style: openSans.get10.w400.textColor(
                                      AppColors.appTextColor.withOpacity(0.5))),
                            ],
                          ),
                          AppTextFormField(
                            controller: classCost,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            validate: Validators.requiredValidator.call,
                            suffix: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text('KWD', style: openSans.get16.w400),
                            ),
                            hintText: 'Class Cost',
                          ),
                          AppTextFormField(
                            controller: numberOfSession,
                            validate: Validators.requiredValidator.call,
                            hintText: 'Number Of Sessions',
                          ),
                          AppTextFormField(
                            validate: Validators.requiredValidator.call,
                            controller: dateController,
                            onTap: () {
                              selectDate(context, dateController);
                            },
                            hintText: 'select Date and Time',
                            readOnly: true,
                            suffix: const Icon(Icons.keyboard_arrow_down_sharp,
                                color: AppColors.downArrowColor),
                          ),
                          AppTextFormField(
                            validate: Validators.requiredValidator.call,
                            hintText: 'select Class 2 Date and Time',
                            controller: class2DateController,
                            onTap: () {
                              selectDate(context, class2DateController);
                            },
                            title: 'Class 2 Date and Time',
                            readOnly: true,
                            suffix: const Icon(Icons.keyboard_arrow_down_sharp,
                                color: AppColors.downArrowColor),
                          ),
                          AppTextFormField(
                            validate: Validators.requiredValidator.call,
                            suffix: const Icon(Icons.keyboard_arrow_down_sharp,
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
                                  color:
                                      const Color(0xff051335).withOpacity(0.5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            width: width,
                            child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(15),
                                color: AppColors.appBlue,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  child: Column(
                                    children: [
                                      Center(
                                          child: Text(
                                        'No Address Found!',
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
                                            title: 'Add Address Found',
                                            onPressed: () {
                                              locationModalBottomSheet(context);
                                            },
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
                                  style: openSans.get20.w700
                                      .textColor(AppColors.appTextColor),
                                ),
                                Text(
                                  '(optional)',
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
                            title: 'participators 2',
                            hintText: 'Enter email address',
                          ),
                          AppTextFormField(
                            controller: participators3,
                            validate: emailValidator.call,
                            title: 'participators 3',
                            hintText: 'Enter email address',
                          ),
                          AppTextFormField(
                            controller: participators4,
                            validate: emailValidator.call,
                            title: 'participators 4',
                            hintText: 'Enter email address',
                          ),
                          AppTextFormField(
                            controller: participators5,
                            validate: emailValidator.call,
                            title: 'participators 5',
                            hintText: 'Enter email address',
                          ),
                          AppButton(
                            title: 'Next for calls Details',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {}
                            },
                            isDisable: isDisable,
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget listData(int index, Address data, StateSetter setState) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: selectedIndex == index
                    ? AppColors.appBlue
                    : AppColors.gray.withOpacity(0.25),
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(data.heading, style: openSans.get17.w700),
                          if (selectedIndex == index)
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
                      if (selectedIndex == index)
                        const ChoiceConfirmButton(
                          icon: Icon(
                            Icons.check_circle,
                            color: AppColors.appBlue,
                          ),
                        )
                      else
                        ChoiceConfirmButton(
                            icon: Icon(
                          Icons.circle_outlined,
                          color: AppColors.gray.withOpacity(0.25),
                        ))
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
                    children: [
                      Text(data.address1),
                      Text(data.address2),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      iconButtonWidget(
                        icon: Icons.delete_outline_rounded,
                        padding: 8,
                        bgColor: AppColors.appRed,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: selectedIndex != index ? 10 : 0),
                        child: iconButtonWidget(
                          icon: Icons.edit,
                          padding: 8,
                          bgColor: AppColors.appBlue,
                        ),
                      ),
                      if (selectedIndex != index)
                        ElevatedButton(
                            onPressed: () {
                              setState(() {});
                              selectedIndex = index;
                              print('selectedIndex:-- $selectedIndex');
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(AppColors.appBlue),
                                shape:
                                    MaterialStatePropertyAll(StadiumBorder())),
                            child: const Text('Set Default',
                                style: TextStyle(color: AppColors.white)))
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
          return StatefulBuilder(builder: (context, setState) {
            return Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Class Location', style: openSans.get20.w700),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: location.length,
                          itemBuilder: (context, index) {
                            final data = location[index];
                            return listData(index, data, setState);
                          }),
                    ],
                  ),
                ),
              ),
              AppButton(
                onPressed: () {},
                title: 'Select',
                isDisable: false,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                    onPressed: () {
                      AppRouter.push(const AddressView());
                    },
                    child: Text(
                      'Add New Address',
                      style: openSans.w700,
                    )),
              )
            ]);
          });
        });
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
      builder: (context) {
        return Column(
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('Class Duration', style: openSans.get14.w700),
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
                              icon: Icon(
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
                separatorBuilder: (BuildContext context, index) {
                  return const Divider();
                },
                itemCount: classDurationList.length,
                itemBuilder: (BuildContext context, index) {
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

class Address {
  Address(this.heading, this.address1, this.address2);

  String heading;
  String address1;
  String address2;
}
