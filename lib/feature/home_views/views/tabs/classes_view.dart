import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


import '../../../../config/routes/route.dart';

import '../../../../custom/cardView/app_card_view.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../home/controller/home_controller.dart';
import '../reupload_documents.dart';

class ClassesView extends StatefulWidget {
  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {

  String selectedProfile = '';
  String selectedUserStatus = '';
  bool isPending = false;
  final HomeController _homeController = Get.find();

  @override
  void initState() {
    super.initState();
    selectedProfile = LocaleManager.getValue(StorageKeys.profile) ??'';
  }

  @override
  Widget build(BuildContext context) {
    if (selectedProfile == ApplicationConstants.tutor) {
      return Obx(
        () => _homeController.homeData.value?.userStatus == '99'?
      activeScreen():
        Column(
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
                        } else if (_homeController.homeData.value?.userStatus ==
                            '60') {
                          Get.toNamed(Routes.teachingInfo);
                        } else if (_homeController.homeData.value?.userStatus ==
                            '70') {
                          Get.toNamed(Routes.experienceInfo);
                        } else if (_homeController.homeData.value?.userStatus ==
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
  Widget activeScreen(){
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
          Obx(
            ()=> SizedBox(
              height: 226.px,
              child: ListView.separated(
                padding: const EdgeInsets.only(
                    right: 15, top: 5, bottom: 20, left: 15),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: _homeController.classList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return AppCardView(
                    proposals: 0,
                    cardTitle: _homeController.classList[index].subject,
                    date: '12/12 12:30pm',
                    timer: '1h 30m',
                    money: "${_homeController.classList[index].cost??''} ${_homeController.classList[index].currency??''}",
                    status: _homeController.classList[index].status,
                    isPro: true,
                    avtar: ImageConstants.teacherAvtar,
                    countryIcon: ImageConstants.countryIcon,
                    countryName: 'Kuwait',
                    reViewLength: _homeController.classList.length,
                    teacherName: _homeController.classList[index].name,
                    grade: _homeController.classList[index].grade,
                    minParticipants: _homeController.classList[index].minParticipants,
                    maxParticipants:_homeController.classList[index].maxParticipants,
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
