import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/sheet/country_bottom_sheet.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';
import '../viewModel/personal_info_view_model.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  File? firstImage;
  File? secondImage;
  bool isSwitch = false;
  bool isSelected = false;
  int genderListIndex = 0;
  int? isSelect;
  int? selectedIndex = 0;
  TextEditingController dateController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();

  List<Gender> genderList = <Gender>[
    Gender(
      gender: 'Male',
      selected: false,
    ),
    Gender(
      gender: 'Female',
      selected: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return BaseView<PersonalInfoViewModel>(
        viewModel: PersonalInfoViewModel(),
        onModelReady: (PersonalInfoViewModel model) {
          model.setContext(context);
        },
        onPageBuilder: (BuildContext context,
            PersonalInfoViewModel personalInfoViewModel) {
          return Scaffold(
            appBar: HessaAppBar(
              trailingText: 'Cancel',
              title: 'Complete Profile',
              isTitleOnly: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text('Personal Information',
                          style: openSans.get20.w700
                              .textColor(AppColors.appTextColor)),
                    ),
                    AppTextFormField(
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
                              builder: (BuildContext context, setState) {
                                return Observer(builder: (_) {
                                  return CountryBottomSheet(
                                    countries: personalInfoViewModel.countries,
                                    selectedIndex: selectedIndex,
                                    onTap: (int index) {
                                      selectedIndex = index;
                                      personalInfoViewModel.selectItem(
                                          personalInfoViewModel
                                              .countries[index]);
                                      nationalityController.text =
                                          personalInfoViewModel.selectedItem;
                                    },
                                  );
                                });
                              },
                            );
                          },
                        );
                      },
                      readOnly: true,
                      title: 'Nationality',
                      hintText: 'Select your nationality',
                      suffix: const Icon(Icons.keyboard_arrow_down_sharp),
                    ),
                    const AppTextFormField(
                      readOnly: true,
                      title: 'Languages Spoken',
                      hintText: 'Select spoken languages',
                      suffix: Icon(Icons.keyboard_arrow_down_sharp),
                    ),
                    AppTextFormField(
                      controller: dateController,
                      onTap: () {
                        calender(context, dateController);
                      },
                      readOnly: true,
                      title: 'Birthday',
                      hintText: 'Select your birthday',
                      suffix: const Icon(Icons.keyboard_arrow_down_sharp),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: <Widget>[
                          Text('Make it visible for users',
                              style: openSans.get14.w500
                                  .textColor(AppColors.appTextColor)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: FlutterSwitch(
                              value: isSwitch,
                              height: 16.29,
                              width: 27.63,
                              toggleSize: 12,
                              activeColor: AppColors.appBlue,
                              inactiveColor: AppColors.gray.withOpacity(0.25),
                              onToggle: (bool value) {
                                setState(() {
                                  isSwitch = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 15),
                      child: Text(
                        'Gender',
                        style: openSans.get12.w400
                            .textColor(AppColors.appTextColor.withOpacity(0.5)),
                      ),
                    ),
                    gridView(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
                      child: Text('Civil ID',
                          style: openSans.get12.w400.textColor(
                              AppColors.appTextColor.withOpacity(0.5))),
                    ),
                    Center(
                      child: SizedBox(
                        width: width * 0.89,
                        child: InkWell(
                          onTap: () {
                            pickDocument();
                          },
                          child: DottedBorder(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(15),
                              color: AppColors.appBlue,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      if (firstImage != null)
                                        SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .appBorderColor
                                                              .withOpacity(
                                                                  0.5))),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Image.file(
                                                        firstImage!,
                                                        width: 80,
                                                        height: 80,
                                                        fit: BoxFit.cover,
                                                      ))),
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        firstImage = null;
                                                      });
                                                    },
                                                    child: Container(
                                                        margin:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 5,
                                                                horizontal: 5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .downArrowColor
                                                                .withOpacity(
                                                                    0.15),
                                                            shape: BoxShape
                                                                .circle),
                                                        child: const Icon(
                                                          Icons.close,
                                                          size: 20,
                                                        )),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      if (secondImage != null)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .appBorderColor
                                                                .withOpacity(
                                                                    0.5))),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: Image.file(
                                                          secondImage!,
                                                          width: 80,
                                                          height: 80,
                                                          fit: BoxFit.cover,
                                                        ))),
                                                Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          secondImage = null;
                                                        });
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      5),
                                                          padding:
                                                              EdgeInsets.all(3),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .downArrowColor
                                                                  .withOpacity(
                                                                      0.15),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Icon(
                                                            Icons.close,
                                                            size: 20,
                                                          )),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (secondImage == null || firstImage == null)
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: secondImage == null &&
                                                  firstImage == null
                                              ? 0
                                              : 15),
                                      child: Column(
                                        children: <Widget>[
                                          const Icon(
                                              Icons.cloud_upload_outlined,
                                              color: AppColors.appBlue),
                                          Center(
                                              child: Text(
                                            firstImage != null
                                                ? 'Add More'
                                                : 'Upload Civil ID',
                                            style: openSans.get14.w500.appBlue,
                                          )),
                                        ],
                                      ),
                                    ),
                                ],
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 40),
                        height: 64,
                        width: width,
                        decoration: BoxDecoration(
                            color: AppColors.lightPurpleTwo,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: Icon(Icons.info,
                                  size: 25, color: AppColors.downArrowColor),
                            ),
                            Expanded(
                              child: Text(
                                'Civil ID for usage of app only, and we will not share this doc with anyone.',
                                style: openSans.get12.w400.appTextColor,
                                overflow: TextOverflow.clip,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    AppButton(
                        title: 'Continue To Teaching Information',
                        onPressed: () {
                          AppRouter.pushNamed(Routes.teachingInfo);
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> pickDocument() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['pdf', 'png', 'jpeg', 'jpg'],
    );
    if (result != null) {
      if (firstImage == null) {
        setState(() {
          firstImage = File(result.files.single.path ?? '');
        });
      } else {
        setState(() {
          secondImage = File(result.files.single.path ?? '');
        });
      }
    }
  }

  Widget gridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: genderList.length,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 44,
      ),
      itemCount: genderList.length,
      itemBuilder: (BuildContext context, int index) {
        final Gender data = genderList[index];
        return InkWell(
            onTap: () {
              setState(() {
                genderListIndex = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: index == genderListIndex
                      ? AppColors.appBlue
                      : AppColors.white,
                  border: Border.all(
                      color: AppColors.appBorderColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: Text(
                data.gender,
                style: openSans.w400.get14.textColor(
                  index == genderListIndex
                      ? AppColors.white
                      : AppColors.appTextColor,
                ),
              )),
            ));
      },
    );
  }

  Future<void> calender(
      BuildContext context, TextEditingController controller) async {
    List<DateTime?> currentDate = <DateTime?>[DateTime.now()];
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          contentPadding: EdgeInsets.all(0),
          content: Container(
            height: 350,
            width: 500,
            child: CalendarDatePicker2(
              onValueChanged: (List<DateTime?> value) {
                currentDate = value;
                final String selectedDate = currentDate[0] != null
                    ? "${currentDate[0]!.day}-${currentDate[0]!.month}-${currentDate[0]!.year}"
                    : "";
                controller.text = selectedDate;
                Navigator.of(context).pop();
              },
              value: currentDate,
              config: CalendarDatePicker2Config(
                selectedDayHighlightColor: Color(0xff007AFF),
                weekdayLabels: <String>[
                  'SUN',
                  'MON',
                  'TUE',
                  'WED',
                  'THU',
                  'FRI',
                  'SAT',
                ],
                customModePickerIcon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                  color: Color(0xff007AFF),
                ),
                dayTextStyle: openSans.get20.w400,
                weekdayLabelTextStyle: openSans.get13.w600
                    .textColor(AppColors.arsenic.withOpacity(0.3)),
                yearTextStyle: const TextStyle(color: Colors.black),
                controlsTextStyle: openSans.get17.w600,
                nextMonthIcon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Color(0xff007AFF),
                ),
                lastMonthIcon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Color(0xff007AFF),
                ),
                calendarType: CalendarDatePicker2Type.single,
                selectedDayTextStyle: const TextStyle(color: Colors.white),
                selectedYearTextStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Gender {
  Gender({
    required this.gender,
    required this.selected,
  });
  final String gender;
  final bool selected;
}

class CountrySelectionList extends StatefulWidget {
  const CountrySelectionList({
    super.key,
    required this.countryList,
    required this.onSelect,
  });
  final List<Country> countryList;
  final Function(Country) onSelect;

  @override
  _CountrySelectionListState createState() => _CountrySelectionListState();
}

class _CountrySelectionListState extends State<CountrySelectionList> {
  late List<bool> selectedCountries;

  @override
  void initState() {
    super.initState();
    selectedCountries =
        List.generate(widget.countryList.length, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Countries'),
      ),
      body: ListView.builder(
        itemCount: widget.countryList.length,
        itemBuilder: (BuildContext context, int index) {
          final Country country = widget.countryList[index];
          return ListTile(
            title: Text(country.name),
            leading: Checkbox(
              value: selectedCountries[index],
              onChanged: (bool? value) {
                setState(() {
                  selectedCountries[index] = value ?? false;
                  widget.onSelect(country);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
