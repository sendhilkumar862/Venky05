// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/route.dart';
import '../../../../custom/cardView/details_card_view.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../home/controller/home_controller.dart';
import 'classes_view.dart';


class StudentsView extends StatefulWidget {
  const StudentsView({Key? key}) : super(key: key);

  @override
  State<StudentsView> createState() => _TeachersViewState();
}

class _TeachersViewState extends State<StudentsView> {
  String selectedProfile = '';
  String selectedUserStatus = '';
  bool isPending = false;
  final HomeController _homeController = Get.find();


  @override
  void initState() {
    super.initState();
    selectedProfile =
        LocaleManager.getValue(StorageKeys.profile) ??'';
    selectedUserStatus =  LocaleManager.getValue(StorageKeys.userInfoStatus) ??'';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.px),
            HeadingCardView(
                title: 'Favorites Students',
                totalItem:  _homeController.favouriteStudentsList.isNotEmpty?_homeController.favouriteStudentsList.length.toString():'',
                onTap: () {},
                isViewAllIcon: _homeController.favouriteStudentsList.isNotEmpty?true:false),
            SizedBox(
              height: 5.px,
            ),
            if (_homeController.favouriteStudentsList.isNotEmpty) SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.300,
              child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return DetailsCardView(
                      reViewLength: 3,
                      name: 'User Name',
                      avatar: ImageConstants.teacherAvtar,
                      isTeacher: true,

                      isBookmarked: true,
                      subjects: 'Grade1');
                },
              ),
            ) else Padding(
              padding: const EdgeInsets.only(top:10.0,bottom:20.0),
              child: InfoCardVIew(
                isShowButton: false,
                title: 'No Favourite Teachers!',
                subTitle:
                'Discover students and add them to your favourites to reach them and communicate with them quickly.',
                cardColor: AppColors.white,
                buttonTitle: 'Class Details',
                buttonTap: () => Get.toNamed(Routes.classDetailsView),
              ),
            ),
            HeadingCardView(
                title: 'Related Students',
                totalItem:  _homeController.relatedStudentsList.isNotEmpty?_homeController.relatedStudentsList.length.toString():'',
                onTap: () {},
                isViewAllIcon: _homeController.relatedStudentsList.isNotEmpty?true:false),
            SizedBox(
              height: 5.px,
            ),
            if (_homeController.relatedStudentsList.isNotEmpty) SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.300,
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
                      subjects: 'Science - Accounta..');
                },
              ),
            ) else Padding(
              padding: const EdgeInsets.only(top:10.0,bottom:20.0),
              child: InfoCardVIew(
                isShowButton: false,
                title: 'No Other Students!',
                subTitle:
                'Your preferred students are exclusively in your favourite list, no other matches are based on your preferences.',
                cardColor: AppColors.white,
                buttonTitle: 'Class Details',
                buttonTap: () => Get.toNamed(Routes.classDetailsView),
              ),
            ),
            SizedBox(
              height: 200.px,
            )
          ],
        ),
      );

  }
}


