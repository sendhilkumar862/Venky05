import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/details_card_view.dart';
import '../../../custom/cardView/details_card_view_horizontal.dart';
import '../../../custom/cardView/heading_card_view.dart';
import '../../../custom/cardView/status_card_view.dart';
import '../../../custom/dialog/success_fail_dialog.dart';
import '../../../custom/divider/divider.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/context_extension.dart';
import '../viewModel/class_details_view_model.dart';

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
                  DetailsCardViewHorizontal(
                      heading: 'Teacher',
                      reViewLength: 3,
                      name: 'User Name',
                      avatar: ImageConstants.teacherAvtar,
                      countryIcon: ImageConstants.countryIcon,
                      countryName: 'Kuwait',
                      isPro: true,
                      isBookmarked: true,
                      subjects: 'Science - Accounta..'),
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
                            AppText(
                              'Class Details'!,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                            const Spacer(),
                            StatusCardView(status: 'COMPLETED'),
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
                  Container(
                    padding: context.paddingNormal,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: AppColors.lightPurpleTwo,
                    ),
                    child: const Row(children: <Widget>[
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
                          return const SelectLocationBottomSheet();
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
                    title ?? ''!,
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

class SelectLocationBottomSheet extends StatelessWidget {
  const SelectLocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 14),
            alignment: Alignment.center,
            height: 25,
            width: 25,
            decoration: const BoxDecoration(
                color: AppColors.appLightGrey, shape: BoxShape.circle),
            child: const AppImageAsset(
              image: ImageConstants.closeIcon,
              height: 20,
            ),
          ),
          Column(
            children: <Widget>[
              const SizedBox(
                height: 28,
              ),
              const AppText(
                'Select Class Location',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1.3, color: AppColors.lightPurple),
                ),
                child: const AppText(
                  'Keep at the teacher location',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const AppDivider(),
              const SizedBox(
                height: 3,
              ),
              addressCardView(
                  title: 'Home',
                  subtitle:
                      'City, Block No., Street Name, Street Name 2, House No., Floor No., Apartment No.',
                  isDefault: true),
              const SizedBox(
                height: 13,
              ),
              addressCardView(
                  title: 'Home',
                  subtitle:
                      'City, Block No., Street Name, Street Name 2, House No., Floor No., Apartment No.',
                  isDefault: false),
              const SizedBox(
                height: 10,
              ),
              const AppDivider(),
              const SizedBox(
                height: 25,
              ),
              AppButton(
                borderColor: AppColors.appBlue,
                height: 45,
                title: 'Select',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SuccessFailsInfoDialog(
                        title: 'Success',
                        buttonTitle: 'Done',
                        content:
                            'You have successfully booked your class, and you will get notification to pay after the teacher accept the class.',
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {},
                child: const AppText(
                  'Add New Address',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlue,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container circleButtonView({Widget? widget, Color? color}) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      height: 30,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
      child: widget,
    );
  }

  Widget addressCardView({
    String? title,
    String? subtitle,
    bool? isDefault,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            width: 1.3,
            color: (isDefault!) ? AppColors.appBlue : AppColors.lightPurple),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AppText(
                title ?? ''!,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                width: 4,
              ),
              if (isDefault!)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightPurple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: const AppText(
                    'Default',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              const Spacer(),
              if (isDefault!)
                const AppImageAsset(
                  image: ImageConstants.acceptedStatus,
                  height: 22,
                  color: AppColors.appBlue,
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 260,
              child: AppText(
                subtitle ?? ''!,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              circleButtonView(
                  widget: const AppImageAsset(
                    image: ImageConstants.deleteIcon,
                  ),
                  color: AppColors.appBlue),
              const SizedBox(
                width: 11,
              ),
              circleButtonView(
                  widget: const AppImageAsset(
                    image: ImageConstants.editIcon,
                  ),
                  color: AppColors.appLightRed),
              if (!isDefault)
                const SizedBox(
                  width: 11,
                ),
              if (!isDefault)
                circleButtonView(
                    widget: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: AppText('Set Default',
                          color: AppColors.appWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                    color: AppColors.appBlue),
            ],
          )
        ],
      ),
    );
  }
}
