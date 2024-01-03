import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/typography.dart';
import '../../../tutorial/mobileEnter/model/country_code_model.dart';
import '../bottomSheet/country_bottom_sheets.dart';
import '../bottomSheet/language_bottom_sheets.dart';
import '../controller/personal_info_controllere.dart';


class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  bool isSelected = false;
  int? isSelect;
  int? selectedIndex = 0;
  final PersonalInfoController _personalInfoController= Get.put(PersonalInfoController());

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
    return Scaffold(
      appBar: HessaAppBar(
        trailingText: 'Cancel',
        title: 'Complete Profile',
        isTitleOnly: true,
      ),
      body: Obx(()=>
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SingleChildScrollView(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child:
                Text('Personal Information', style: openSans.get20.w700.textColor(AppColors.appTextColor)),
              ),
              selectCardView(
                icon: _personalInfoController.selectedCountry.value.flag_url,
                title: _personalInfoController.selectedCountry.value.name,
                hint: 'Select your nationality',
                mainTitle: 'Nationality',
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
                      return CountryBottomsSheets(
                        setState: setState,
                      );
                    },
                  );
                },
              ),
              AppTextFormField(
                readOnly: true,
                title: 'Languages Spoken',
                hintText:'Select spoken languages' ,
                suffix: const Icon(Icons.keyboard_arrow_down_sharp),
                controller: _personalInfoController.languageController,
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
                      return LanguageBottomSheets(
                          setState: setState);
                    },
                  );
                },
              ),
              AppTextFormField(
                controller: _personalInfoController.dateController,
                onTap: () {
                  calender(context, _personalInfoController.dateController);
                },
                readOnly: false,
                title: 'Birthday',
                hintText: 'Select your birthday',
                suffix: const Icon(Icons.keyboard_arrow_down_sharp),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: <Widget>[
                    Text('Make it visible for users',
                        style: openSans.get14.w500.textColor(AppColors.appTextColor)),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: FlutterSwitch(
                        value:_personalInfoController.isSwitch.value,
                        height: 16.29,
                        width: 27.63,
                        toggleSize: 12,
                        activeColor: AppColors.appBlue,
                        inactiveColor: AppColors.gray.withOpacity(0.25),
                        onToggle: (bool value) {
                          setState(() {
                            _personalInfoController.isSwitch.value = value;
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
                  style: openSans.get12.w400.textColor(AppColors.appTextColor.withOpacity(0.5)),
                ),
              ),
              genderGridView(),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: Text('Civil ID',
                    style: openSans.get12.w400.textColor(AppColors.appTextColor.withOpacity(0.5))),
              ),
              Obx(()=>
                Center(
                  child: SizedBox(
                    width: width * 0.89,
                    child: InkWell(
                      onTap: () {
                        _personalInfoController.pickDocument();
                      },
                      child: DottedBorder(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(15),
                          color: AppColors.appBlue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: _personalInfoController.imageFile.isNotEmpty?80:0,
                                child: Align(
                                  child: ListView.separated(
                                    separatorBuilder: (_,i){
                                      return const SizedBox(width: 10,);
                                    },
                                    itemCount: _personalInfoController.imageFile.length,
                                    scrollDirection: Axis.horizontal,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (_,int index){
                                      final File mediaFile= _personalInfoController.imageFile[index];
                                      return SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(
                                                        color: AppColors.appBorderColor.withOpacity(0.5))),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child:!mediaFile.path.contains('pdf')? Image.file(
                                                    mediaFile,
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  ):PdfView(path: mediaFile.path),)),
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _personalInfoController.imageFile.removeAt(index);
                                                      _personalInfoController.civilIds.removeAt(index);
                                                    });
                                                  },
                                                  child: Container(
                                                      margin:
                                                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                                      padding: const EdgeInsets.all(3),
                                                      decoration: BoxDecoration(
                                                          color: AppColors.downArrowColor.withOpacity(0.15),
                                                          shape: BoxShape.circle),
                                                      child: const Icon(
                                                        Icons.close,
                                                        size: 20,
                                                      )),
                                                ))
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              if (_personalInfoController.imageFile.length!=2)
                                Padding(
                                  padding:
                                  EdgeInsets.only(top: _personalInfoController.imageFile.length!=2 ? 0 : 15),
                                  child: Column(
                                    children: <Widget>[
                                      const Icon(Icons.cloud_upload_outlined, color: AppColors.appBlue),
                                      Center(
                                          child: Text(
                                            _personalInfoController.imageFile.isNotEmpty ? 'Add More' : 'Upload Civil ID',
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 40),
                  height: 64,
                  width: width,
                  decoration:
                  BoxDecoration(color: AppColors.lightPurpleTwo, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 7),
                        child: Icon(Icons.info, size: 25, color: AppColors.downArrowColor),
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
                    if(_personalInfoController.countries.isNotEmpty &&  _personalInfoController.languageIcon.isNotEmpty && _personalInfoController.dateController.text.isNotEmpty) {
                      _personalInfoController.personalInformationUpdate();
                    }
                  },
                  isDisable: _personalInfoController.countries.isNotEmpty &&  _personalInfoController.languageIcon.isNotEmpty && _personalInfoController.dateController.text.isNotEmpty ?false:true )
            ],
          )),
        ),
      ),
    );
  }



  Widget genderGridView() {
    return Obx( (){
    final int indexSelected = _personalInfoController.genderListIndex.value;
   return  GridView.builder(
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
                onTap: () =>
                    _personalInfoController.genderListIndex.value = index,
                child: Container(
                  decoration: BoxDecoration(
                      color: index ==indexSelected? AppColors.appBlue : AppColors.white,
                      border: Border.all(color: AppColors.appBorderColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(
                    data.gender,
                    style: openSans.w400.get14.textColor(
                      index ==indexSelected ? AppColors.white : AppColors.appTextColor,
                    ),
                  )),
                ));
          },
        );}
    );
  }

  Future<void> calender(BuildContext context, TextEditingController controller) async {
    List<DateTime?> currentDate = <DateTime?>[DateTime.now()];
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          contentPadding: EdgeInsets.all(0),
          content: Container(
            height: 350,
            width: 500,
            child: CalendarDatePicker2(
              onValueChanged: (List<DateTime?> value) {

                setState(() {
                  currentDate = value;
                  final String selectedDate = currentDate[0] != null
                      ? "${currentDate[0]!.day}-${currentDate[0]!.month}-${currentDate[0]!.year}"
                      : "";
                  controller.text = selectedDate;
                  Navigator.of(context).pop();
                });
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
                weekdayLabelTextStyle: openSans.get13.w600.textColor(AppColors.arsenic.withOpacity(0.3)),
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

  Widget selectCardView({String? mainTitle, String? icon, String? title, String? hint, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            mainTitle ?? '',
            fontSize: 12.px,
            fontWeight: FontWeight.w400,
            color: AppColors.appTextColor.withOpacity(0.5),
          ),
          SizedBox(height: 6.px),
          Container(
            height: 50.px,
            padding: EdgeInsets.only(top: 12.px, bottom: 12.px, right: 10.px, left: 14.px),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.px),
              border: Border.all(
                color: AppColors.appBorderColor,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (title == null || title.isEmpty)
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: AppImageAsset(
                            fit: BoxFit.fill,
                            image: icon ?? ImageConstants.earthIcon,
                            height: 20.px,
                            width: 20.px,
                          ),
                        ),
                        SizedBox(
                          width: 12.px,
                        ),
                        Expanded(
                          child: AppText(
                            title ?? hint ?? '',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.px,
                            color: AppColors.appGrey,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: AppImageAsset(
                            fit: BoxFit.fill,
                            image: icon ?? ImageConstants.earthIcon,
                            height: 20.px,
                            width: 20.px,
                          ),
                        ),
                        SizedBox(
                          width: 12.px,
                        ),
                        Expanded(
                          child: AppText(
                            title ?? '',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  width: 12.px,
                ),
                const Icon(Icons.keyboard_arrow_down_sharp),
              ],
            ),
          ),
        ],
      ),
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

  final List<CountryCodeModel> countryList;
  final Function(CountryCodeModel) onSelect;

  @override
  _CountrySelectionListState createState() => _CountrySelectionListState();
}

class _CountrySelectionListState extends State<CountrySelectionList> {
  late List<bool> selectedCountries;

  @override
  void initState() {
    super.initState();
    selectedCountries = List.generate(widget.countryList.length, (int index) => false);
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
          final CountryCodeModel country = widget.countryList[index];
          return ListTile(
            title: Text(''),
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
