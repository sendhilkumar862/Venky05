// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
import '../reupload_documents.dart';

class ClassesView extends StatefulWidget {
  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  String selectedProfile = '';
  String selectedUserStatus = '';

  bool isPending = false;
  final HomeController _homeController = Get.find();

  @override
  void initState() {
    super.initState();
    selectedProfile = LocaleManager.getValue(StorageKeys.profile) ?? '';
  }

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
    return Obx(() => _homeController.isCreatedClass.value
        ? Expanded(
            child: ListView(
              children: <Widget>[
                Obx(
                  () => _homeController.upComingClassList.isNotEmpty
                      ? InfoCardViewHorizontal(
                          isClassScreen: true,
                          isShowButton: true,
                          title:
                              'Create new class and receive proposals from teachers',
                          cardColor: AppColors.lightPurple,
                          buttonTap: () {
                            Get.toNamed(Routes.createClass);
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => HeadingCardView(
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      title: 'Upcoming Classes',
                      onTap: () {},
                      totalItem: _homeController.upComingClassList.isNotEmpty
                          ? _homeController.upComingClassList.length.toString()
                          : '',
                      isViewAllIcon:
                          _homeController.upComingClassList.isNotEmpty
                              ? true
                              : false),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => _homeController.upComingClassList.isNotEmpty
                      ? SizedBox(
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
                                cardTitle: 'Math',
                                date: '12/12 12:30pm',
                                timer: '1h 30m',
                                money: '5.500 KWD',
                                status: 'Pending',
                                isPro: true,
                                grade: 'Grade1',
                                avtar: ImageConstants.teacherAvtar,
                                countryIcon: ImageConstants.countryIcon,
                                countryName: 'Kuwait',
                                reViewLength:
                                    _homeController.upComingClassList.length,
                                teacherName: 'Ahmed Ali',
                                buttonTap: () {},
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: 15,
                              );
                            },
                          ),
                        )
                      : InfoCardVIew(
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
                ),
                SizedBox(
                  height: 10.px,
                ),
                Obx(
                  () => HeadingCardView(
                    title: 'Related Classes',
                    onTap: () {},
                    totalItem: _homeController.classList.isNotEmpty
                        ? _homeController.classList.length.toString()
                        : '',
                    isViewAllIcon:
                        _homeController.classList.isNotEmpty ? true : false,
                  ),
                ),
                SizedBox(
                  height: 10.px,
                ),
                Obx(
                  () => _homeController.classList.isNotEmpty
                      ? SizedBox(
                          height: 226.px,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(
                                right: 15, top: 5, bottom: 20, left: 15),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _homeController.classList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return AppCardView(
                                proposals: 5,
                                cardTitle:
                                    _homeController.classList[index].subject,
                                date: _homeController
                                    .classList[index].classTime!
                                    .toString()
                                    .epochToNormal(),
                                timer: _homeController.classList[index].duration
                                    .toString()
                                    .timeConvert(),
                                money:
                                    "${_homeController.classList[index].cost ?? ''} ${_homeController.classList[index].currency ?? ''}",
                                status: _homeController.classList[index].status,
                                // isPro: true,
                                avtar: ImageConstants.teacherAvtar,
                                countryIcon: ImageConstants.countryIcon,
                                countryName: 'Kuwait',
                                reViewLength: 3,
                                teacherName:
                                    _homeController.classList[index].name,
                                grade: _homeController.classList[index].grade,
                                minParticipants: _homeController
                                    .classList[index].minParticipants,
                                maxParticipants: _homeController
                                    .classList[index].maxParticipants,
                                buttonTap: () {
                                  Get.toNamed(Routes.classDetailsView,
                                      arguments: _homeController
                                          .classList[index].classNumber);
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
                        )
                      : InfoCardVIew(
                          isShowButton: false,
                          title: 'No Related Classes Yet!',
                          subTitle: 'Search about Classes or Create New',
                          cardColor: AppColors.white,
                          buttonTitle: '',
                          buttonTap: () {},
                        ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(height: 20.px),
                Obx(
                  () => HeadingCardView(
                    title: 'History',
                    onTap: () {},
                    totalItem: _homeController.historyClassList.isNotEmpty
                        ? _homeController.historyClassList.length.toString()
                        : '',
                    isViewAllIcon: _homeController.historyClassList.isNotEmpty
                        ? true
                        : false,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => _homeController.historyClassList.isNotEmpty
                      ? SizedBox(
                          height: 226.px,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(
                                right: 15, top: 5, bottom: 20, left: 15),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _homeController.historyClassList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return AppCardView(
                                proposals: 5,
                                cardTitle: 'Math',
                                date: '12/12 12:30pm',
                                timer: '1h 30m',
                                money: '5.500 KWD',
                                status: 'COMPLETED',
                                isPro: true,
                                avtar: ImageConstants.teacherAvtar,
                                countryIcon: ImageConstants.countryIcon,
                                countryName: 'Kuwait',
                                grade: 'Grade3',
                                reViewLength: 3,
                                teacherName: 'Ahmed Ali',
                                buttonTap: () {},
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: 15,
                              );
                            },
                          ),
                        )
                      : InfoCardVIew(
                          isShowButton: false,
                          title: 'No History Classes Found!',
                          subTitle: 'Search about history Classes ',
                          cardColor: AppColors.white,
                          buttonTitle: '',
                          buttonTap: () {},
                        ),
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
        : Padding(
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
          ));
  }
}
