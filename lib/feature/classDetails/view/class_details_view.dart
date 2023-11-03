import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../product/base/view/base_view.dart';

import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/details_card_view_horizontal.dart';
import '../../../custom/cardView/heading_card_view.dart';
import '../../../custom/cardView/status_card_view.dart';

import '../../../custom/cardView/student_card_view.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/context_extension.dart';
import '../../rating/view/rating_view.dart';
import '../viewModel/class_details_view_model.dart';
import 'bottomSheetView/booking_bottom_view.dart';
import 'bottomSheetView/student_bottom_view.dart';

class ClassDetailsView extends StatefulWidget {
  const ClassDetailsView({super.key});

  @override
  State<ClassDetailsView> createState() => _ClassDetailsViewState();
}

class _ClassDetailsViewState extends State<ClassDetailsView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<ClassDetailsViewModel>(
      viewModel: ClassDetailsViewModel(),
      onModelReady: (ClassDetailsViewModel classDetailsViewModel) {
        classDetailsViewModel.setContext(context);
      },
      onPageBuilder:
          (BuildContext context, ClassDetailsViewModel homeViewsModel) {
        return Observer(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: AppColors.appWhite,
              appBar: HessaAppBar(
                icon: ImageConstants.avtar,
                title: 'Class Details',
              ),
              body: ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.px, vertical: 5.px),
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
                  ),
                  SizedBox(
                    height: 20.px,
                  ),
                  HeadingCardView(
                    title: 'Class Info',
                    padding: 0,
                  ),
                  SizedBox(
                    height: 20.px,
                  ),
                  SizedBox(
                    height: 40.px,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 80.px,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AppText('Grade 2',
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
                                      borderRadius:
                                          BorderRadius.circular(30.px)),
                                  child: AppText('Grade',
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
                  HeadingCardView(
                    padding: 0,
                    title: 'Teachers',
                    isViewAllIcon: true,
                    trailingWidget: Row(
                      children: <Widget>[
                        AppText('Accept or Reject Students',
                            fontSize: 14.px,
                            fontWeight: FontWeight.w600,
                            color: AppColors.appBlue),
                        SizedBox(width: 5.px),
                        AppImageAsset(
                          image: ImageConstants.editIcon,
                          height: 18.px,
                          color: AppColors.appBlue,
                        )
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return  StudentBottomSheet();
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
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return const StudentCardView();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 14.px);
                        },
                        itemCount: 10),
                  ),
                  SizedBox(height: 18.px),
                  InkWell(
                    onTap: () {},
                    child: DetailsCardViewHorizontal(
                        heading: 'Teacher',
                        reViewLength: 3,
                        name: 'User Name',
                        avatar: ImageConstants.teacherAvtar,
                        countryIcon: ImageConstants.countryIcon,
                        countryName: 'Kuwait',
                        isPro: true,
                        isBookmarked: true,
                        subjects: 'Science - Account..'),
                  ),
                  SizedBox(
                    height: 20.px,
                  ),
                  Container(
                    padding: context.paddingNormal,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.px),
                      color: AppColors.lightPurple,
                      border: Border.all(
                          color: AppColors.lightPurple, width: 1.1.px),
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
                            Spacer(),
                            StatusCardView(status: 'PAYING'),
                          ],
                        ),
                        SizedBox(height: 15.px),
                        tagCardView(
                            title: 'Private 1/1',
                            icon: ImageConstants.groupIcon),
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
                          decoration: BoxDecoration(color: AppColors.appWhite),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.px,
                  ),
                  screenButton(
                    isPaying: true,
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 25.px,
                  ),
                  AppButton(
                    title: 'Book Now',
                    borderColor: AppColors.appBlue,
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return const BookingBottomSheet();
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 40.px,
                  ),
                ],
              ),
            );
          },
        );
      },
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
              Spacer(),
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
          physics: BouncingScrollPhysics(),
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
