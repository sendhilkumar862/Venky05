import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/common_function.dart';
import '../../product/utils/typography.dart';

class AppCalender extends StatefulWidget {
  Function(String) selectedDate;
  Function(DateTime) selectedTime;
  String selectTime = formatTime(DateTime.now());
  DateTime? startDate;
  AppCalender( {required this.selectedTime,required this.selectedDate,super.key, this.startDate});

  @override
  State<AppCalender> createState() => _AppCalenderState();
}

class _AppCalenderState extends State<AppCalender> {
  @override
  Widget build(BuildContext context) {
    List<DateTime?> currentDate = <DateTime?>[DateTime.now()];
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CalendarDatePicker2(
                  onValueChanged: (List<DateTime?> value) {
                    currentDate = value;
                    final String selectedDate = currentDate[0] != null
                        ? '${currentDate[0]!.day}-${currentDate[0]!.month}-${currentDate[0]!.year}'
                        : '';
                    widget.selectedDate(selectedDate);
                    Navigator.of(context).pop();
                  },
                  value: currentDate,
                  config: CalendarDatePicker2Config(
                    selectedDayHighlightColor: const Color(0xff007AFF),
                    weekdayLabels: <String>[
                      'SUN',
                      'MON',
                      'TUE',
                      'WED',
                      'THU',
                      'FRI',
                      'SAT',
                    ],
                    firstDate: widget.startDate,
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
                    selectedDayTextStyle:
                    const TextStyle(color: Colors.white),
                    selectedYearTextStyle:
                    const TextStyle(color: Colors.white),
                  ),
                ),
                Divider(indent: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ends', style: openSans.get17.w400),
                      Row(
                        children: [
                          Container(
                            height: 34,
                            width: 69,
                            padding:
                            EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color:
                              AppColors.xFF767680.withOpacity(0.12),
                            ),
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => _showDialog(
                                CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  mode: CupertinoDatePickerMode.time,
                                  onDateTimeChanged:
                                      (DateTime newTime) {
                                    widget.selectedTime(newTime);
                                    setState(() {
                                      widget.selectTime = formatTime(newTime);
                                    });
                                  },
                                ),
                              ),
                              child: Text(
                                widget.selectTime
                                    .split(' ')
                                    .first,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 34,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3,vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.xFF767680
                                    .withOpacity(0.12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 56,
                                    height: 30,
                                    decoration:  BoxDecoration(
                                        color:  widget.selectTime.split(' ').last == 'AM'? AppColors.white:AppColors.trans,
                                        borderRadius:
                                        BorderRadiusDirectional.all(
                                            Radius.circular(7))),
                                    child: Center(child: Text('AM',style: openSans.get13.w600.appTextColor)),
                                  ) ,

                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Container(
                                      width: 56,
                                      height: 30,
                                      decoration:  BoxDecoration(
                                          color:  widget.selectTime.split(' ').last == 'PM'? AppColors.white:AppColors.trans,
                                          borderRadius:
                                          BorderRadiusDirectional.all(
                                              Radius.circular(7))),
                                      child: Center(child: Text('PM',style: openSans.get13.w600.appTextColor)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
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
}
