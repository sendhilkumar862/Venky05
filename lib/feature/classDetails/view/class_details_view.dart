import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../config/routes/route.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/details_card_view.dart';
import '../../../custom/cardView/details_card_view_horizontal.dart';
import '../../../custom/cardView/heading_card_view.dart';
import '../../../custom/cardView/status_card_view.dart';
import '../../../custom/choice/src/modal/button.dart';
import '../../../custom/dialog/success_fail_dialog.dart';
import '../../../custom/dialog/warning_dialog.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/app/app_enums.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/context_extension.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/utils/typography.dart';
import '../../class/class_detail/controller/class_detail_controller.dart';
import '../../home/controller/home_controller.dart';
import '../../proposal/create_proposal/controller/create_proposal_controller.dart';
import '../../proposal/proposals_by/controller/proposals_by_controller.dart';
import '../../proposal/proposals_by/view/proposals_by.dart';
import '../../setting_view/add_address_screen/Model/request_address_model.dart';
import '../../setting_view/manage_address/Model/get_address_model.dart'
    hide Location;
import '../../setting_view/manage_address/controller/manage_controller.dart';
import '../controller/class_details_controller.dart';
import 'bottomSheetView/booking_bottom_view.dart';
import 'bottomSheetView/student_bottom_view.dart';

class ClassDetailsView extends StatefulWidget {
  const ClassDetailsView({super.key});

  @override
  State<ClassDetailsView> createState() => _ClassDetailsViewState();
}

