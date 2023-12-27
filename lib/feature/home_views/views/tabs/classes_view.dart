import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/cardView/app_card_view.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../home/controller/home_controller.dart';
import '../reupload_documents.dart';

class ClassesView extends StatefulWidget {
  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  String selectedProfile = '';
  String selectedUserStatus = '';
  bool isPending = false;
  final HomeController _homeController = Get.find();

  @override
  void initState() {
    super.initState();
    selectedProfile =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ??
            '';
  }

  @override
  Widget build(BuildContext context) {
    if (selectedProfile == ApplicationConstants.tutor) {
      return Obx(
        () => Column(
          children: <Widget>[
            if (_homeController.homeData.value?.userStatus != '99')
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
                          AppRouter.pushNamed(Routes.personalInfo);
                        } else if (_homeController.homeData.value?.userStatus ==
                            '60') {
                          AppRouter.pushNamed(Routes.teachingInfo);
                        } else if (_homeController.homeData.value?.userStatus ==
                            '70') {
                          AppRouter.pushNamed(Routes.experienceInfo);
                        } else if (_homeController.homeData.value?.userStatus ==
                            '80') {
                          AppRouter.pushNamed(Routes.financingView);
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
                        AppRouter.push(const ReUploadDocument());
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
                        AppRouter.push(const ReUploadDocument());
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
      return Expanded(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20.px,
            ),
            SizedBox(height: 20.px),
            HeadingCardView(
                title: 'Related Classes', onTap: () {}, totalItem: '3'),
            SizedBox(
              height: 10.px,
            ),
            SizedBox(
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
                    proposals: 0,
                    cardTitle: 'Math',
                    date: '12/12 12:30pm',
                    timer: '1h 30m',
                    money: '5.500 KWD',
                    status: 'COMPLETED',
                    isPro: true,
                    avtar: ImageConstants.teacherAvtar,
                    countryIcon: ImageConstants.countryIcon,
                    countryName: 'Kuwait',
                    reViewLength: 3,
                    teacherName: 'Ahmed Ali',
                    buttonTap: () {},
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 15,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(height: 20.px),
            HeadingCardView(
                title: 'Related Classes', onTap: () {}, totalItem: '3'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
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
                    proposals: 0,
                    cardTitle: 'Math',
                    date: '12/12 12:30pm',
                    timer: '1h 30m',
                    money: '5.500 KWD',
                    status: 'COMPLETED',
                    isPro: true,
                    avtar: ImageConstants.teacherAvtar,
                    countryIcon: ImageConstants.countryIcon,
                    countryName: 'Kuwait',
                    reViewLength: 3,
                    teacherName: 'Ahmed Ali',
                    buttonTap: () {},
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 15,
                  );
                },
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
      );
    }
  }
}
