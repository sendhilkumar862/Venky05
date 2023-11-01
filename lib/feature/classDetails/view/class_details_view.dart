import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
                isTitleOnly: true,
              ),
              body: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  const AppText(
                    'Math',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AppText(
                    'Explore the world of math with interactive games, puzzles, and challenges. Join us for fun learning adventures and make math your favorite subject!',
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  HeadingCardView(
                    title: 'Class Info',
                    padding: 0,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const AppText('Grade 2',
                                    fontSize: 12,
                                    color: AppColors.appLightBlack),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: AppColors.lightPurple,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const AppText('Grade',
                                      fontSize: 10,
                                      color: AppColors.appLightBlack),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 6,
                          );
                        },
                        itemCount: 4),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  HeadingCardView(
                    padding: 0,
                    title: 'Teachers',
                    isViewAllIcon: true,
                    trailingWidget: const Row(
                      children: <Widget>[
                        AppText('Accept or Reject Students',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.appBlue),
                        SizedBox(width: 5),
                        AppImageAsset(
                          image: ImageConstants.editIcon,
                          height: 18,
                          color: AppColors.appBlue,
                        )
                      ],
                    ),
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
                          return const StudentBottomSheet();
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    height: 68,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return const StudentCardView();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 14);
                        },
                        itemCount: 10),
                  ),
                  const SizedBox(height: 18),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: context.paddingNormal,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lightPurple,
                      border:
                          Border.all(color: AppColors.lightPurple, width: 1.1),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const AppText(
                              'Class Details',
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                            const Spacer(),
                            StatusCardView(status: 'PAYING'),
                          ],
                        ),
                        const SizedBox(height: 15),
                        tagCardView(
                            title: 'Private 1/1',
                            icon: ImageConstants.groupIcon),
                        tagCardView(
                            title: 'Sessions', icon: ImageConstants.moneyIcon),
                        const SizedBox(height: 5),
                        const Row(
                          children: <Widget>[
                            AppImageAsset(
                              image: ImageConstants.pinLocation,
                              height: 20,
                            ),
                            SizedBox(
                              width: 260,
                              child: AppText(
                                'City, Block No., Street Name, Street Name 2, House No., Floor No., Apartment No.',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 90,
                          width: double.infinity,
                          decoration:
                              const BoxDecoration(color: AppColors.appWhite),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  screenButton(
                    isPaying: true,
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  AppButton(
                    title: 'Book Now',
                    borderColor: AppColors.appBlue,
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
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
                  const SizedBox(
                    height: 40,
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
      height: 80,
      padding: context.paddingNormal,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color:
            (isPaying!) ? AppColors.appTransparent : AppColors.lightPurpleTwo,
      ),
      child: isPaying
          ? Row(children: <Widget>[
              const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText('Total amount to pay',
                        color: AppColors.appGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    SizedBox(height: 3),
                    Row(
                      children: <Widget>[
                        AppText('27',
                            fontSize: 16, fontWeight: FontWeight.w700),
                        AppText('.500 KWD',
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ],
                    ),
                  ]),
              const Spacer(),
              AppButton(
                width: 150,
                title: 'Book Now',
                borderColor: AppColors.appBlue,
                borderRadius: BorderRadius.circular(10),
                onPressed: isPaying ? onTap! : () {},
              )
            ])
          : const Row(children: <Widget>[
              AppImageAsset(
                image: ImageConstants.infoIcon,
                height: 23,
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 260,
                child: AppText(
                  'You wil pay after the class accepted by the teacher.',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )
            ]),
    );
  }

  Widget tagCardView({String? title, String? icon}) {
    return SizedBox(
      height: 24,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView.builder(
          padding: const EdgeInsets.only(right: 5),
          itemCount: 3,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.lightPurple,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: <Widget>[
                  if (icon != null &&
                      icon.isNotEmpty) // Check if icon is not null and not empty
                    AppImageAsset(
                      image: icon,
                      height: 14,
                    ),
                  if (icon != null &&
                      icon.isNotEmpty) // Another check for spacing
                    const SizedBox(width: 5),
                  AppText(
                    title ?? '',
                    fontSize: 10,
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
