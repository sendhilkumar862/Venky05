import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/api_end_points.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/details_card_view.dart';
import '../../../custom/cardView/details_card_view_student.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../controller/home_controller.dart';
import '../model/favourites_students_data_model.dart';
import '../model/favourites_teacher_data_model.dart';

class ViewAllTeacher extends StatefulWidget {
  const ViewAllTeacher({super.key});

  @override
  State<ViewAllTeacher> createState() => _ViewAllTeacherState();
}

class _ViewAllTeacherState extends State<ViewAllTeacher> {
  FavouritesEndPoint classType = FavouritesEndPoint.Favourites;
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // ignore: avoid_dynamic_calls
    classType = Get.arguments['type'];
    _homeController.scrollController.addListener(pagination);
  }

  Future<void> pagination() async {
    if (classType == FavouritesEndPoint.Favourites &&
        (_homeController.selectedProfile == ApplicationConstants.student
            ? (_homeController.favouritesTeacherList.length <
                _homeController.totalFavouriteCount)
            : (_homeController.favouritesStudentList.length <
                _homeController.totalFavouriteCount))) {
      _homeController.favouritePageIndex =
          _homeController.favouritePageIndex + 1;
      // ignore: avoid_dynamic_calls
      await _homeController.getFavouriteStudentTeacherList(
          _homeController.favouritePageIndex,
          isReload: true);
    } else if (classType == FavouritesEndPoint.Related &&
        (_homeController.selectedProfile == ApplicationConstants.student
            ? (_homeController.relatedTeacherList.length <
                _homeController.totalRelatedStudentTeacherCount)
            : (_homeController.relatedStudentList.length <
                _homeController.totalRelatedStudentTeacherCount))) {
      _homeController.totalRelatedStudentTeacherPageIndex =
          _homeController.totalRelatedStudentTeacherPageIndex + 1;
      // ignore: avoid_dynamic_calls
      await _homeController.getRelatedStudentTeacherList(
          _homeController.favouritePageIndex,
          isReload: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
          // ignore: avoid_dynamic_calls
          title: Get.arguments['title'],
          isTitleOnly: true,
          leadingTap: () {
            // ignore: avoid_dynamic_calls
            Get.back();
          }),
      body: Obx(
          () => _homeController.selectedProfile == ApplicationConstants.student
              ? GridView.builder(
                  controller: _homeController.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 15.px),
                  physics: const BouncingScrollPhysics(),
                  itemCount: classType == FavouritesEndPoint.Favourites
                      ? _homeController.favouritesTeacherList.length
                      : _homeController.relatedTeacherList.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.px,
                      mainAxisSpacing: 10.px,
                      childAspectRatio: _homeController.childAspectRatio.value),
                  itemBuilder: (BuildContext context, int index) {
                    final FavouritesTeacherModel data =
                        classType == FavouritesEndPoint.Favourites
                            ? _homeController.favouritesTeacherList[index]
                            : _homeController.relatedTeacherList[index];
                    return DetailsCardView(
                        onTap: ()async{
                          (data.isBookmarked==1||data.isBookmarked==null)?await _homeController.deleteFavouriteInfo(data.userId!.toString()):await _homeController.addFavouriteInfo(data.userId!.toString());
                        },
                        reViewLength: data.rating ?? 0,
                        name: '${data.firstName ?? ''} ${data.lastName ?? ''}',
                        avatar: data.imageId,
                        countryIcon: data.flagUrl,
                        countryName: data.country,
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        isPro: data.subscription == 'Free' ? false : true,
                        isBookmarked: true,
                        subjects: 'Science - Accounta..');
                  },
                )
              : GridView.builder(
                  controller: _homeController.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 15.px),
                  physics: const BouncingScrollPhysics(),
                  itemCount: classType == FavouritesEndPoint.Favourites
                      ? _homeController.favouritesStudentList.length
                      : _homeController.relatedStudentList.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.px,
                      mainAxisSpacing: 10.px,
                      childAspectRatio: _homeController.childAspectRatio.value),
                  itemBuilder: (BuildContext context, int index) {
                    final FavouriteStudentModel data =
                        classType == FavouritesEndPoint.Favourites
                            ? _homeController.favouritesStudentList[index]
                            : _homeController.relatedStudentList[index];
                    return DetailsCardViewStudent(
                      onTap: ()async{
                        (data.isBookmarked==1||data.isBookmarked==null)?await _homeController.deleteFavouriteInfo(data.userId!.toString()):await _homeController.addFavouriteInfo(data.userId!.toString());
                      },
                        name: data.name ?? '',
                        avatar: data.imageId,
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        isBookmarked: (data.isBookmarked==null||data.isBookmarked==1)?true:false,
                        grades: 'Grade ${data.grade?.join(' - ')}');
                  },
                )),
    );
  }
}
