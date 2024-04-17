import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/route.dart';
import '../../../../core/api_end_points.dart';
import '../../../../custom/cardView/details_card_view.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../product/cache/key_value_storage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';

import '../../../home/controller/home_controller.dart';
import 'classes_view.dart';

class TeachersView extends StatefulWidget {
  const TeachersView({super.key});

  @override
  State<TeachersView> createState() => _TeachersViewState();
}

class _TeachersViewState extends State<TeachersView> {
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
    if (selectedProfile == ApplicationConstants.tutor) {
      return const ClassesView();
    } else {
      return Obx(() => _homeController.favouritesTeacherList.isEmpty &&
              _homeController.relatedTeacherList.isEmpty
          ? Padding(
              padding: EdgeInsets.only(
                  right: 8.px, top: 20.px, bottom: 10.px, left: 8.px),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.275,
                child: InfoCardVIew(
                  isShowButton: false,
                  title: 'No Teachers Found!',
                  subTitle: 'No teachers found matching your preferences.',
                  cardColor: AppColors.white,
                  buttonTitle: '',
                  buttonTap: () {},
                ),
              ),
            )
          : Obx(
              () => Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20.px),
                    HeadingCardView(
                        title: 'Favorites Teachers',
                        totalItem: _homeController.totalFavouriteCount > 1
                            ? _homeController.totalFavouriteCount.toString()
                            : '',
                        onTap: () => Get.toNamed(Routes.viewAllTeacher,
                                arguments: <String, Object?>{
                                  'title': 'Favourite Teachers',
                                  'type': FavouritesEndPoint.Favourites
                                }),
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        isViewAllIcon: _homeController.totalFavouriteCount > 1
                            ? true
                            : false),
                    SizedBox(
                      height: 5.px,
                    ),
                    if (_homeController.favouritesTeacherList.isNotEmpty)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.300,
                        child: ListView.builder(
                          itemCount:
                              _homeController.favouritesTeacherList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return DetailsCardView(
                                onTap: () async {
                                  await _homeController.deleteFavouriteInfo(
                                      _homeController
                                          .favouritesTeacherList[index].userId!
                                          .toString());
                                },
                                reViewLength: _homeController
                                        .favouritesTeacherList[index].rating ??
                                    0,
                                    
                                name:
                                    '${_homeController.favouritesTeacherList[index].firstName ?? ''} ${_homeController.favouritesTeacherList[index].lastName ?? ''}',
                                avatar: _homeController
                                    .favouritesTeacherList[index].imageId,
                                countryIcon: _homeController
                                    .favouritesTeacherList[index].flagUrl,
                                countryName: _homeController
                                    .favouritesTeacherList[index].country,
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                isPro: _homeController
                                            .favouritesTeacherList[index]
                                            .subscription ==
                                        'Free'
                                    ? false
                                    : true,
                                isBookmarked: true,
                                subjects: 'Science - Accounta..');
                          },
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: InfoCardVIew(
                          isShowButton: false,
                          title: 'No Favourite Teachers!',
                          subTitle:
                              'Discover teachers and add them to your favourites to reach them and communicate with them quickly.',
                          cardColor: AppColors.white,
                          buttonTitle: 'Class Details',
                        ),
                      ),
                    HeadingCardView(
                        title: 'Related Teachers',
                        totalItem:
                            _homeController.totalRelatedStudentTeacherCount > 1
                                ? _homeController
                                    .totalRelatedStudentTeacherCount
                                    .toString()
                                : '',
                        onTap: () => Get.toNamed(Routes.viewAllTeacher,
                                arguments: <String, Object?>{
                                  'title': 'Related Teachers',
                                  'type': FavouritesEndPoint.Related
                                }),
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        isViewAllIcon:
                            _homeController.totalRelatedStudentTeacherCount > 1
                                ? true
                                : false),
                    SizedBox(
                      height: 5.px,
                    ),
                    if (_homeController.relatedTeacherList.isNotEmpty)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.300,
                        child: ListView.builder(
                          itemCount: _homeController.relatedTeacherList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return DetailsCardView(
                                onTap: () async {
                                  if (_homeController.relatedTeacherList[index]
                                          .isBookmarked !=
                                      null) {
                                    _homeController.relatedTeacherList[index]
                                                .isBookmarked ==
                                            1
                                        ? await _homeController
                                            .deleteFavouriteInfo(_homeController
                                                .relatedTeacherList[index]
                                                .userId!
                                                .toString())
                                        : await _homeController
                                            .addFavouriteInfo(_homeController
                                                .relatedTeacherList[index]
                                                .userId!
                                                .toString());
                                  }
                                },
                                reViewLength: _homeController
                                        .relatedTeacherList[index].rating ??
                                    0,
                                name:
                                    '${_homeController.relatedTeacherList[index].firstName ?? ''} ${_homeController.relatedTeacherList[index].lastName ?? ''}',
                                avatar: _homeController
                                    .relatedTeacherList[index].imageId,
                                countryIcon: _homeController
                                    .relatedTeacherList[index].flagUrl,
                                countryName: _homeController
                                    .relatedTeacherList[index].country,
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                isPro: _homeController.relatedTeacherList[index]
                                            .subscription ==
                                        'Free'
                                    ? false
                                    : true,
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                isBookmarked: _homeController
                                            .relatedTeacherList[index]
                                            .isBookmarked ==
                                        1
                                    ? true
                                    : false,
                                subjects: 'Science - Accounts..');
                          },
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: InfoCardVIew(
                          isShowButton: false,
                          title: 'No Other Teachers!',
                          subTitle:
                              'Your preferred teachers are exclusively in your favourite list, no other matches are based on your preferences.',
                          cardColor: AppColors.white,
                          buttonTitle: 'Class Details',
                        ),
                      ),
                    SizedBox(
                      height: 200.px,
                    )
                  ],
                ),
              ),
            ));
    }
  }
}
