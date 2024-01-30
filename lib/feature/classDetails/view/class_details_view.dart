import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../config/routes/route.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/details_card_view.dart';
import '../../../custom/cardView/heading_card_view.dart';
import '../../../custom/cardView/status_card_view.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/context_extension.dart';
import '../../../product/extension/string_extension.dart';
import '../controller/class_details_controller.dart';

class ClassDetailsView extends StatefulWidget {
  const ClassDetailsView({super.key});

  @override
  State<ClassDetailsView> createState() => _ClassDetailsViewState();
}

class _ClassDetailsViewState extends State<ClassDetailsView>
    with TickerProviderStateMixin {
  final ClassDetailsController _classDetailsController =
      Get.put(ClassDetailsController());

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
              SizedBox(
                height: 20.px,
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
              HeadingCardView(
                title: _classDetailsController.selectedProfile ==
                        ApplicationConstants.student
                    ? 'Curriculum'
                    : 'Class Info',
                padding: 0,
              ),
              SizedBox(
                height: 10.px,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  curriculumWidget(
                      heading: 'Grade',
                      detail:
                          _classDetailsController.classData.value.grade ?? ''),
                  curriculumWidget(
                      heading: 'School',
                      detail:
                          _classDetailsController.classData.value.school ?? ''),
                  curriculumWidget(
                      heading: 'Curriculum',
                      detail:
                          _classDetailsController.classData.value.curriculum ??
                              ''),
                  curriculumWidget(
                      heading: 'Class Number',
                      detail:
                          _classDetailsController.classData.value.displayId ??
                              '')
                ],
              ),
              SizedBox(
                height: 20.px,
              ),
              Obx(
                () => _classDetailsController.selectedProfile ==
                            ApplicationConstants.student &&
                        _classDetailsController.classData.value.isOwner == 1
                    ? HeadingCardView(
                        padding: 0,
                        title: 'Proposals',
                        totalItem: _classDetailsController.proposalList.length
                            .toString(),
                        onTap: () {},
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        isViewAllIcon:
                            _classDetailsController.proposalList.length > 2
                                ? true
                                : false)
                    : _classDetailsController.selectedProfile ==
                                ApplicationConstants.tutor &&
                            _classDetailsController.classData.value.isOwner == 1
                        ? HeadingCardView(
                            padding: 0,
                            title: 'Students',
                            totalItem: _classDetailsController
                                .proposalList.length
                                .toString(),
                            onTap: () {},
                            // ignore: avoid_bool_literals_in_conditional_expressions
                            isViewAllIcon:
                                _classDetailsController.proposalList.length > 2
                                    ? true
                                    : false)
                        : const SizedBox.shrink(),
              ),
              SizedBox(
                height: 5.px,
              ),
              if (_classDetailsController.selectedProfile ==
                      ApplicationConstants.student &&
                  _classDetailsController.classData.value.isOwner == 1)
                Obx(
                  () => _classDetailsController.proposalList.isNotEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.300,
                          child: ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return DetailsCardView(
                                  cardMargin: EdgeInsets.only(
                                      right: 15.px, top: 10.px, bottom: 27.px),
                                  reViewLength: 3,
                                  name: 'User Name',
                                  avatar: ImageConstants.teacherAvtar,
                                  countryIcon: ImageConstants.countryIcon,
                                  countryName: 'Kuwait',
                                  isPro: true,
                                  isBookmarked: true,
                                  subjects: 'Science - Accounta..');
                            },
                          ),
                        )
                      : AppButton(
                          height: 60.px,
                          title: 'No proposals received!',
                          textStyle: TextStyle(
                              color: AppColors.black,
                              fontSize: 18.px,
                              fontWeight: FontWeight.w600),
                          borderRadius: BorderRadius.circular(12.px),
                          borderColor: AppColors.appLightGrey,
                          isBorderOnly: true,
                          onPressed: () {},
                        ),
                ),
              Obx(() {
                return _classDetailsController.selectedProfile ==
                            ApplicationConstants.tutor &&
                        _classDetailsController.classData.value.isOwner == 1
                    ? AppButton(
                        isDisable: true,
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
                    : const SizedBox.shrink();
              }),
              SizedBox(
                height: 20.px,
              ),
              Container(
                padding: context.paddingNormal,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.px),
                  color: AppColors.lightestPurple,
                  border: Border.all(
                      color: AppColors.lightestPurple, width: 1.1.px),
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
                            status:
                                _classDetailsController.classData.value.status),
                      ],
                    ),
                    SizedBox(height: 15.px),
                    Row(
                      children: [
                        tagCardView(
                            title: _classDetailsController
                                        .classData.value.maxParticipants ==
                                    1
                                ? 'Individual'
                                : 'Group ${_classDetailsController.classData.value.minParticipants}/${_classDetailsController.classData.value.maxParticipants}',
                            icon: _classDetailsController
                                        .classData.value.maxParticipants ==
                                    1
                                ? ImageConstants.individualIcon
                                : ImageConstants.groupIcon),
                        tagCardView(
                            title: _classDetailsController
                                .classData.value.classTime
                                ?.toString()
                                .epochToNormal(),
                            icon: ImageConstants.dateIcon),
                        tagCardView(
                            title: _classDetailsController
                                .classData.value.duration
                                ?.toString()
                                .timeConvert(),
                            icon: ImageConstants.timerIcon),
                      ],
                    ),
                    Row(
                      children: [
                        tagCardView(
                            title:
                                '${_classDetailsController.classData.value.cost} ${_classDetailsController.classData.value.currency} per Session',
                            icon: ImageConstants.moneyIcon),
                        tagCardView(
                            title:
                                'Session ${_classDetailsController.classData.value.sessions} of 5',
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
                            _classDetailsController.classData.value.address ??
                                '',
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
                        decoration:
                            const BoxDecoration(color: AppColors.appWhite),
                        child: GoogleMap(
                            markers: <Marker>{
                              Marker(
                                  markerId: const MarkerId('riyadh1'),
                                  position: _classDetailsController
                                      .kGooglePlex.value.target)
                            },
                            initialCameraPosition:
                                _classDetailsController.kGooglePlex.value,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: false,
                            onMapCreated: (GoogleMapController controllers) {
                              _classDetailsController.googleMapController =
                                  controllers;
                              _classDetailsController.mapController
                                  .complete(controllers);
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.px,
              ),
              if (_classDetailsController.classData.value.canRescheduleClass ??
                  false)
                AppButton(
                  isDisable: false,
                  title: 'Reschedule',
                  borderColor: AppColors.appBlue,
                  onPressed: () {
                    Get.toNamed(Routes.proposalDetailsView);
                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   context: context,
                    //   shape: const RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.vertical(
                    //       top: Radius.circular(25.0),
                    //     ),
                    //   ),
                    //   builder: (BuildContext context) {
                    //     return BookingBottomSheet();
                    //   },
                    // );
                  },
                ),
              if (_classDetailsController.classData.value.canBookClass ?? false)
                AppButton(
                  isDisable: false,
                  title: 'Book Now',
                  borderColor: AppColors.appBlue,
                  onPressed: () {
                    Get.toNamed(Routes.createProposal);
                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   context: context,
                    //   shape: const RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.vertical(
                    //       top: Radius.circular(25.0),
                    //     ),
                    //   ),
                    //   builder: (BuildContext context) {
                    //     return BookingBottomSheet();
                    //   },
                    // );
                  },
                ),
              if (_classDetailsController.classData.value.canSubmitProposal ??
                  false)
                AppButton(
                  isDisable: false,
                  title: 'Submit the proposal',
                  borderColor: AppColors.appBlue,
                  onPressed: () {
                    // ignore: avoid_dynamic_calls
                    Get.toNamed(Routes.createProposal,arguments: Get.arguments['classNumber']);
                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   context: context,
                    //   shape: const RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.vertical(
                    //       top: Radius.circular(25.0),
                    //     ),
                    //   ),
                    //   builder: (BuildContext context) {
                    //     return BookingBottomSheet();
                    //   },
                    // );
                  },
                ),
              SizedBox(
                height: 20.px,
              ),
              if (_classDetailsController.classData.value.canCancelClass ??
                  false)
                GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: AppText(
                      'Cancel Your Class',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.px,
                      color: AppColors.appRed,
                    ),
                  ),
                ),
              SizedBox(
                height: 40.px,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget curriculumWidget({required String heading, required String detail}) {
    return SizedBox(
      height: 65.px,
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
}
