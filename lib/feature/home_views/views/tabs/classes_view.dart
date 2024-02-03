// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/route.dart';
import '../../../../core/api_end_points.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/cardView/app_card_view.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../custom/cardView/info_card_view_horizontal.dart';
import '../../../../custom/choice/src/modal/button.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/extension/context_extension.dart';
import '../../../../product/extension/string_extension.dart';
import '../../../../product/utils/typography.dart';
import '../../../class/class_detail/controller/class_detail_controller.dart';
import '../../../classDetails/controller/class_details_controller.dart';
import '../../../classDetails/view/bottomSheetView/booking_bottom_view.dart';
import '../../../home/controller/home_controller.dart';

import '../../../setting_view/add_address_screen/Model/request_address_model.dart';
import '../../../setting_view/manage_address/Model/get_address_model.dart'
    hide Location;
import '../../../setting_view/manage_address/controller/manage_controller.dart';
import '../../../tutorial/language/controller/language_controller.dart';
import '../../../tutorial/language/model/country_model.dart';

class ClassesView extends StatefulWidget {
  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  String selectedProfile = '';
  bool isPending = false;
  final HomeController _homeController = Get.find();
  final LanguageController _languageController = Get.find();

  // final ClassDetailsController _classDetailsController =
  // Get.put(ClassDetailsController());
  final ManageAddressController _manageAddressController =
      Get.put(ManageAddressController());
  final ClassDetailController _classDetailController =
      Get.put(ClassDetailController());
  final ClassDetailsController _classDetailsController =
  Get.put(ClassDetailsController());

