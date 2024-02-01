import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../config/routes/route.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/details_card_view.dart';
import '../../../custom/cardView/heading_card_view.dart';
import '../../../custom/cardView/status_card_view.dart';
import '../../../custom/choice/src/modal/button.dart';
import '../../../custom/dialog/success_fail_dialog.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/context_extension.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/utils/typography.dart';
import '../../class/class_detail/controller/class_detail_controller.dart';
import '../../proposal/create_proposal/controller/create_proposal_controller.dart';
import '../../proposal/proposals_by/view/proposals_by.dart';
import '../../setting_view/add_address_screen/Model/request_address_model.dart';
import '../../setting_view/manage_address/Model/get_address_model.dart' hide Location;
import '../../setting_view/manage_address/controller/manage_controller.dart';
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
  final ManageAddressController _manageAddressController =
  Get.put(ManageAddressController());
  ClassDetailController _classDetailController =
  Get.put(ClassDetailController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _manageAddressController.fetchAddressData();
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
              () =>
              ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: 15.px, vertical: 5.px),
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
                        () =>
                    _classDetailsController.selectedProfile ==
                        ApplicationConstants.student &&
                        _classDetailsController.classData.value.isOwner == 1
                        ? HeadingCardView(
                        padding: 0,
                        title: 'Proposals',
                        totalItem: _classDetailsController.proposalList.length
                            .toString(),
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
                              // ignore: avoid_dynamic_calls
                              return ProposalsBy(
                                classId: _classDetailsController.classId,);
                            },
                          );
                          // Get.toNamed(Routes.proposalDetailsView,arguments: <String, dynamic>{
                          //   'proposalId': _classDetailsController.proposalList[index].proposalId,
                          //   // ignore: avoid_dynamic_calls
                          //   'classId':Get.arguments['classNumber']
                          // });
                        },
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        isViewAllIcon:
                        _classDetailsController.proposalList.isNotEmpty
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
                        _classDetailsController.proposalList.length != 2
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
                          () =>
                      _classDetailsController.proposalList.isNotEmpty
                          ? SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.300,
                        child: ListView.builder(
                          itemCount: _classDetailsController.proposalList
                              .length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return DetailsCardView(
                                cardMargin: EdgeInsets.only(
                                    right: 15.px, top: 10.px, bottom: 27.px),
                                reViewLength: _classDetailsController
                                    .proposalList[index].rating,
                                name: _classDetailsController
                                    .proposalList[index].name ?? '',
                                avatar: _classDetailsController
                                    .proposalList[index].imageId?.getImageUrl(
                                    'profile'),
                                countryIcon: _classDetailsController
                                    .proposalList[index].flagUrl,
                                countryName: _classDetailsController
                                    .proposalList[index].country,
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
                                    : 'Group ${_classDetailsController.classData
                                    .value
                                    .minParticipants}/${_classDetailsController
                                    .classData.value.maxParticipants}',
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
                                '${_classDetailsController.classData.value
                                    .cost} ${_classDetailsController.classData
                                    .value.currency} per Session',
                                icon: ImageConstants.moneyIcon),
                            tagCardView(
                                title:
                                'Session ${_classDetailsController.classData
                                    .value.sessions} of 5',
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
                                _classDetailsController.classData.value
                                    .address ??
                                    '',
                                fontSize: 10.px,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15.px),
                        Obx(
                              () =>
                              Container(
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
                                    onMapCreated: (
                                        GoogleMapController controllers) {
                                      _classDetailsController
                                          .googleMapController =
                                          controllers;
                                      _classDetailsController.mapController
                                          .complete(controllers);
                                    }),
                              ),
                        ),

                      ],
                    ),
                  ),
                  Obx(() =>
                  _classDetailsController.classData.value.myProposaldetails !=
                      null ? Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Container(
                      height: 130,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
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
                          Column(children: [
                            Row(children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 15, top: 15),
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
                                          _classDetailsController.classData
                                              .value.myProposaldetails!
                                              .pClassTime!
                                              .toString()
                                              .epochToNormal()),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 15, top: 15),
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
                                      child: Text(
                                          _classDetailsController.classData
                                              .value.myProposaldetails!
                                              .pDuration!
                                              .toString()
                                              .timeConvert()),
                                    )
                                  ],
                                ),
                              ),
                            ],),
                            Row(children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 15, top: 10),
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
                                          '${_classDetailsController.classData
                                              .value.myProposaldetails!.pCost ??
                                              ''} KWD / Session'),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 15, top: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      width: 18,
                                      height: 18,
                                      'assets/icons/read_book_icon.png',
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                          '${_classDetailsController.classData
                                              .value.myProposaldetails!
                                              .pSessions ?? ''} Session'),
                                    )
                                  ],
                                ),
                              ),
                            ],)
                          ],)
                        ],
                      ),
                    ),
                  ) : const SizedBox.shrink(),
                  ),
                  SizedBox(
                    height: 20.px,
                  ),
                  if (_classDetailsController.classData.value
                      .canRescheduleClass ??
                      false)
                    AppButton(
                      isDisable: false,
                      title: 'Reschedule',
                      borderColor: AppColors.appBlue,
                      onPressed: () {

                      },
                    ),
                  if (_classDetailsController.classData.value
                      .canEditSubmittedProposal ??
                      false)
                    AppButton(
                      isDisable: false,
                      title: 'Edit Your Proposal',
                      borderColor: AppColors.appBlue,
                      onPressed: () {
                        final CreateProposalController createProposalController = Get
                            .put(CreateProposalController());
                        createProposalController.dateController.text =
                            DateFormat('dd-M-yyyy hh:mm a').format(
                                DateTime.fromMillisecondsSinceEpoch(_classDetailsController.classData.value
                                    .myProposaldetails!.pClassTime!));
                        createProposalController.classDurationController.text =
                            _classDetailsController.classData.value
                                .myProposaldetails?.pDuration?.toString()
                                .timeConvert() ?? '';
                        createProposalController.duration =
                            _classDetailsController.classData.value
                                .myProposaldetails?.pDuration??0;
                        createProposalController.numberOfSession.text =
                            _classDetailsController.classData.value
                                .myProposaldetails?.pSessions?.toString() ?? '';
                        createProposalController.classCost.text =
                            _classDetailsController.classData.value
                                .myProposaldetails?.pCost?.replaceAll(
                                '.00', '') ?? '';
                        // ignore: avoid_dynamic_calls
                        Get.toNamed(Routes.createProposal,
                            arguments: {'classNumber':Get.arguments['classNumber'],
                            'proposalId': _classDetailsController.classData.value
                                .myProposaldetails!.id});
                      },
                    ),
                  if (_classDetailsController.classData.value.canBookClass ??
                      false)
                    AppButton(
                      isDisable: false,
                      title: 'Book Now',
                      borderColor: AppColors.appBlue,
                      onPressed: () async{
                        if(_classDetailsController.classData.value.allowAtStudentLoc==0){
                        final bool status= await _classDetailsController.bookClassDetail({});
                        if(status) {
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
                                isRouting: 'back',

                              );
                            },
                          );
                        }
                        }else{
                          locationModalBottomSheet(context);
                        }
                      },
                    ),
                  if (_classDetailsController.classData.value
                      .canSubmitProposal ??
                      false)
                    AppButton(
                      isDisable: false,
                      title: 'Submit the proposal',
                      borderColor: AppColors.appBlue,
                      onPressed: () {
                        // ignore: avoid_dynamic_calls
                        Get.toNamed(Routes.createProposal,
                            arguments: {'classNumber':Get.arguments['classNumber'],
                             });
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
                  if (_classDetailsController.classData.value
                      .canWithdrawProposal ??
                      false)
                    GestureDetector(
                      onTap: () {
                        _classDetailsController.deleteProposalDetails(_classDetailsController.classData.value.myProposaldetails!.id!);
                      },
                      child: Center(
                        child: AppText(
                          'Withdraw Proposal',
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
                          onTap: ()async {
                            Get.back();
                            bool status= await _classDetailsController.bookClassDetail({});
                            if(status) {
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
                                    isRouting: 'back',

                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color:   AppColors.gray.withOpacity(0.25),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(15),
                            child: const Text('Keep at the teacher location',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),)
                          ),
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
                  onPressed: () async{ Get.back();
                  bool status= await _classDetailsController.bookClassDetail({
                    'location': _manageAddressController.address[ _classDetailController.selectedIndex.value].id
                  });
                  if(status) {
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
                          isRouting: 'back',

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
        child: Obx(()=>
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color:  _classDetailController.selectedIndex.value ==
                        index
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
                              if (data.isDefault==1)
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
                                _classDetailController.selectedIndex.value = index;
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
                            onTap: () async{
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
                                  _classDetailController.selectedIndex.value = 200;
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
                                  right:
                                  _classDetailController.selectedIndex.value !=
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
