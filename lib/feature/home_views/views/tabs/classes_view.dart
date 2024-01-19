// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/route.dart';
import '../../../../custom/cardView/app_card_view.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../custom/cardView/info_card_view_horizontal.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/extension/string_extension.dart';
import '../../../home/controller/home_controller.dart';

class ClassesView extends StatefulWidget {
  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  String selectedProfile = '';
  bool isPending = false;
  final HomeController _homeController = Get.find();



  @override
  Widget build(BuildContext context) {
    if (selectedProfile == ApplicationConstants.tutor) {
      return Obx(
        () => _homeController.homeData.value?.userStatus == '99'
            ? activeScreen()
            : Column(
                children: <Widget>[
                  if (_homeController.homeData.value?.userStatus == '50' ||
                      _homeController.homeData.value?.userStatus == '60' ||
                      _homeController.homeData.value?.userStatus == '70' ||
                      _homeController.homeData.value?.userStatus == '80')
                    Center(
                      child: InfoCardVIew(
                        isPending: false,
                        isShowButton: true,
                        isSupport: false,
                        isStatus: false,
                        title: 'Complete Your Profile',
                        message: 'Your account has been created Successfully',
                        subTitle:
                            'To kickstart your teaching journey and connect with students, please complete your profile. Revel in every lesson and share the joy of learning!',
                        cardColor: AppColors.white,
                        buttonTitle: 'Completed Profile',
                        buttonTap: () {
                          if (isPending) {
                            setState(() {
                              isPending = !isPending;
                            });
                          } else {
                            if (_homeController.homeData.value?.userStatus ==
                                '50') {
                              Get.toNamed(Routes.personalInfo);
                            } else if (_homeController
                                    .homeData.value?.userStatus ==
                                '60') {
                              Get.toNamed(Routes.teachingInfo);
                            } else if (_homeController
                                    .homeData.value?.userStatus ==
                                '70') {
                              Get.toNamed(Routes.experienceInfo);
                            } else if (_homeController
                                    .homeData.value?.userStatus ==
                                '80') {
                              Get.toNamed(Routes.financingView);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'Already Profile Completed it is in Pending for Review'),
                              ));
                            }
                          }
                        },
                      ),
                    )
                  else if (_homeController.homeData.value?.userStatus == '5')
                    Center(
                      child: InfoCardVIew(
                        isPending: isPending,
                        isShowButton: false,
                        isSupport: true,
                        isStatus: true,
                        title: 'Account Under Review',
                        subTitle:
                            "Once approved, you'll be ready to commence teaching, We'll notify you soon!.",
                        cardColor: AppColors.white,
                        buttonTitle: 'Class Details',
                        buttonTap: () {
                          if (isPending) {
                            setState(() {
                              isPending = !isPending;
                            });
                          } else {
                            Get.toNamed(Routes.reUploadDocument);
                          }
                        },
                      ),
                    )
                  else if (_homeController.homeData.value?.userStatus == '90')
                    Center(
                      child: InfoCardVIew(
                        isPending: isPending,
                        isShowButton: false,
                        isSupport: true,
                        isStatus: false,
                        isStatusRejected: true,
                        title: 'Account Rejected',
                        subTitle:
                            'Your account is rejected because of incorrect information.',
                        cardColor: AppColors.white,
                        buttonTitle: 'Class Details',
                        buttonTap: () {
                          if (isPending) {
                            setState(() {
                              isPending = !isPending;
                            });
                          } else {
                            Get.toNamed(Routes.reUploadDocument);
                          }
                        },
                      ),
                    )
                  else if (_homeController.homeData.value?.userStatus == '7')
                    Center(
                      child: InfoCardVIew(
                        isPending: isPending,
                        isShowButton: false,
                        isSupport: true,
                        isStatus: false,
                        isStatusSusPended: true,
                        title: 'Account Suspended',
                        subTitle:
                            'Your account is suspended because of violation of terms and conditions',
                        cardColor: AppColors.white,
                        buttonTitle: 'Class Details',
                        buttonTap: () {
                          if (isPending) {
                            setState(() {
                              isPending = !isPending;
                            });
                          } else {
                            Get.toNamed(Routes.reUploadDocument);
                          }
                        },
                      ),
                    )
                  else if (_homeController.homeData.value?.userStatus == '6')
                    Center(
                      child: InfoCardVIew(
                        isPending: isPending,
                        isShowButton: true,
                        isSupport: false,
                        isStatus: false,
                        isStatusAction: true,
                        title: 'Account Is Pending For Your Action',
                        subTitle: 'We need you to upload your certificate',
                        cardColor: AppColors.white,
                        buttonTitle: 'Upload Needed Files',
                        buttonTap: () {
                          if (isPending) {
                            setState(() {
                              isPending = !isPending;
                            });
                          } else {
                            Get.toNamed(Routes.reUploadDocument);
                          }
                        },
                      ),
                    )
                  else
                    const SizedBox.shrink()
                ],
              ),
      );
    } else {
      return activeScreen();
    }
  }

  Widget activeScreen() {
    return Obx(() => _homeController.classRelatedList.isEmpty && _homeController.classUpcomingList.isEmpty &&  _homeController.classHistoryList.isEmpty
        ?  Padding(
      padding: EdgeInsets.only(
          right: 8.px, top: 20.px, bottom: 10.px, left: 8.px),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.300,
        child: InfoCardVIew(
          isShowButton: true,
          title: 'No Booked Classes Yet!',
          subTitle: 'Search about Classes or Create New',
          cardColor: AppColors.white,
          buttonTitle: 'Create New Class',
          buttonTap: () {
            Get.toNamed(Routes.createClass);
            // AppRouter.pushNamed(Routes.createClass);
          },
        ),
      ),
    ):Expanded(
            child: ListView(
              children: <Widget>[
                if (_homeController.classUpcomingList.isNotEmpty) InfoCardViewHorizontal(
                  isClassScreen: true,
                  isShowButton: true,
                  title:
                  'Create new class and receive proposals from teachers',
                  cardColor: AppColors.lightPurple,
                  buttonTap: () {
                    Get.toNamed(Routes.createClass);
                  },
                ) else const SizedBox.shrink(),
                const SizedBox(
                  height: 20,
                ),
                HeadingCardView(
                  // ignore: avoid_bool_literals_in_conditional_expressions
                    title: 'Upcoming Classes',
                    onTap: () {},
                    totalItem: _homeController.classUpcomingList.isNotEmpty
                        ? _homeController.classUpcomingList.length.toString()
                        : '',
                    isViewAllIcon:
                    _homeController.classUpcomingList.isNotEmpty
                        ? true
                        : false),
                const SizedBox(
                  height: 10,
                ),
                if (_homeController.classUpcomingList.isNotEmpty)
                  SizedBox(
                  height: 226.px,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                        right: 15, top: 5, bottom: 20, left: 15),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3 ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return AppCardView(
                        proposals: 5,
                        cardTitle:
                        _homeController.classUpcomingList[index].subject,
                        date: _homeController
                            .classUpcomingList[index].classTime!
                            .toString()
                            .epochToNormal(),
                        timer: _homeController.classUpcomingList[index].duration
                            .toString()
                            .timeConvert(),
                        money:
                        "${_homeController.classUpcomingList[index].cost ?? ''} ${_homeController.classUpcomingList[index].currency ?? ''}",
                        status: _homeController.classUpcomingList[index].status,
                        // isPro: true,
                        avtar: ImageConstants.teacherAvtar,
                        countryIcon: ImageConstants.countryIcon,
                        countryName: 'Kuwait',
                        reViewLength: 3,
                        teacherName:
                        _homeController.classUpcomingList[index].name,
                        grade: _homeController.classUpcomingList[index].grade,
                        minParticipants: _homeController
                            .classUpcomingList[index].minParticipants,
                        maxParticipants: _homeController
                            .classUpcomingList[index].maxParticipants,
                        buttonTap: () {
                          Get.toNamed(Routes.classDetailsView,
                              arguments: <String, Object?>{'classNumber': _homeController
                                  .classUpcomingList[index].classNumber,'backIndex':1});
                        },
                      );
                    },
                    separatorBuilder:
                        (BuildContext context, int index) {
                      return const SizedBox(
                        width: 15,
                      );
                    },
                  ),
                ) else InfoCardVIew(
                  isShowButton: true,
                  title: 'No Booked Classes Yet!',
                  subTitle: 'Search about Classes or Create New',
                  cardColor: AppColors.white,
                  buttonTitle: 'Create Class',
                  buttonTap: () {
                    Get.toNamed(Routes.createClass);
                    // AppRouter.pushNamed(Routes.createClass);
                  },
                ),
                // SizedBox(
                //   height: 10.px,
                // ),
                // HeadingCardView(
                //   title: 'Created Classes',
                //   onTap: () {},
                //   totalItem: _homeController.classList.isNotEmpty
                //       ? _homeController.classList.length.toString()
                //       : '',
                //   isViewAllIcon:
                //   _homeController.classList.isNotEmpty ? true : false,
                // ),
                // SizedBox(
                //   height: 10.px,
                // ),
                // if (_homeController.classList.isNotEmpty)
                //   SizedBox(
                //     height: 226.px,
                //     child: ListView.separated(
                //       padding: const EdgeInsets.only(
                //           right: 15, top: 5, bottom: 20, left: 15),
                //       shrinkWrap: true,
                //       physics: const BouncingScrollPhysics(),
                //       itemCount: _homeController.classList.length,
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (BuildContext context, int index) {
                //         return AppCardView(
                //           proposals: 5,
                //           cardTitle:
                //           _homeController.classList[index].subject,
                //           date: _homeController
                //               .classList[index].classTime!
                //               .toString()
                //               .epochToNormal(),
                //           timer: _homeController.classList[index].duration
                //               .toString()
                //               .timeConvert(),
                //           money:
                //           "${_homeController.classList[index].cost ?? ''} ${_homeController.classList[index].currency ?? ''}",
                //           status: _homeController.classList[index].status,
                //           // isPro: true,
                //           avtar: ImageConstants.teacherAvtar,
                //           countryIcon: ImageConstants.countryIcon,
                //           countryName: 'Kuwait',
                //           reViewLength: 3,
                //           teacherName:
                //           _homeController.classList[index].name,
                //           grade: _homeController.classList[index].grade,
                //           minParticipants: _homeController
                //               .classList[index].minParticipants,
                //           maxParticipants: _homeController
                //               .classList[index].maxParticipants,
                //           buttonTap: () {
                //             Get.toNamed(Routes.classDetailsView,
                //                 arguments: <String, Object?>{'classNumber': _homeController
                //                     .classList[index].classNumber,'backIndex':1});
                //           },
                //         );
                //       },
                //       separatorBuilder:
                //           (BuildContext context, int index) {
                //         return const SizedBox(
                //           width: 15,
                //         );
                //       },
                //     ),
                //   ) else
                //   InfoCardVIew(
                //     isShowButton: false,
                //     title: 'No Created Classes Yet!',
                //     subTitle: 'Search about Classes or Create New',
                //     cardColor: AppColors.white,
                //     buttonTitle: '',
                //     buttonTap: () {},
                //   ),
                SizedBox(height: 25.px),
                HeadingCardView(
                  title: 'Related Classes',
                  onTap: () {},
                  totalItem: _homeController.classRelatedList.isNotEmpty
                      ? _homeController.classRelatedList.length.toString()
                      : '',
                  isViewAllIcon:
                  _homeController.classRelatedList.isNotEmpty ? true : false,
                ),
                SizedBox(
                  height: 10.px,
                ),
                if (_homeController.classRelatedList.isNotEmpty)
                  SizedBox(
                  height: 226.px,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                        right: 15, top: 5, bottom: 20, left: 15),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _homeController.classRelatedList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return AppCardView(
                        proposals: 5,
                        cardTitle:
                        _homeController.classRelatedList[index].subject,
                        date: _homeController
                            .classRelatedList[index].classTime!
                            .toString()
                            .epochToNormal(),
                        timer: _homeController.classRelatedList[index].duration
                            .toString()
                            .timeConvert(),
                        money:
                        "${_homeController.classRelatedList[index].cost ?? ''} ${_homeController.classRelatedList[index].currency ?? ''}",
                        status: _homeController.classRelatedList[index].status,
                        // isPro: true,
                        avtar: ImageConstants.teacherAvtar,
                        countryIcon: ImageConstants.countryIcon,
                        countryName: 'Kuwait',
                        reViewLength: 3,
                        teacherName:
                        _homeController.classRelatedList[index].name,
                        grade: _homeController.classRelatedList[index].grade,
                        minParticipants: _homeController
                            .classRelatedList[index].minParticipants,
                        maxParticipants: _homeController
                            .classRelatedList[index].maxParticipants,
                        buttonTap: () {
                          Get.toNamed(Routes.classDetailsView,
                              arguments: <String, Object?>{'classNumber': _homeController
                                  .classRelatedList[index].classNumber,'backIndex':1});
                        },
                      );
                    },
                    separatorBuilder:
                        (BuildContext context, int index) {
                      return const SizedBox(
                        width: 15,
                      );
                    },
                  ),
                ) else
                  InfoCardVIew(
                  isShowButton: false,
                  title: 'No Related Classes Yet!',
                  subTitle: 'Search about Classes or Create New',
                  cardColor: AppColors.white,
                  buttonTitle: '',
                  buttonTap: () {},
                ),
                SizedBox(height: 25.px),
                HeadingCardView(
                  title: 'History',
                  onTap: () {},
                  totalItem: _homeController.classHistoryList.isNotEmpty
                      ? _homeController.classHistoryList.length.toString()
                      : '',
                  isViewAllIcon: _homeController.classHistoryList.isNotEmpty
                      ? true
                      : false,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (_homeController.classHistoryList.isNotEmpty) SizedBox(
                  height: 226.px,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                        right: 15, top: 5, bottom: 20, left: 15),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _homeController.classHistoryList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return  AppCardView(
                        proposals: 5,
                        cardTitle:
                        _homeController.classHistoryList[index].subject,
                        date: _homeController
                            .classHistoryList[index].classTime!
                            .toString()
                            .epochToNormal(),
                        timer: _homeController.classHistoryList[index].duration
                            .toString()
                            .timeConvert(),
                        money:
                        "${_homeController.classHistoryList[index].cost ?? ''} ${_homeController.classHistoryList[index].currency ?? ''}",
                        status: _homeController.classHistoryList[index].status,
                        // isPro: true,
                        avtar: ImageConstants.teacherAvtar,
                        countryIcon: ImageConstants.countryIcon,
                        countryName: 'Kuwait',
                        reViewLength: 3,
                        teacherName:
                        _homeController.classHistoryList[index].name,
                        grade: _homeController.classHistoryList[index].grade,
                        minParticipants: _homeController
                            .classHistoryList[index].minParticipants,
                        maxParticipants: _homeController
                            .classHistoryList[index].maxParticipants,
                        buttonTap: () {
                          Get.toNamed(Routes.classDetailsView,
                              arguments: <String, Object?>{'classNumber': _homeController
                                  .classHistoryList[index].classNumber,'backIndex':1});
                        },
                      );
                    },
                    separatorBuilder:
                        (BuildContext context, int index) {
                      return const SizedBox(
                        width: 15,
                      );
                    },
                  ),
                ) else InfoCardVIew(
                  isShowButton: false,
                  title: 'No History Classes Found!',
                  subTitle: 'Search about history Classes ',
                  cardColor: AppColors.white,
                  buttonTitle: '',
                  buttonTap: () {},
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 200,
                )
              ],
            ),
          )
        );
  }
}
