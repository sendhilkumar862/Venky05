


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/route.dart';
import '../../../core/api_end_points.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/app_card_view.dart';
import '../../../custom/choice/src/modal/button.dart';
import '../../../custom/dialog/success_fail_dialog.dart';
import '../../../product/cache/key_value_storeage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/utils/typography.dart';
import '../../class/class_detail/controller/class_detail_controller.dart';
import '../../classDetails/controller/class_details_controller.dart';
import '../../classDetails/view/bottomSheetView/booking_bottom_view.dart';
import '../../proposal/create_proposal/controller/create_proposal_controller.dart';
import '../../setting_view/add_address_screen/Model/request_address_model.dart';
import '../../setting_view/manage_address/Model/get_address_model.dart' hide Location;
import '../../setting_view/manage_address/controller/manage_controller.dart';
import '../../tutorial/language/controller/language_controller.dart';
import '../../tutorial/language/model/country_model.dart';
import '../controller/home_controller.dart';
import '../model/getClassList.dart';
class ViewAllClass extends StatefulWidget {
  const ViewAllClass({Key? key}) : super(key: key);

  @override
  State<ViewAllClass> createState() => _ViewAlaaClassState();
}

class _ViewAlaaClassState extends State<ViewAllClass> {
  final HomeController _homeController = Get.put(HomeController());
  final LanguageController _languageController = Get.put(LanguageController());
  String selectedProfile = '';
  SchoolEndpoint classType= SchoolEndpoint.RELATED_CLASS;
  final ClassDetailController _classDetailController =
  Get.put(ClassDetailController());
  final ClassDetailsController _classDetailsController = Get.put(ClassDetailsController());
  // final ClassDetailsController _classDetailsController =
  // Get.lazyPut(() => ClassDetailsController());
  final ManageAddressController _manageAddressController =
  Get.put(ManageAddressController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedProfile = LocaleManager.getValue(StorageKeys.profile) ?? '';
    _manageAddressController.fetchAddressData();
    // ignore: avoid_dynamic_calls
    classType=Get.arguments['type'];
    _homeController.scrollController.addListener(pagination);
  }
  void pagination() async{
    if (_homeController.scrollController.position.pixels ==
        _homeController.scrollController.position.maxScrollExtent) {
      // ignore: avoid_dynamic_calls
      if( classType==SchoolEndpoint.RELATED_CLASS && _homeController.classRelatedList.length<_homeController.totalRelatedCount ){
        _homeController.relatedPageIndex= _homeController.relatedPageIndex+1;
        // ignore: avoid_dynamic_calls
        await _homeController.getClassList( classType,_homeController.relatedPageIndex,isReload: true);



        // ignore: avoid_dynamic_calls
      }else  if( classType==SchoolEndpoint.HISTORY_CLASS && _homeController.classHistoryList.length<_homeController.totalHistoryCount ){
        _homeController.historyPageIndex= _homeController.historyPageIndex+1;
        // ignore: avoid_dynamic_calls
        await _homeController.getClassList( classType,_homeController.historyPageIndex,isReload: true);

      }
      // ignore: avoid_dynamic_calls
      else  if( classType==SchoolEndpoint.UPCOMING_CLASS && _homeController.classUpcomingList.length<_homeController.totalUpcomingCount ){
        _homeController.upcomingPageIndex= _homeController.upcomingPageIndex+1;
        // ignore: avoid_dynamic_calls
        await _homeController.getClassList( classType,_homeController.upcomingPageIndex,isReload: true);

      }
        }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:HessaAppBar(
          // ignore: avoid_dynamic_calls
          title: Get.arguments['title'],
          isTitleOnly: true,
          leadingTap: () {
            // ignore: avoid_dynamic_calls
            Get.back();
          }),
      body: Obx(()=>
        ListView.separated(
          controller: _homeController.scrollController,
          padding: const EdgeInsets.only(
              right: 15, top: 5, bottom: 20, left: 15),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          // ignore: avoid_dynamic_calls
          itemCount:  classType==SchoolEndpoint.RELATED_CLASS?_homeController.classRelatedList.length:classType==SchoolEndpoint.UPCOMING_CLASS?_homeController.classUpcomingList.length:_homeController.classHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            // ignore: avoid_dynamic_calls
            final GetClassListModel data=classType==SchoolEndpoint.RELATED_CLASS?_homeController.classRelatedList[index]:classType==SchoolEndpoint.UPCOMING_CLASS?_homeController.classUpcomingList[index]:_homeController.classHistoryList[index];
            return SizedBox(
              width: 340.px,
              child: AppCardView(
                proposals: 5,
                title: selectedProfile == ApplicationConstants.tutor
                    ? 'Propose'
                    : 'Book',
                cardTitle:
                data.subject,
                date: data.classTime!
                    .toString()
                    .epochToNormal(),
                timer: data.duration
                    .toString()
                    .timeConvert(),
                money:
                "${data.cost ?? ''} ${data.currency ?? ''}",
                status:data.status,
                // isPro: true,
                avtar: data.imageId?.getImageUrl('profile') ,
                countryIcon:  data.country!=null && _languageController.countries.isNotEmpty?_languageController.countries.firstWhere((Country element) => element.name==data.country).flag_url:ImageConstants.countryIcon,
                countryName:  data.country,
                reViewLength: 3,
                teacherName:
                data.name,
                // ignore: avoid_bool_literals_in_conditional_expressions
                isBook:data.canBookFlag!=null && data.canBookFlag==1?true:false,
                grade: data.grade,
                minParticipants: data.minParticipants,
                maxParticipants: data.maxParticipants,
                cardTap: () {
                  Get.toNamed(Routes.classDetailsView,
                      arguments: <String, Object?>{'classNumber': data.classNumber,'backIndex':1});
                },
                buttonTap: selectedProfile == ApplicationConstants.student?() async {
                  if (data.allowAtStudentLoc ==
                      0) {
                    if (data.maxParticipants! >
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
                          _classDetailsController.classId=
                              data.classNumber!;
                          _classDetailsController.getClassDetails(data
                              .classNumber!);
                          return BookingBottomSheet(isRouting: 'backToHomeScreen',);
                        },
                      );
                    } else {
                      _classDetailsController.classId=data.classNumber!;
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

                            );
                          },
                        );
                      }
                    }
                  } else {
                    locationModalBottomSheet(context, index,data);
                  }
                }:(){
                  final CreateProposalController createProposalController = Get
                      .put(CreateProposalController());
                  createProposalController.dateController.text =
                      DateFormat('dd-M-yyyy hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(data.classTime!));
                  createProposalController.classDurationController.text =
                      data.duration?.toString()
                          .timeConvert() ?? '';
                  createProposalController.duration =
                      data.duration??0;
                  createProposalController.numberOfSession.text =
                      data.maxParticipants?.toString() ?? '';
                  createProposalController.classCost.text =
                      data.cost?.replaceAll(
                          '.00', '') ?? '';
                  // ignore: avoid_dynamic_calls
                  Get.toNamed(Routes.createProposal,
                      arguments: {'classNumber':data.classNumber!,
                        'isRouting':'backToHomeScreen'
                      });
                },
              ),
            );
          },
          separatorBuilder:
              (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
        ),
      ),
    );
  }

  void locationModalBottomSheet(context, index,GetClassListModel data) {
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
                            Get.back();
                            if (data.maxParticipants !=
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
                                  _classDetailsController.classId=data.classNumber!;
                                  _classDetailsController.getClassDetails(data.classNumber!);
                                  return BookingBottomSheet(isRouting: 'backToHomeScreen',);
                                },
                              );
                            } else {
                              _classDetailsController.classId=data.classNumber!;
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
                    _classDetailsController.classId=data.classNumber!;
                    final bool status = await _classDetailsController
                        .bookClassDetail(
                        {
                          'location': _manageAddressController
                              .address[_classDetailController.selectedIndex.value]
                              .id
                        });
                    Get.back();
                    if (status) {
                      // ignore: use_build_context_synchronously
                      showModalBottomSheet(
                        context: context,
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