  @override
  void initState() {
    selectedProfile = LocaleManager.getValue(StorageKeys.profile) ?? '';
    _manageAddressController.fetchAddressData();
    super.initState();
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
    return Obx(() => _homeController.classRelatedList.isEmpty &&
            _homeController.classUpcomingList.isEmpty &&
            _homeController.classHistoryList.isEmpty
        ? Padding(
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
          )
        : Expanded(
            child: ListView(
              children: <Widget>[
                if (_homeController.classUpcomingList.isNotEmpty)
                  InfoCardViewHorizontal(
                    isClassScreen: true,
                    isShowButton: true,
                    title:
                        'Create new class and receive proposals from teachers',
                    cardColor: AppColors.lightPurple,
                    buttonTap: () {
                      Get.toNamed(Routes.createClass);
                    },
                  )
                else
                  const SizedBox.shrink(),
                const SizedBox(
                  height: 20,
                ),
                HeadingCardView(
                    // ignore: avoid_bool_literals_in_conditional_expressions
                    title: 'Upcoming Classes',
                    onTap: () => Get.toNamed(Routes.viewAllClass,
                            arguments: <String, Object?>{
                              'title': 'Upcoming Classes',
                              'type': SchoolEndpoint.UPCOMING_CLASS
                            }),
                    totalItem: _homeController.classUpcomingList.isNotEmpty
                        ? _homeController.classUpcomingList.length.toString()
                        : '',
                    isViewAllIcon: _homeController.classUpcomingList.isNotEmpty
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
                      itemCount: _homeController.classUpcomingList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 340.px,
                          child: AppCardView(
                            proposals: 5,
                            cardTitle: _homeController
                                .classUpcomingList[index].subject,
                            date: _homeController
                                .classUpcomingList[index].classTime!
                                .toString()
                                .epochToNormal(),
                            timer: _homeController
                                .classUpcomingList[index].duration
                                .toString()
                                .timeConvert(),
                            money:
                                "${_homeController.classUpcomingList[index].cost ?? ''} ${_homeController.classUpcomingList[index].currency ?? ''}",
                            status:
                                _homeController.classUpcomingList[index].status,
                            // isPro: true,
                            avtar: _homeController
                                .classUpcomingList[index].imageId
                                ?.getImageUrl('profile'),
                            countryIcon: _homeController
                                            .classUpcomingList[index].country !=
                                        null &&
                                    _languageController.countries.isNotEmpty
                                ? _languageController.countries
                                    .firstWhere((Country element) =>
                                        element.name ==
                                        _homeController
                                            .classUpcomingList[index].country)
                                    .flag_url
                                : ImageConstants.countryIcon,
                            countryName: _homeController
                                .classUpcomingList[index].country,
                            reViewLength: 3,
                            teacherName:
                                _homeController.classUpcomingList[index].name,
                            grade:
                                _homeController.classUpcomingList[index].grade,
                            minParticipants: _homeController
                                .classUpcomingList[index].minParticipants,
                            maxParticipants: _homeController
                                .classUpcomingList[index].maxParticipants,
                            buttonTap: () {
                              Get.toNamed(Routes.classDetailsView,
                                  arguments: <String, Object?>{
                                    'classNumber': _homeController
                                        .classUpcomingList[index].classNumber,
                                    'backIndex': 1
                                  });
                            },
                            isBook: false,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                    ),
                  )
                else
                  InfoCardVIew(
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
                  onTap: () => Get.toNamed(Routes.viewAllClass,
                      arguments: <String, Object?>{
                        'title': 'Related Classes',
                        'type': SchoolEndpoint.RELATED_CLASS
                      }),
                  totalItem: _homeController.classRelatedList.isNotEmpty
                      ? _homeController.classRelatedList.length.toString()
                      : '',
                  isViewAllIcon: _homeController.classRelatedList.isNotEmpty
                      ? true
                      : false,
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
                        return SizedBox(
                          width: 340.px,
                          child: AppCardView(
                            proposals: 5,
                            cardTap: () {
                              Get.toNamed(Routes.classDetailsView,
                                  arguments: <String, Object?>{
                                    'classNumber': _homeController
                                        .classRelatedList[index].classNumber,
                                    'backIndex': 1
                                  });
                            },
                            title:
                                selectedProfile == ApplicationConstants.tutor
                                    ? 'Propose'
                                    : 'Book',
                            cardTitle: _homeController
                                .classRelatedList[index].subject,
                            date: _homeController
                                .classRelatedList[index].classTime!
                                .toString()
                                .epochToNormal(),
                            timer: _homeController
                                .classRelatedList[index].duration
                                .toString()
                                .timeConvert(),
                            money:
                                "${_homeController.classRelatedList[index].cost ?? ''} ${_homeController.classRelatedList[index].currency ?? ''}",
                            status: _homeController
                                .classRelatedList[index].status,
                            // isPro: true,
                            avtar: _homeController
                                .classRelatedList[index].imageId
                                ?.getImageUrl('profile'),
                            countryIcon: _homeController
                                            .classRelatedList[index]
                                            .country !=
                                        null &&
                                    _languageController.countries.isNotEmpty
                                ? _languageController.countries
                                    .firstWhere((Country element) =>
                                        element.name ==
                                        _homeController
                                            .classRelatedList[index].country)
                                    .flag_url
                                : ImageConstants.countryIcon,
                            countryName: _homeController
                                .classRelatedList[index].country,
                            reViewLength: 3,
                            teacherName:
                                _homeController.classRelatedList[index].name,
                            grade:
                                _homeController.classRelatedList[index].grade,
                            minParticipants: _homeController
                                .classRelatedList[index].minParticipants,
                            maxParticipants: _homeController
                                .classRelatedList[index].maxParticipants,
                            buttonTap: selectedProfile == ApplicationConstants.student?() async {

                                if (_homeController.classRelatedList[index]
                                        .maxParticipants! >
                                    1) {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled:true,
                                    constraints: BoxConstraints(
                                      maxHeight: (MediaQuery.of(context).size.height * 0.95.px -
                                          20).px,
                                      maxWidth:
                                          // ignore: use_build_context_synchronously
                                          (MediaQuery.of(context).size.width -
                                                  30)
                                              .px,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.px),
                                    ),
                                    builder: (BuildContext context) {
                                      _classDetailsController.classId=_homeController
                                          .classRelatedList[index]
                                          .classNumber!;
                                      _classDetailsController.getClassDetails(_homeController
                                          .classRelatedList[index]
                                          .classNumber!);
                                      return BookingBottomSheet();
                                    },
                                  );
                                } else if (_homeController.classRelatedList[index]
                                    .allowAtStudentLoc ==
                                    0){
                                  _classDetailsController.classId=_homeController
                                      .classRelatedList[index]
                                      .classNumber!;
                                  final bool status = await _classDetailsController
                                      .bookClassDetail(
                                          {});
                                  if (status) {
                                    // ignore: use_build_context_synchronously
                                    showModalBottomSheet(
                                      context: context,
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            // ignore: use_build_context_synchronously
                                            (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    30)
                                                .px,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.px),
                                      ),
                                      builder: (BuildContext context) {
                                        return SuccessFailsInfoDialog(
                                          title: 'Success',
                                          buttonTitle: 'Done',
                                          content:
                                              'You have successfully booked your class, and you will get notification to pay after the teacher accept the class.',
                                          // isRouting: 'back',
                                        );
                                      },
                                    );
                                  }
                                }
                               else {
                                locationModalBottomSheet(context, index);
                              }
                            }:(){},
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                    ),
                  )
                else
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
                  onTap: () => Get.toNamed(Routes.viewAllClass,
                      arguments: <String, Object?>{
                        'title': 'History',
                        'type': SchoolEndpoint.HISTORY_CLASS
                      }),
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
                if (_homeController.classHistoryList.isNotEmpty)
                  SizedBox(
                    height: 226.px,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(
                          right: 15, top: 5, bottom: 20, left: 15),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _homeController.classHistoryList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 340.px,
                          child: AppCardView(
                            proposals: 5,
                            isBook: false,
                            cardTitle:
                                _homeController.classHistoryList[index].subject,
                            date: _homeController
                                .classHistoryList[index].classTime!
                                .toString()
                                .epochToNormal(),
                            timer: _homeController
                                .classHistoryList[index].duration
                                .toString()
                                .timeConvert(),
                            money:
                                "${_homeController.classHistoryList[index].cost ?? ''} ${_homeController.classHistoryList[index].currency ?? ''}",
                            status:
                                _homeController.classHistoryList[index].status,
                            // isPro: true,
                            avtar: _homeController
                                .classHistoryList[index].imageId
                                ?.getImageUrl('profile'),
                            countryIcon: _homeController
                                            .classHistoryList[index].country !=
                                        null &&
                                    _languageController.countries.isNotEmpty
                                ? _languageController.countries
                                    .firstWhere((Country element) =>
                                        element.name ==
                                        _homeController
                                            .classHistoryList[index].country)
                                    .flag_url
                                : ImageConstants.countryIcon,
                            countryName:
                                _homeController.classHistoryList[index].country,
                            reViewLength: 3,
                            teacherName:
                                _homeController.classHistoryList[index].name,
                            grade:
                                _homeController.classHistoryList[index].grade,
                            minParticipants: _homeController
                                .classHistoryList[index].minParticipants,
                            maxParticipants: _homeController
                                .classHistoryList[index].maxParticipants,
                            buttonTap: () {
                              Get.toNamed(Routes.classDetailsView,
                                  arguments: <String, Object?>{
                                    'classNumber': _homeController
                                        .classHistoryList[index].classNumber,
                                    'backIndex': 1
                                  });
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                    ),
                  )
                else
                  InfoCardVIew(
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
          ));
  }


  void locationModalBottomSheet(context, index) {
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
                      Text('Select class location', style: openSans.get20.w700),
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            if (_homeController
                                    .classRelatedList[index].maxParticipants !=
                                1) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled:true,
                                constraints: BoxConstraints(
                                  maxHeight: (MediaQuery.of(context).size.height * 0.95.px -
                                      20).px,
                                  maxWidth:
                                      // ignore: use_build_context_synchronously
                                      (MediaQuery.of(context).size.width)
                                          .px,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.px),
                                ),
                                builder: (BuildContext context) {
                                  _classDetailsController.classId=_homeController
                                      .classRelatedList[index]
                                      .classNumber!;
                                  _classDetailsController.getClassDetails(_homeController
                                      .classRelatedList[index]
                                      .classNumber!);
                                  // Get.back();
                                  return BookingBottomSheet();
                                },
                              );
                            } else {
                              _classDetailsController.classId=_homeController
                                  .classRelatedList[index]
                                  .classNumber!;
                              final bool status = await _classDetailsController
                                  .bookClassDetail(
                                  {});
                              if (status) {
                                // ignore: use_build_context_synchronously
                                showModalBottomSheet(
                                  context: context,
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        // ignore: use_build_context_synchronously
                                        (MediaQuery.of(context).size.width - 30)
                                            .px,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.px),
                                  ),
                                  builder: (BuildContext context) {
                                    return SuccessFailsInfoDialog(
                                      title: 'Success',
                                      buttonTitle: 'Done',
                                      content:
                                          'You have successfully booked your class, and you will get notification to pay after the teacher accept the class.',
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.gray.withOpacity(0.25),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(15),
                              child: const Text(
                                'Keep at the teacher location',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              )),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _manageAddressController.address.length,
                          itemBuilder: (BuildContext context, int index) {
                            final UserAddress data =
                                _manageAddressController.address[index];
                            return listData(index, data, setState);
                          }),
                    ],
                  ),
                ),
              ),
              Obx(
                () => AppButton(
                  onPressed: () async {
                    _classDetailsController.classId=_homeController
                        .classRelatedList[index]
                        .classNumber!;
                    final bool status = await _classDetailsController
                        .bookClassDetail(
                        {
                          'location': _manageAddressController
                              .address[_classDetailController.selectedIndex.value]
                              .id
                        });
                    if (status) {
                      // ignore: use_build_context_synchronously
                      showModalBottomSheet(
                        context: context,
                        constraints: BoxConstraints(
                          maxWidth:
                              // ignore: use_build_context_synchronously
                              (MediaQuery.of(context).size.width - 30).px,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.px),
                        ),
                        builder: (BuildContext context) {
                          return SuccessFailsInfoDialog(
                            title: 'Success',
                            buttonTitle: 'Done',
                            content:
                                'You have successfully booked your class, and you will get notification to pay after the teacher accept the class.',
                          );
                        },
                      );
                    }
                  },
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  isDisable: _classDetailController.selectedIndex.value != 200
                      ? false
                      : true,
                  title: 'select'.tr,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                    onPressed: () {
                      final Map<String, dynamic> titleData = {
                        'title': 'Add New Addresses',
                      };
                      Get.toNamed(Routes.addAddressView, arguments: titleData);
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

  Widget listData(int index, UserAddress data, StateSetter setState) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: _classDetailController.selectedIndex.value == index
                      ? AppColors.appBlue
                      : AppColors.gray.withOpacity(0.25),
                ),
                borderRadius: BorderRadius.circular(10)),
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
                            if (data.isDefault == 1)
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
                        GestureDetector(
                            onTap: () {
                              _classDetailController.selectedIndex.value =
                                  index;
                            },
                            child: _classDetailController.selectedIndex.value ==
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
                                  )))
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
                          onTap: () async {
                            if (data.isDefault == 1) {
                              AppUtils.showFlushBar(
                                context: Routes.navigatorKey.currentContext!,
                                message: 'Can not delete default address',
                              );
                            } else {
                              await _manageAddressController
                                  .deleteAddressData(data.id!);
                              if (_classDetailController.selectedIndex.value ==
                                  index) {
                                _classDetailController.selectedIndex.value =
                                    200;
                              }
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
                            var arguments = {
                              'title': 'Update Address',
                              'userData': data
                            };
                            Get.toNamed(Routes.addAddressView,
                                arguments: arguments);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10,
                                right: _classDetailController
                                            .selectedIndex.value !=
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
          ),
        ));
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
}