class _ClassDetailsViewState extends State<ClassDetailsView>
    with TickerProviderStateMixin {
  final ClassDetailsController _classDetailsController =
      Get.put(ClassDetailsController());
  final ProposalsByController _proposalsByController =
      Get.put(ProposalsByController());
  final ManageAddressController _manageAddressController =
      Get.put(ManageAddressController());
  final ClassDetailController _classDetailController =
      Get.put(ClassDetailController());
  final HomeController _homeController = Get.find();

  @override
  void initState() {
    super.initState();
    _manageAddressController.fetchAddressData();
    _classDetailsController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.appWhite,
        appBar: HessaAppBar(
            title: 'Class Details',
            isTitleOnly: true,
            leadingTap: () {
              // ignore: avoid_dynamic_calls
              Get.close(Get.arguments['backIndex']);
            }),
        body: Obx(
          () => ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 5.px),
            children: <Widget>[
              getOwnerView(),
              getClassInfoView(),
              getCurriculumView(),
              getStudentDetails(),
              getHeadingViewForTeachers(),
              getHeadingViewForStudents(),
              getHeadingViewForProposals(),
              getDetailViewForTeachers(),
              getDetailViewForStudents(),
              getDetailViewForProposals(),
              getClassDetails(),
              getProposalDetails(),
              getAddressText(),
              getScheduledDetails(),
              getRescheduleOption(),
              addRatingOption(),
              confirmStudentAttendance(),
              getEditProposalOption(),
              getBookNowOption(),
              getSubmitProposalOption(),
              getApproveScheduleOption(),
              getPaymentOption(),
              getCancelClassOption(),
              getWithdrawProposalOption(),
              getApproveRejectClassOption(),
              getRejectScheduleOption(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getClassInfoView() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.px,
          ),
          AppText(
            _classDetailsController.classData.value.subject ?? '',
            fontSize: 20.px,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(
            height: 10.px,
          ),
          AppText(
            _classDetailsController.classData.value.description ?? '',
            fontWeight: FontWeight.w400,
            fontSize: 14.px,
          ),
          SizedBox(
            height: 20.px,
          ),
        ]);
  }

  Widget getStudentDetails() {
    return _classDetailsController.classData.value.studentDetails != null
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: HeadingCardView(padding: 0, title: 'Created By'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: DetailsCardViewHorizontal(
                  onTap: () async {
                    if (_classDetailsController
                            .classData.value.studentDetails?.isBookmarked !=
                        null) {
                      _classDetailsController.classData.value.studentDetails
                                  ?.isBookmarked ==
                              1
                          ? await _homeController.deleteFavouriteInfo(
                              _classDetailsController
                                  .classData.value.studentDetails!.userId!
                                  .toString(),
                              screenName: 'DetailsScreen',
                              classId: _classDetailsController.classId)
                          : await _homeController.addFavouriteInfo(
                              _classDetailsController
                                  .classData.value.studentDetails!.userId!
                                  .toString(),
                              screenName: 'DetailsScreen',
                              classId: _classDetailsController.classId);
                    }
                  },
                  heading: 'Created By',
                  name: _classDetailsController
                          .classData.value.studentDetails?.name ??
                      '',
                  height: 95.px,
                  avatar: _classDetailsController
                      .classData.value.studentDetails?.imageId,
                  countryName:
                      'Grade ${_classDetailsController.classData.value.studentDetails?.grade?.join('-')}',
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  isPro: false,
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  isBookmarked: _classDetailsController
                              .classData.value.studentDetails?.isBookmarked ==
                          1
                      ? true
                      : false,
                    role: _classDetailsController.classData.value.role,
                    reViewLength: _classDetailsController.classData.value.teacherDetails?.rating??0,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget getCurriculumView() {
    return Column(
      children: <Widget>[
        HeadingCardView(
          // ignore: unrelated_type_equality_checks
          title: _classDetailsController.selectedProfile ==
                  ApplicationConstants.student
              ? 'Curriculum'
              : 'Class Info',
          padding: 0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              curriculumWidget(
                  heading: 'Grade',
                  detail: _classDetailsController.classData.value.grade ?? ''),
              curriculumWidget(
                  heading: 'School',
                  detail: _classDetailsController.classData.value.school ?? ''),
              curriculumWidget(
                  heading: 'Curriculum',
                  detail:
                      _classDetailsController.classData.value.curriculum ?? ''),
              curriculumWidget(
                  heading: 'Class Number',
                  detail:
                      _classDetailsController.classData.value.displayId ?? '')
            ],
          ),
        ),
      ],
    );
  }

  Widget getHeadingViewForTeachers() {
    return _classDetailsController.classData.value.teacherDetails != null
        ? HeadingCardView(padding: 0, title: 'Teacher')
        : const SizedBox.shrink();
  }

  Widget getHeadingViewForStudents() {
    return _classDetailsController.classData.value.students != null
        ? HeadingCardView(
            padding: 0,
            title: 'Students',
            totalItem: _classDetailsController.classData.value.students!.length
                .toString(),
            onTap: () async {
              await _classDetailsController.getStudentAllAtDetails(
                  _classDetailsController.classId,
                  _classDetailsController.startIndex);
              // ignore: use_build_context_synchronously
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                builder: (BuildContext context) {
                  // ignore: avoid_dynamic_calls
                  return StudentBottomSheet(
                      classId: _classDetailsController.classId);
                },
              );
            },
            // ignore: avoid_bool_literals_in_conditional_expressions
            isViewAllIcon:
                // ignore: avoid_bool_literals_in_conditional_expressions
                _classDetailsController.classData.value.students!.isNotEmpty
                    ? true
                    : false)
        : const SizedBox.shrink();
  }

  Widget getHeadingViewForProposals() {
    return _classDetailsController.classData.value.proposals != null
        ? HeadingCardView(
            padding: 0,
            title: 'Proposals',
            totalItem: _classDetailsController.classData.value.proposals!.length
                .toString(),
            onTap: () async {
              await _classDetailsController.getProposalDetails(
                  _classDetailsController.classId,
                  _classDetailsController.startIndex);
              // ignore: use_build_context_synchronously
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                builder: (BuildContext context) {
                  // ignore: avoid_dynamic_calls
                  return ProposalsBy(
                    classId: _classDetailsController.classId,
                  );
                },
              );
            },
            // ignore: avoid_bool_literals_in_conditional_expressions
            isViewAllIcon:
                // ignore: avoid_bool_literals_in_conditional_expressions
                _classDetailsController.classData.value.proposals!.isNotEmpty
                    ? true
                    : false)
        : const SizedBox.shrink();
  }

  Widget getDetailViewForTeachers() {
    return _classDetailsController.classData.value.teacherDetails != null
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: DetailsCardViewHorizontal(
              onTap: () async {
                if (_classDetailsController
                        .classData.value.teacherDetails?.isBookmarked !=
                    null) {
                  _classDetailsController
                              .classData.value.teacherDetails?.isBookmarked ==
                          1
                      ? await _homeController.deleteFavouriteInfo(
                          _classDetailsController
                              .classData.value.teacherDetails!.userId!
                              .toString(),
                          screenName: 'DetailsScreen',
                          classId: _classDetailsController.classId)
                      : await _homeController.addFavouriteInfo(
                          _classDetailsController
                              .classData.value.teacherDetails!.userId!
                              .toString(),
                          screenName: 'DetailsScreen',
                          classId: _classDetailsController.classId);
                }
              },
              heading: 'Teacher',
              name: _classDetailsController
                      .classData.value.teacherDetails?.name ??
                  '',
              height: 105.px,
              avatar: _classDetailsController
                  .classData.value.teacherDetails?.imageId,
              countryName: 'Grade ',
              // ignore: avoid_bool_literals_in_conditional_expressions
              isPro: _classDetailsController
                          .classData.value.teacherDetails?.subscription ==
                      'Free'
                  ? false
                  : true,
              // ignore: avoid_bool_literals_in_conditional_expressions
              isBookmarked: _classDetailsController
                          .classData.value.teacherDetails?.isBookmarked ==
                      1
                  ? true
                  : false,
                   role: UserRole.tutor,
                    reViewLength: _classDetailsController.classData.value.teacherDetails?.rating??0,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget getDetailViewForProposals() {
    return _classDetailsController.classData.value.proposals != null
        ? _classDetailsController.classData.value.proposals!.isNotEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.300,
                child: ListView.builder(
                  itemCount:
                      _classDetailsController.classData.value.proposals!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: !(_classDetailsController.classData.value.canPay ??
                              false)
                          ? () async {
                              _proposalsByController.getProposalDetails(
                                  _classDetailsController.classData.value
                                          .proposals![index].proposalId ??
                                      '',
                                  _classDetailsController.classId);
                              _classDetailsController.proposalId =
                                  _classDetailsController.classData.value
                                          .proposals![index].proposalId ??
                                      '';
                              proposalByTeacherBottomSheet(index);
                            }
                          : () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                constraints: const BoxConstraints(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25.px),
                                    topLeft: Radius.circular(25.px),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return BookingBottomSheet(
                                    isBook: 'Pay',
                                    isRouting: 'home',
                                  );
                                },
                              );
                            },
                      child: DetailsCardView(
                          cardMargin: EdgeInsets.only(
                              right: 15.px, top: 10.px, bottom: 27.px),
                          reViewLength: _classDetailsController
                              .classData.value.proposals![index].rating,
                          onTap: () async {
                            if (_classDetailsController.classData.value
                                    .proposals![index].isBookmarked !=
                                null) {
                              _classDetailsController.classData.value
                                          .proposals![index].isBookmarked ==
                                      1
                                  ? await _homeController.deleteFavouriteInfo(
                                      _classDetailsController.classData.value
                                          .proposals![index].userId!
                                          .toString(),
                                      screenName: 'DetailsScreen',
                                      classId: _classDetailsController.classId)
                                  : await _homeController.addFavouriteInfo(
                                      _classDetailsController.classData.value
                                          .proposals![index].userId!
                                          .toString(),
                                      screenName: 'DetailsScreen',
                                      classId: _classDetailsController.classId);
                            }
                          },
                          name: _classDetailsController
                                  .classData.value.proposals![index].name ??
                              '',
                          avatar: _classDetailsController
                              .classData.value.proposals![index].imageId,
                          countryIcon: _classDetailsController
                              .classData.value.proposals![index].flagUrl,
                          countryName: _classDetailsController
                              .classData.value.proposals![index].country,
                          // ignore: avoid_bool_literals_in_conditional_expressions
                          isPro: _classDetailsController.classData.value
                                      .proposals![index].subscription ==
                                  'Free'
                              ? false
                              : true,
                          // ignore: avoid_bool_literals_in_conditional_expressions
                          isBookmarked: _classDetailsController.classData.value
                                      .proposals![index].isBookmarked ==
                                  1
                              ? true
                              : false,
                          subjects:
                              '${_classDetailsController.classData.value.proposals![index].cost} ${_classDetailsController.classData.value.proposals![index].currency} per Session'),
                    );
                  },
                ),
              )
            : AppButton(
                height: 60.px,
                title: 'No Proposals found',
                textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 18.px,
                    fontWeight: FontWeight.w600),
                borderRadius: BorderRadius.circular(12.px),
                borderColor: AppColors.appLightGrey,
                isBorderOnly: true,
                onPressed: () {},
              )
        : const SizedBox.shrink();
  }

  Widget getDetailViewForStudents() {
    return _classDetailsController.classData.value.students != null
        ? _classDetailsController.classData.value.students!.isEmpty
            ? AppButton(
                height: 60.px,
                title: 'No Students found',
                textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 18.px,
                    fontWeight: FontWeight.w600),
                borderRadius: BorderRadius.circular(12.px),
                borderColor: AppColors.appLightGrey,
                isBorderOnly: true,
                onPressed: () {},
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.115,
                  child: ListView.builder(
                    itemCount: _classDetailsController
                        .classData.value.students!.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.appProfile,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0,
                                        2), // changes the position of the shadow
                                  ),
                                ],
                              ),
                              width: 55.px,
                              height: 55.px,
                              child: ClipOval(
                                child: _classDetailsController.classData.value
                                            .students![index].imageId ==
                                        null
                                    ? Center(
                                        child: Text(
                                            _classDetailsController.classData
                                                .value.students![index].name!
                                                .extractInitials(),
                                            style: openSans.get20.w700.white))
                                    : AppImageAsset(
                                        image: _classDetailsController.classData
                                            .value.students![index].imageId!,
                                        height: 40.px,
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 6.px,
                            ),
                            AppText(
                              _classDetailsController
                                      .classData.value.students![index].name ??
                                  '',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.px,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
        : const SizedBox.shrink();
  }

  Widget getClassDetails() {
    return Container(
      padding: context.paddingNormal,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.px),
        color: AppColors.lightestPurple,
        border: Border.all(color: AppColors.lightestPurple, width: 1.1.px),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppText(
                'Class Details',
                fontWeight: FontWeight.w800,
                fontSize: 16.px,
              ),
              const Spacer(),
              StatusCardView(
                  status: _classDetailsController.classData.value.status),
            ],
          ),
          SizedBox(height: 15.px),
          Row(
            children: <Widget>[
              tagCardView(
                  title: _classDetailsController
                              .classData.value.maxParticipants ==
                          1
                      ? 'Individual'
                      : 'Group ${_classDetailsController.classData.value.minParticipants}/${_classDetailsController.classData.value.maxParticipants}',
                  icon:
                      _classDetailsController.classData.value.maxParticipants ==
                              1
                          ? ImageConstants.individualIcon
                          : ImageConstants.groupIcon),
              tagCardView(
                  title: _classDetailsController.classData.value.classTime
                      ?.toString()
                      .epochToNormal(),
                  icon: ImageConstants.dateIcon),
              tagCardView(
                  title: _classDetailsController.classData.value.duration
                      ?.toString()
                      .timeConvert(),
                  icon: ImageConstants.timerIcon),
            ],
          ),
          Row(
            children: <Widget>[
              tagCardView(
                  title:
                      '${_classDetailsController.classData.value.cost} ${_classDetailsController.classData.value.currency} per Session',
                  icon: ImageConstants.moneyIcon),
              tagCardView(
                  title:
                      'Session ${sessions()} of ${_classDetailsController.classData.value.sessions}',
                  icon: ImageConstants.readBookIcon),
            ],
          ),
          SizedBox(height: 5.px),
          Row(
            children: <Widget>[
              AppImageAsset(
                image: ImageConstants.pinLocation,
                height: 20.px,
              ),
              SizedBox(
                width: 260.px,
                child: AppText(
                  _classDetailsController.classData.value.address ?? '',
                  fontSize: 10.px,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 15.px),
          Obx(
            () => Container(
              height: 90.px,
              width: double.infinity,
              decoration: const BoxDecoration(color: AppColors.appWhite),
              child: GoogleMap(
                  markers: <Marker>{
                    Marker(
                        markerId: const MarkerId('riyadh1'),
                        position:
                            _classDetailsController.kGooglePlex.value.target)
                  },
                  initialCameraPosition:
                      _classDetailsController.kGooglePlex.value,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  onMapCreated: (GoogleMapController controllers) {
                    _classDetailsController.googleMapController = controllers;
                    _classDetailsController.mapController.complete(controllers);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget getScheduledDetails() {
    return _classDetailsController.classData.value.rescheduleInfo != null &&
            _classDetailsController.classData.value.rescheduleInfo!.isNotEmpty
        ? Column(
            children: <Widget>[
              SizedBox(
                height: 100,
                width: Get.width,
                child: CarouselSlider(
                  items: _classDetailsController.classData.value.rescheduleInfo!
                      .map((item) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 120,
                              width: Get.width,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: AppColors.bgQuaternary,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Old class Time'),
                                      Text('New class Time'),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          item.startTime
                                                  ?.toString()
                                                  .epochToNormal() ??
                                              '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          item.endTime
                                                  ?.toString()
                                                  .epochToNormal() ??
                                              '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      height: 120,
                      aspectRatio: 16 / 12,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      onPageChanged:
                          (int index, CarouselPageChangedReason reason) {
                        setState(() {
                          _classDetailsController.currentIndexPage.value =
                              index;
                        });
                      }),
                ),
              ),
              DotsIndicator(
                dotsCount: _classDetailsController
                    .classData.value.rescheduleInfo!.length,
                position: _classDetailsController.currentIndexPage.value,
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget getProposalDetails() {
    return _classDetailsController.classData.value.myProposaldetails != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColors.bgQuaternary,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'My Proposal Details',
                    style: openSans.get16.w700.appTextColor,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15, top: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  width: 18,
                                  height: 18,
                                  'assets/icons/date_icon.png',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(_classDetailsController.classData
                                      .value.myProposaldetails!.pClassTime!
                                      .toString()
                                      .epochToNormal()),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, top: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  width: 18,
                                  height: 18,
                                  'assets/icons/timer_icon.png',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(_classDetailsController.classData
                                      .value.myProposaldetails!.pDuration!
                                      .toString()
                                      .timeConvert()),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15, top: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  width: 18,
                                  height: 18,
                                  'assets/icons/date_icon.png',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                      '${_classDetailsController.classData.value.myProposaldetails!.pCost ?? ''} KWD / Session'),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, top: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  width: 18,
                                  height: 18,
                                  'assets/icons/read_book_icon.png',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                      '${_classDetailsController.classData.value.myProposaldetails!.pSessions ?? ''} Session'),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget getAddressText() {
    return Column(
      children: <Widget>[
        if (_classDetailsController.classData.value.allowAtStudentLoc == 1)
          SizedBox(
            height: 10.px,
          )
        else
          SizedBox(
            height: 20.px,
          ),
        if (_classDetailsController.classData.value.allowAtStudentLoc == 1)
          Text(
              '*Address can be determined by the student in class details during booking.',
              style: openSans.get12.w500.textColor(AppColors.appDarkBlack)),
        if (_classDetailsController.classData.value.allowAtStudentLoc == 1)
          SizedBox(
            height: 10.px,
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  Widget getRescheduleOption() {
    return _classDetailsController.classData.value.canRescheduleClass ?? false
        ? AppButton(
            isDisable: false,
            title: 'Reschedule',
            borderColor: AppColors.appBlue,
            onPressed: () async {
              Get.toNamed(Routes.rescheduleClass);
              await _classDetailsController.getScheduleInfo();
            },
          )
        : const SizedBox.shrink();
  }

  Widget addRatingOption() {
    return 
    _classDetailsController.classData.value.canAddRating
     ?? false
        ? AppButton(
            isDisable: false,
            title: 'Add Rating',
            borderColor: AppColors.appBlue,
            onPressed: () async {
               Get.toNamed(Routes.RatingScreen,
                                  arguments: <String, Object?>{
                                    'classNumber': _classDetailsController.classData.value.classNumber,
                                    'teacherName':_classDetailsController.classData.value.teacherDetails!.name
               });
            },
          )
        : const SizedBox.shrink();
  }

   Widget confirmStudentAttendance() {
    return 
    _classDetailsController.classData.value.confirmSelectedStudAttendance
     ?? false
        ? AppButton(
            isDisable: false,
            title: 'Confirm Student Attendance',
            borderColor: AppColors.appBlue,
            onPressed: () async {
              Get.toNamed(Routes.ConfirmAttendanceScreen, arguments: <String, Object?>{
                                    'classNumber': _classDetailsController.classData.value.classNumber
               });
            },
          )
        : const SizedBox.shrink();
  }

  Widget getEditProposalOption() {
    return _classDetailsController.classData.value.canEditSubmittedProposal ??
            false
        ? AppButton(
            isDisable: false,
            title: 'Edit Your Proposal',
            borderColor: AppColors.appBlue,
            onPressed: () {
              final CreateProposalController createProposalController =
                  Get.put(CreateProposalController());
              createProposalController.dateController.text =
                  DateFormat('dd-M-yyyy hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          _classDetailsController
                              .classData.value.myProposaldetails!.pClassTime!));
              createProposalController.classDurationController.text =
                  _classDetailsController
                          .classData.value.myProposaldetails?.pDuration
                          ?.toString()
                          .timeConvert() ??
                      '';
              createProposalController.duration = _classDetailsController
                      .classData.value.myProposaldetails?.pDuration ??
                  0;
              createProposalController.numberOfSession.text =
                  _classDetailsController
                          .classData.value.myProposaldetails?.pSessions
                          ?.toString() ??
                      '';
              createProposalController.classCost.text = _classDetailsController
                      .classData.value.myProposaldetails?.pCost
                      ?.replaceAll('.00', '') ??
                  '';
              // ignore: avoid_dynamic_calls
              Get.toNamed(Routes.createProposal, arguments: {
                'classNumber': Get.arguments['classNumber'],
                'proposalId': _classDetailsController
                    .classData.value.myProposaldetails!.id
              });
            },
          )
        : const SizedBox.shrink();
  }

  Widget getBookNowOption() {
    return _classDetailsController.classData.value.canBookClass ?? false
        ? _classDetailsController.classData.value.maxParticipants! > 1
            ? screenButton(
                isPaying: true,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    constraints: const BoxConstraints(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.px),
                        topLeft: Radius.circular(25.px),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return BookingBottomSheet();
                    },
                  );
                })
            : AppButton(
                isDisable: false,
                title: 'Book Now',
                borderColor: AppColors.appBlue,
                onPressed: () async {
                  if (_classDetailsController
                          .classData.value.allowAtStudentLoc ==
                      0) {
                    final bool status =
                        await _classDetailsController.bookClassDetail({});
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
                            isRouting: Routes.classDetailsView,
                            argument: _classDetailsController.classId,
                            backIndex: 1,
                          );
                        },
                      );
                    }
                  } else {
                    locationModalBottomSheet(context);
                  }
                },
              )
        : const SizedBox.shrink();
  }

  Widget getSubmitProposalOption() {
    return _classDetailsController.classData.value.canSubmitProposal ?? false
        ? AppButton(
            isDisable: false,
            title: 'Submit the proposal',
            borderColor: AppColors.appBlue,
            onPressed: () {
              final CreateProposalController createProposalController =
                  Get.put(CreateProposalController());
              createProposalController.dateController.text =
                  DateFormat('dd-M-yyyy hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          _classDetailsController.classData.value.classTime!));
              createProposalController.classDurationController.text =
                  _classDetailsController.classData.value.duration
                          ?.toString()
                          .timeConvert() ??
                      '';
              createProposalController.duration =
                  _classDetailsController.classData.value.duration ?? 0;
              createProposalController.numberOfSession.text =
                  _classDetailsController.classData.value.sessions
                          ?.toString() ??
                      '';
              createProposalController.classCost.text = _classDetailsController
                      .classData.value.cost
                      ?.replaceAll('.00', '') ??
                  '';
              // ignore: avoid_dynamic_calls
              Get.toNamed(Routes.createProposal, arguments: {
                'classNumber': Get.arguments['classNumber'],
              });
            },
          )
        : const SizedBox.shrink();
  }

  Widget getPaymentOption() {
    return _classDetailsController.classData.value.canPay ?? false
        ? screenButton(
            title: 'Pay',
            isPaying: true,
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                constraints: const BoxConstraints(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.px),
                    topLeft: Radius.circular(25.px),
                  ),
                ),
                builder: (BuildContext context) {
                  return BookingBottomSheet(
                    isBook: 'Pay',
                    isRouting: 'home',
                  );
                },
              );
            })
        : const SizedBox.shrink();
  }

  Widget getCancelClassOption() {
    return _classDetailsController.classData.value.canCancelClass ?? false
        ? GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isDismissible: false,
                constraints: BoxConstraints(
                  maxWidth:
                      // ignore: use_build_context_synchronously
                      (MediaQuery.of(context).size.width - 30).px,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.px),
                ),
                builder: (BuildContext context) {
                  return WarningDialog(
                    onTap: () async {
                      final bool status =
                          await _classDetailsController.cancelClass();
                      if (status) {
                        // ignore: use_build_context_synchronously
                        showModalBottomSheet(
                          context: context,
                          isDismissible: false,
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
                                title: 'Cancelled',
                                buttonTitle: 'Done',
                                isRouting: 'back',
                                content:
                                    'You have successfully approved the class new time.');
                          },
                        );
                      }
                    },
                  );
                },
              );
            },
            child: Center(
              child: AppText(
                'Cancel Your Class',
                fontWeight: FontWeight.w700,
                fontSize: 16.px,
                color: AppColors.appRed,
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget getWithdrawProposalOption() {
    return _classDetailsController.classData.value.canWithdrawProposal ?? false
        ? GestureDetector(
            onTap: () {
              _classDetailsController.deleteProposalDetails(
                  _classDetailsController
                      .classData.value.myProposaldetails!.id!);
            },
            child: Center(
              child: AppText(
                'Withdraw Proposal',
                fontWeight: FontWeight.w700,
                fontSize: 16.px,
                color: AppColors.appRed,
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget getApproveRejectClassOption() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        if (_classDetailsController.classData.value.canApproveCancel ?? false)
          AppButton(
            title: 'Approve The Cancellation Request',
            height: 45.px,
            isDisable: false,
            borderColor: AppColors.appBlue,
            borderRadius: BorderRadius.circular(10.px),
            onPressed: () async {
              final bool status =
                  await _classDetailsController.classRejectApproval('approve');
              if (status) {
                // ignore: use_build_context_synchronously
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
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
                      isRouting: 'back',
                      content:
                          // ignore: unrelated_type_equality_checks
                          _classDetailsController.selectedProfile ==
                                  ApplicationConstants.student
                              ? 'You have successfully approved the cancellation request and the class cost will be refunded.'
                              : 'You have successfully approved the cancellation request.',
                    );
                  },
                );
              }
            },
          ),
        if (_classDetailsController.classData.value.canRejectCancel ?? false)
          GestureDetector(
            onTap: () async {
              final bool status =
                  await _classDetailsController.classRejectApproval('reject');
              if (status) {
                // ignore: use_build_context_synchronously
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
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
                      isRouting: 'back',
                      content:
                          'You have successfully rejected the cancellation request.',
                    );
                  },
                );
              }
            },
            child: Center(
              child: AppText(
                'Reject The Request',
                fontWeight: FontWeight.w700,
                fontSize: 16.px,
                color: AppColors.appRed,
              ),
            ),
          ),
      ],
    );
  }

  Widget getApproveScheduleOption() {
    return _classDetailsController.classData.value.canApproveTheReschedule ??
            false
        ? AppButton(
            title: 'Approve Reschedule',
            height: 45.px,
            isDisable: false,
            borderColor: AppColors.appBlue,
            borderRadius: BorderRadius.circular(10.px),
            onPressed: () async {
              final bool status = await _classDetailsController
                  .approveRejectReschedule('approve');
              if (status) {
                // ignore: use_build_context_synchronously
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
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
                        isRouting: 'back',
                        content:
                            'You have successfully approved the class new time.');
                  },
                );
              }
            },
          )
        : const SizedBox.shrink();
  }

  Widget getRejectScheduleOption() {
    return _classDetailsController.classData.value.canRejectTheReschedule ??
            false
        ? GestureDetector(
            onTap: () async {
              final bool status = await _classDetailsController
                  .approveRejectReschedule('reject');
              if (status) {
                // ignore: use_build_context_synchronously
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
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
                      isRouting: 'back',
                      content:
                          'You have successfully rejected the rescheduling request.',
                    );
                  },
                );
              }
            },
            child: Center(
              child: AppText(
                'Reject',
                fontWeight: FontWeight.w700,
                fontSize: 16.px,
                color: AppColors.appRed,
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  int sessions() {
    int session = 0;
    bool set = false;
    _classDetailsController.classData.value.scheduleInfo?.forEach((element) {
      if (element.startTime! >= DateTime.now().millisecondsSinceEpoch && !set) {
        session = element.session ?? 0;
        set = true;
      }
    });
    return session;
  }

  Widget getOwnerView() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.px, vertical: 5.px),
            decoration: BoxDecoration(
              color: AppColors.lightPurple,
              borderRadius: BorderRadius.circular(30.px),
            ),
            child: AppText(
              _classDetailsController.classData.value.isOwner == 1
                  ? 'Created by You'
                  : 'Created by ${_classDetailsController.classData.value.userName ?? ''}',
              overflow: TextOverflow.ellipsis,
              fontSize: 10.px,
              color: AppColors.appLightBlack,
            ),
          ),
          const SizedBox(width: 5), // Additional padding
        ],
      ),
    );
  }

  Widget curriculumWidget({required String heading, required String detail}) {
    return SizedBox(
      height: 55.px,
      // width: 80.px,
      child: Column(
        children: <Widget>[
          Center(
            child: AppText(heading,
                fontSize: 12.px, color: AppColors.appLightBlack),
          ),
          SizedBox(
            height: 5.px,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.px, vertical: 5.px),
            decoration: BoxDecoration(
                color: AppColors.lightPurple,
                borderRadius: BorderRadius.circular(30.px)),
            child: AppText(detail,
                overflow: TextOverflow.ellipsis,
                fontSize: 10.px,
                color: AppColors.appLightBlack),
          ),
        ],
      ),
    );
  }

  Widget tagCardView({String? title, String? icon}) {
    return Container(
      height: 24.px,
      padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 5.px),
      decoration: BoxDecoration(
        color: AppColors.lightestPurple,
        borderRadius: BorderRadius.circular(30.px),
      ),
      child: Row(
        children: <Widget>[
          if (icon != null &&
              icon.isNotEmpty) // Check if icon is not null and not empty
            AppImageAsset(
              image: icon,
              height: 14.px,
            ),
          if (icon != null && icon.isNotEmpty) // Another check for spacing
            SizedBox(width: 5.px),
          AppText(
            title ?? '',
            fontSize: 10.px,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  void locationModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColors.white,
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
                            final bool status = await _classDetailsController
                                .bookClassDetail({});
                            Get.back();
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
                                    isRouting: Routes.classDetailsView,
                                    argument: _classDetailsController.classId,
                                    backIndex: 1,
                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.gray.withOpacity(0.25),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(15),
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
                    bool status =
                        await _classDetailsController.bookClassDetail({
                      'location': _manageAddressController
                          .address[_classDetailController.selectedIndex.value]
                          .id
                    });

                    if (status) {
                      Get.back();
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
                            isRouting: Routes.classDetailsView,
                            argument: _classDetailsController.classId,
                            backIndex: 1,
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

  Widget screenButton({bool? isPaying, VoidCallback? onTap, String? title}) {
    return Container(
      alignment: Alignment.center,
      height: 80.px,
      padding: context.paddingNormal,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.px),
        color:
            (isPaying!) ? AppColors.appTransparent : AppColors.lightPurpleTwo,
      ),
      child: isPaying
          ? Row(children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText('Total amount to pay',
                        color: AppColors.appGrey,
                        fontSize: 12.px,
                        fontWeight: FontWeight.w500),
                    SizedBox(height: 3.px),
                    Row(
                      children: <Widget>[
                        AppText(
                            '${_classDetailsController.classData.value.cost?.split('.')[0]}',
                            fontSize: 16.px,
                            fontWeight: FontWeight.w700),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: AppText(
                              '.${_classDetailsController.classData.value.cost?.split('.')[1]} KWD',
                              fontSize: 12.px,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ]),
              const Spacer(),
              AppButton(
                isDisable: false,
                width: 150.px,
                title: title ?? 'Book Now',
                borderColor: AppColors.appBlue,
                borderRadius: BorderRadius.circular(10.px),
                onPressed: isPaying ? onTap! : () {},
              )
            ])
          : Row(children: <Widget>[
              AppImageAsset(
                image: ImageConstants.infoIcon,
                height: 23.px,
              ),
              SizedBox(
                width: 10.px,
              ),
              SizedBox(
                width: 260.px,
                child: AppText(
                  'You wil pay after the class accepted by the teacher.',
                  fontSize: 12.px,
                  fontWeight: FontWeight.w400,
                ),
              )
            ]),
    );
  }

  void proposalByTeacherBottomSheet(int index) {
    final double width = MediaQuery.sizeOf(context).width;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => _proposalsByController
                      .proposalDetailModel.value.proposalDetails?.cost !=
                  null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('Proposal By', style: openSans.get14.w700),
                                SizedBox(
                                  width: width * 0.25,
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.downArrowColor
                                            .withOpacity(0.15)),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 15,
                                      ),
                                    ))
                              ],
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Mr. ',
                                    style: TextStyle(
                                      color: AppColors.appDarkBlack,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.px,
                                    ),
                                  ),
                                  TextSpan(
                                    text: _classDetailsController.classData
                                            .value.proposals?[index].name ??
                                        '',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColors.appDarkBlack,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.px,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 140,
                        width: width,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: AppColors.bgQuaternary,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Original Class Details',
                              style: openSans.get16.w700.appTextColor,
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, top: 15),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Image.asset(
                                            width: 18,
                                            height: 18,
                                            'assets/icons/date_icon.png',
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(_proposalsByController
                                                .proposalDetailModel
                                                .value
                                                .originalDetails!
                                                .classTime!
                                                .toString()
                                                .epochToNormal()),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, top: 15),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Image.asset(
                                            width: 18,
                                            height: 18,
                                            'assets/icons/timer_icon.png',
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(_proposalsByController
                                                .proposalDetailModel
                                                .value
                                                .originalDetails!
                                                .duration!
                                                .toString()
                                                .timeConvert()),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, top: 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Image.asset(
                                            width: 18,
                                            height: 18,
                                            'assets/icons/date_icon.png',
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                                '${_proposalsByController.proposalDetailModel.value.originalDetails!.cost ?? ''} KWD / Session'),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, top: 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Image.asset(
                                            width: 18,
                                            height: 18,
                                            'assets/icons/read_book_icon.png',
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                                '${_proposalsByController.proposalDetailModel.value.originalDetails!.session} Session'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                          height: 140,
                          width: width,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.ctaQuaternary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Proposal Details',
                                style: openSans.get16.w700.appTextColor,
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, top: 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          width: 18,
                                          height: 18,
                                          'assets/icons/date_icon.png',
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(_proposalsByController
                                              .proposalDetailModel
                                              .value
                                              .proposalDetails!
                                              .classTime!
                                              .toString()
                                              .epochToNormal()),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, top: 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          width: 18,
                                          height: 18,
                                          'assets/icons/timer_icon.png',
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(_proposalsByController
                                              .proposalDetailModel
                                              .value
                                              .proposalDetails!
                                              .duration!
                                              .toString()
                                              .timeConvert()),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, top: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          width: 18,
                                          height: 18,
                                          'assets/icons/date_icon.png',
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                              '${_proposalsByController.proposalDetailModel.value.proposalDetails!.cost ?? ''} KWD / Session'),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, top: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          width: 18,
                                          height: 18,
                                          'assets/icons/read_book_icon.png',
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                              '${_proposalsByController.proposalDetailModel.value.proposalDetails!.session ?? ''} Session'),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                      AppButton(
                        isDisable: false,
                        borderColor: AppColors.appBlue,
                        height: 45.px,
                        title: 'Approve The Proposal',
                        onPressed: () async {
                          final bool status =
                              await _classDetailsController.approveProposal(
                                  _classDetailsController.proposalId ?? '');
                          if (status) {
                            Get.back();
                            // ignore: use_build_context_synchronously
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return BookingBottomSheet(
                                  isBook: 'false',
                                  isRouting: '',
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
