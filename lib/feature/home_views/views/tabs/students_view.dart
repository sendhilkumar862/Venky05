// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/route.dart';
import '../../../../core/api_end_points.dart';
import '../../../../custom/cardView/details_card_view_student.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../product/cache/key_value_storage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../home/controller/home_controller.dart';
import 'classes_view.dart';

class StudentsView extends StatefulWidget {
  const StudentsView({super.key});

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  String selectedProfile = '';
  String selectedUserStatus = '';
  bool isPending = false;
  final HomeController _homeController = Get.find();

  @override
  void initState() {
    super.initState();
    selectedProfile = LocaleManager.getValue(StorageKeys.profile) ?? '';
    selectedUserStatus =
        LocaleManager.getValue(StorageKeys.userInfoStatus) ?? '';

    _homeController
        .getFavouriteStudentTeacherList(_homeController.favouritePageIndex);
    _homeController.getRelatedStudentTeacherList(
        _homeController.totalRelatedStudentTeacherPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_homeController.homeData.value != null) {
          if (_homeController.homeData.value?.userStatus != '99') {
            return const ClassesView();
          } else {
            return Obx(() => _homeController.favouritesStudentList.isEmpty &&
                    _homeController.relatedStudentList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.275,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: 8.px, top: 20.px, bottom: 10.px, left: 8.px),
                      child: InfoCardVIew(
                        isShowButton: false,
                        title: 'No Students Found!',
                        subTitle:
                            'No Students found matching your preferences.',
                        cardColor: AppColors.white,
                        buttonTitle: '',
                        buttonTap: () {},
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 20.px),
                        HeadingCardView(
                            title: 'Favorites Students',
                            totalItem: _homeController.totalFavouriteCount > 1
                                ? _homeController.totalFavouriteCount.toString()
                                : '',
                            onTap: () => Get.toNamed(Routes.viewAllTeacher,
                                    arguments: <String, Object?>{
                                      'title': 'Favourite Students',
                                      'type': FavouritesEndPoint.Favourites
                                    }),
                            isViewAllIcon:
                                _homeController.totalFavouriteCount > 1
                                    ? true
                                    : false),
                        SizedBox(
                          height: 5.px,
                        ),
                        if (_homeController.favouritesStudentList.isNotEmpty)
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.300,
                            child: ListView.builder(
                              itemCount:
                                  _homeController.favouritesStudentList.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return DetailsCardViewStudent(
                                    onTap: () async {
                                      await _homeController.deleteFavouriteInfo(
                                          _homeController
                                              .relatedStudentList[index].userId!
                                              .toString());
                                    },
                                    name: _homeController
                                            .favouritesStudentList[index]
                                            .name ??
                                        '',
                                    avatar: _homeController
                                        .favouritesStudentList[index].imageId,
                                    isBookmarked: true,
                                    grades:
                                        'Grade ${_homeController.favouritesStudentList[index].grade?.join(' - ')}');
                              },
                            ),
                          )
                        else
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 20.0),
                            child: InfoCardVIew(
                              isShowButton: false,
                              title: 'No Favourite Students!',
                              subTitle:
                                  'Discover students and add them to your favourites to reach them and communicate with them quickly.',
                              cardColor: AppColors.white,
                              buttonTitle: '',
                              buttonTap: () {},
                            ),
                          ),
                        HeadingCardView(
                            title: 'Related Students',
                            totalItem: _homeController
                                        .totalRelatedStudentTeacherCount >
                                    1
                                ? _homeController
                                    .totalRelatedStudentTeacherCount
                                    .toString()
                                : '',
                            onTap: () => Get.toNamed(Routes.viewAllTeacher,
                                    arguments: <String, Object?>{
                                      'title': 'Related Students',
                                      'type': FavouritesEndPoint.Related
                                    }),
                            isViewAllIcon: _homeController
                                        .totalRelatedStudentTeacherCount >
                                    1
                                ? true
                                : false),
                        SizedBox(
                          height: 5.px,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.300,
                          child: ListView.builder(
                            itemCount:
                                _homeController.relatedStudentList.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return DetailsCardViewStudent(
                                  onTap: () async {
                                    if (_homeController
                                            .relatedStudentList[index]
                                            .isBookmarked !=
                                        null) {
                                      _homeController.relatedStudentList[index]
                                                  .isBookmarked ==
                                              1
                                          ? await _homeController
                                              .deleteFavouriteInfo(
                                                  _homeController
                                                      .relatedStudentList[index]
                                                      .userId!
                                                      .toString())
                                          : await _homeController
                                              .addFavouriteInfo(_homeController
                                                  .relatedStudentList[index]
                                                  .userId!
                                                  .toString());
                                    }
                                  },
                                  name: _homeController
                                      .relatedStudentList[index].name,
                                  avatar: _homeController
                                      .relatedStudentList[index].imageId,
                                  isBookmarked: _homeController
                                              .relatedStudentList[index]
                                              .isBookmarked ==
                                          1
                                      ? true
                                      : false,
                                  grades:
                                      'Grade ${_homeController.relatedStudentList[index].grade?.join(' - ')}');
                            },
                          ),
                        ),
                        SizedBox(
                          height: 200.px,
                        )
                      ],
                    ),
                  ));
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
