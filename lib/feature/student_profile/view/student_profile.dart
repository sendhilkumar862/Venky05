import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/typography.dart';
import '../viewModel/student_profile_view_model.dart';

class StudentProfileView extends StatefulWidget {
  const StudentProfileView({super.key});

  @override
  State<StudentProfileView> createState() => _StudentProfileViewState();
}

class _StudentProfileViewState extends State<StudentProfileView> {
  StudentProfileViewModel studentProfileViewModel = StudentProfileViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HessaAppBar(
          isTitleOnly: true,
          title: 'User Profile',
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            studentProfileViewModel.isTeacherView =
                !studentProfileViewModel.isTeacherView;
            setState(() {});
          },
        ),
        body: Observer(
          builder: (BuildContext context) {
            return ListView(
              children: <Widget>[
                const SizedBox(height: 60),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: const AppImageAsset(
                        image: ImageConstants.avtar,
                      )),
                ),
                const SizedBox(height: 10),
                const AppText(
                  'User Name',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appDarkBlack,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.appBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppImageAsset(
                              image: ImageConstants.messageIcon,
                              height: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            AppText(
                              'Message',
                              color: AppColors.appWhite,
                              fontSize: 14,
                            ),
                          ]),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.appBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppImageAsset(
                              image: ImageConstants.saveIcon,
                              height: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            AppText(
                              'Message',
                              color: AppColors.appWhite,
                              fontSize: 14,
                            ),
                          ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.px,
                ),
                buildExperienceCardView(),
                SizedBox(height: 15.px),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.px),
                  padding: EdgeInsets.all(14.px),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.lightPurple),
                      color: AppColors.lightPurple),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppText(
                                'Grade',
                                fontSize: 10.px,
                                color: AppColors.appGrey,
                              ),
                              AppText(
                                'High School - University',
                                fontSize: 14.px,
                                fontWeight: FontWeight.w700,
                              )
                            ],
                          ),
                          SizedBox(width: 25.px),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              AppText(
                                'School',
                                fontSize: 10.px,
                                color: AppColors.appGrey,
                              ),
                              AppText(
                                'Private - Public',
                                fontSize: 14.px,
                                fontWeight: FontWeight.w700,
                              )
                            ],
                          ),
                        ],
                      ),
                      if (studentProfileViewModel.isTeacherView)
                        SizedBox(height: 15.px),
                      if (studentProfileViewModel.isTeacherView)
                        Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AppText(
                                  'Subject',
                                  fontSize: 10.px,
                                  color: AppColors.appGrey,
                                ),
                                AppText(
                                  'Science - Physics - Chemistry',
                                  fontSize: 14.px,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            )
                          ],
                        ),
                      SizedBox(height: 15.px),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppText(
                                'Curriculum',
                                fontSize: 10.px,
                                color: AppColors.appGrey,
                              ),
                              AppText(
                                'Arabic - English - British',
                                fontSize: 14.px,
                                fontWeight: FontWeight.w700,
                              )
                            ],
                          ),
                        ],
                      ),
                      if (studentProfileViewModel.isTeacherView)
                        buildEducationCard()
                    ],
                  ),
                ),
                SizedBox(height: 15.px),
                if (studentProfileViewModel.isTeacherView)
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.px),
                      child: const AppText(
                        'Available Times',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
                SizedBox(height: 15.px),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.px),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.appGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(children: [
                    const AppImageAsset(
                        image: ImageConstants.starSecondary, height: 80),
                    SizedBox(height: 15.px),
                    const AppText(
                      'No Available Times!',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 8.px),
                    const AppText(
                      'Please consider booking on a different day.',
                      fontSize: 12,
                      color: AppColors.appGrey,
                    )
                  ]),
                ),
                if (studentProfileViewModel.isTeacherView)
                  const AvailableTimesCalender(),
              ],
            );
          },
        ));
  }

  buildEducationCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 5),
        const Divider(),
        SizedBox(height: 5.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  'Education',
                  fontSize: 10.px,
                  color: AppColors.appGrey,
                ),
                AppText(
                  'Bachelors degree in education',
                  fontSize: 14.px,
                  fontWeight: FontWeight.w700,
                )
              ],
            )
          ],
        ),
        SizedBox(height: 15.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  'Experience Brief',
                  fontSize: 10.px,
                  color: AppColors.appGrey,
                ),
                AppText(
                  'Bachelors degree in education',
                  fontSize: 14.px,
                  fontWeight: FontWeight.w700,
                )
              ],
            )
          ],
        ),
        SizedBox(height: 15.px),
        AppText(
          'Certificates',
          fontSize: 10.px,
          color: AppColors.appGrey,
        ),
        SizedBox(height: 5.px),
        SizedBox(
          height: 100,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 100.px,
                  width: 100.px,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage(ImageConstants.certificates),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(5.px)),
                  child: Stack(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            color: AppColors.appLightGrey,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(6),
                          child: const AppImageAsset(image: ImageConstants.eye),
                        ),
                      ],
                    )
                  ]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 5);
              },
              itemCount: 2),
        ),
      ],
    );
  }

  Container buildExperienceCardView() => Container(
        margin: EdgeInsets.symmetric(horizontal: 15.px),
        padding: EdgeInsets.all(15.px),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.lightPurple),
        ),
        child: (studentProfileViewModel.isTeacherView)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      AppText(
                        'Experience',
                        fontSize: 10.px,
                        color: AppColors.appGrey,
                      ),
                      AppText(
                        '10 Years',
                        fontSize: 14.px,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  ),
                  SizedBox(width: 25.px),
                  Column(
                    children: <Widget>[
                      AppText(
                        'Classes',
                        fontSize: 10.px,
                        color: AppColors.appGrey,
                      ),
                      AppText(
                        '48',
                        fontSize: 14.px,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  ),
                  SizedBox(width: 25.px),
                  Column(
                    children: <Widget>[
                      AppText(
                        'Favourite',
                        fontSize: 10.px,
                        color: AppColors.appGrey,
                      ),
                      AppText(
                        '24',
                        fontSize: 14.px,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      AppText(
                        'Attended Classes ',
                        fontSize: 10.px,
                        color: AppColors.appGrey,
                      ),
                      AppText(
                        '48',
                        fontSize: 14.px,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  ),
                  SizedBox(width: 25.px),
                  Column(
                    children: <Widget>[
                      AppText(
                        'Created Classes',
                        fontSize: 10.px,
                        color: AppColors.appGrey,
                      ),
                      AppText(
                        '14',
                        fontSize: 14.px,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  ),
                ],
              ),
      );
}

class AvailableTimesCalender extends StatelessWidget {
  const AvailableTimesCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      margin: EdgeInsets.symmetric(horizontal: 15.px),
      child: SfCalendar(
        view: CalendarView.week,
        initialSelectedDate: DateTime(2019, 12, 20, 12),
        initialDisplayDate: DateTime(2023, 12, 20, 12),
        cellBorderColor: AppColors.white,
        showDatePickerButton: true,
        todayHighlightColor: AppColors.appBlue,
        headerStyle: const CalendarHeaderStyle(
            textStyle: TextStyle(
          color: AppColors.appDarkBlack,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        )),
        showTodayButton: true,
        showCurrentTimeIndicator: false,
        todayTextStyle: const TextStyle(color: Colors.white),
        timeZone: 'India Standard Time',
        viewHeaderStyle: const ViewHeaderStyle(
            dayTextStyle: TextStyle(
                color: AppColors.appGrey, fontWeight: FontWeight.w500),
            dateTextStyle: TextStyle(
                color: AppColors.appGrey, fontWeight: FontWeight.w500)),
        timeSlotViewSettings: const TimeSlotViewSettings(
            timeIntervalHeight: 25,
            allDayPanelColor: Colors.green,
            timeFormat: 'hh:mm a',
            timeTextStyle: TextStyle(
              color: AppColors.appGrey,
            )),
      ),
    );
  }
}
