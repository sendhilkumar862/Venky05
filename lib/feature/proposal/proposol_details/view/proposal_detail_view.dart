
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../custom/appbar/appbar.dart';

import '../../../../config/routes/route.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/cardView/details_card_view.dart';
import '../../../../custom/cardView/details_card_view_horizontal.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/status_card_view.dart';
import '../../../../custom/cardView/student_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/extension/context_extension.dart';
import '../../../../product/utils/typography.dart';
import '../../../classDetails/view/bottomSheetView/student_bottom_view.dart';
import '../../proposals_by/view/proposals_by.dart';
import '../controller/proposal_detail_controller.dart';


class ProposalDetailsView extends StatefulWidget {
  const ProposalDetailsView({super.key});

  @override
  State<ProposalDetailsView> createState() => _ProposalDetailsViewState();
}

class _ProposalDetailsViewState extends State<ProposalDetailsView> {
  final ProposalDetailController _proposalDetailController=Get.put(ProposalDetailController());
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    var data = _proposalDetailController.dataList[0];
    return Scaffold(
      appBar: HessaAppBar(
        title: 'classDetails'.tr,
        isTitleOnly: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 5.px),
        children: <Widget>[
          SizedBox(
            height: 20.px,
          ),
          AppText(
            'Math',
            fontSize: 20.px,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(
            height: 10.px,
          ),
          AppText(
            'Explore the world of math with interactive games, puzzles, and challenges. Join us for fun learning adventures and make math your favorite subject!',
            fontWeight: FontWeight.w400,
            fontSize: 14.px,
          ),
          SizedBox(
            height: 20.px,
          ),
          HeadingCardView(
            title: 'Curriculum',
            padding: 0,
          ),
          SizedBox(
            height: 20.px,
          ),
          SizedBox(
            height: 60.px,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 80.px,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppText('Grade',
                            fontSize: 12.px,
                            color: AppColors.appLightBlack),
                        SizedBox(
                          height: 5.px,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.px, vertical: 3.px),
                          decoration: BoxDecoration(
                              color: AppColors.lightPurple,
                              borderRadius: BorderRadius.circular(30.px)),
                          child: AppText('Grade 2',
                              fontSize: 10.px,
                              color: AppColors.appLightBlack),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 6.px,
                  );
                },
                itemCount: 4),
          ),
          SizedBox(
            height: 20.px,
          ),
          // For student View
          if (_proposalDetailController.selectedProfile.value ==
              ApplicationConstants.tutor)
            Column(
              children: [
                HeadingCardView(
                  padding: 0,
                  title: 'Student',
                  isViewAllIcon: true,
                  totalItem: "5",
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
                        return  StudentBottomSheet(classId: '',);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 18.px,
                ),
                SizedBox(
                  height: 70.px,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return const StudentCardView();
                      },
                      separatorBuilder:
                          (BuildContext context, int index) {
                        return SizedBox(width: 14.px);
                      },
                      itemCount: 10),
                ),
                SizedBox(height: 18.px),
              ],
            ),
          // For student View
          if (_proposalDetailController.selectedProfile.value ==
              ApplicationConstants.student)
            Column(
              children: [
                HeadingCardView(
                    title: 'Proposal',
                    totalItem: '5',
                    padding: 0,
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
                          return  ProposalsBy(classId: '',);
                        },
                      );
                    },
                    isViewAllIcon: true),
                SizedBox(
                  height: 5.px,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.26,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return DetailsCardView(
                          reViewLength: 3,
                          name: 'User Name',
                          avatar: ImageConstants.teacherAvtar,
                          countryIcon: ImageConstants.countryIcon,
                          countryName: 'Kuwait',
                          isPro: true,
                          isBookmarked: true,
                          subjects: '5,500 KED per session');
                    },
                  ),
                ),
                SizedBox(
                  height: 20.px,
                ),
              ],
            ),

          // For Tutor View
          if (_proposalDetailController.selectedProfile.value ==
              ApplicationConstants.tutor)
            InkWell(
              onTap: () {},
              child: DetailsCardViewHorizontal(
                heading: 'Teacher',
                name: 'User Name',
                height: 95.px,
                avatar: ImageConstants.teacherAvtar,
                countryName: 'Grade 1-2-3',
                isPro: false,
                isBookmarked: true,
              ),
            ),
          SizedBox(
            height: 10.px,
          ),
          Container(
            padding: context.paddingNormal,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.px),
              color: AppColors.lightPurple,
              border:
              Border.all(color: AppColors.lightPurple, width: 1.1.px),
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
                    StatusCardView(status: 'PAYING'),
                  ],
                ),
                SizedBox(height: 15.px),
                tagCardView(
                    title: 'Private 1/1', icon: ImageConstants.groupIcon),
                tagCardView(
                    title: 'Sessions', icon: ImageConstants.moneyIcon),
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
                        'City, Block No., Street Name, Street Name 2, House No., Floor No., Apartment No.',
                        fontSize: 10.px,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15.px),
                Container(
                  height: 90.px,
                  width: double.infinity,
                  decoration:
                  const BoxDecoration(color: AppColors.appWhite),
                  child: GoogleMap(
                    markers: <Marker>{
                      Marker(
                        markerId: const MarkerId('riyadh1'),
                        position: LatLng(
                          double.parse('24.7136'),
                          double.parse('46.6753'),
                        ),
                      )
                    },
                    initialCameraPosition:
                    _proposalDetailController.kGooglePlex!,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,
                    onMapCreated: (GoogleMapController controllers) =>
                        _proposalDetailController.mapController
                            .complete(controllers),
                  ),
                ),
              ],
            ),
          ),
          // For Tutor View
          if (_proposalDetailController.selectedProfile.value ==
              ApplicationConstants.tutor)
            SizedBox(
              height: 25.px,
            ),
          // For Tutor View
          if (_proposalDetailController.selectedProfile.value ==
              ApplicationConstants.tutor)
            Container(
              height: 140,
              width: width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColors.ctaQuaternary,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.heading,
                    style: openSans.get16.w700.appTextColor,
                  ),
                  Wrap(
                    children: List.generate(
                      _proposalDetailController
                          .dataList[0].headingData.length,
                          (i) {
                        var data1 = _proposalDetailController
                            .dataList[0].headingData[i];
                        return Padding(
                          padding:
                          const EdgeInsets.only(right: 15, top: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset(
                                width: 18,
                                height: 18,
                                data1.icon,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(data1.title),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          // For Tutor View
          if (_proposalDetailController.selectedProfile.value ==
              ApplicationConstants.tutor)
            AppButton(
                isDisable: false,
                title: 'Submit Your Proposal',
                borderColor: AppColors.appBlue,
                onPressed: () {
                  Get.toNamed(Routes.createProposal);
                }),
          SizedBox(
            height: 20.px,
          ),
          Center(
            child: Text(
              _proposalDetailController.selectedProfile.value ==
                  ApplicationConstants.tutor
                  ? 'Reject'
                  : 'Cancel Your Booking',
              style: openSans.get14.w600
                  .copyWith(color: AppColors.appLightRed),
            ),
          ),
          SizedBox(
            height: 40.px,
          ),
        ],
      ),
    );
  }

  Widget screenButton({bool? isPaying, VoidCallback? onTap}) {
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
                        AppText('27',
                            fontSize: 16.px, fontWeight: FontWeight.w700),
                        AppText('.500 KWD',
                            fontSize: 12.px, fontWeight: FontWeight.w700),
                      ],
                    ),
                  ]),
              const Spacer(),
              AppButton(
                width: 150.px,
                title: 'Book Now',
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

  Widget tagCardView({String? title, String? icon}) {
    return SizedBox(
      height: 24.px,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView.builder(
          padding: EdgeInsets.only(right: 5.px),
          itemCount: 3,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 5.px),
              decoration: BoxDecoration(
                color: AppColors.lightPurple,
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
                  if (icon != null &&
                      icon.isNotEmpty) // Another check for spacing
                    SizedBox(width: 5.px),
                  AppText(
                    title ?? '',
                    fontSize: 10.px,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
