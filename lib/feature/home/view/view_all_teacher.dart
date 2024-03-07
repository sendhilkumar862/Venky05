import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/api_end_points.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/details_card_view.dart';
import '../../../product/constants/image/image_constants.dart';
import '../controller/home_controller.dart';
class ViewAllTeacher extends StatefulWidget {
  const ViewAllTeacher({super.key});

  @override
  State<ViewAllTeacher> createState() => _ViewAllTeacherState();
}

class _ViewAllTeacherState extends State<ViewAllTeacher> {

  FavouritesEndPoint classType= FavouritesEndPoint.Favourites;
  final HomeController _homeController = Get.put(HomeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    // ignore: avoid_dynamic_calls
    classType=Get.arguments['type'];
    _homeController.scrollController.addListener(pagination);
  }

  void pagination() async{
     if( classType==FavouritesEndPoint.Favourites && _homeController.favouritesList.length<_homeController.totalFavouriteCount ){
    _homeController.favouritePageIndex= _homeController.favouritePageIndex+1;
    // ignore: avoid_dynamic_calls
    await _homeController.getFavouriteInfo(_homeController.favouritePageIndex,isReload: true);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:HessaAppBar(
        // ignore: avoid_dynamic_calls
          title: Get.arguments['title'],
          isTitleOnly: true,
          leadingTap: () {
            // ignore: avoid_dynamic_calls
            Get.back();
          }),
      body: Obx(()=>
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.300,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.px),
              physics: const BouncingScrollPhysics(),
              itemCount: _homeController.favouritesList.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.px,
                  mainAxisSpacing: 10.px,
                  childAspectRatio:
                  _homeController.childAspectRatio.value),
              itemBuilder: (BuildContext context, int index) {

                return DetailsCardView(
                    reViewLength: _homeController.favouritesList[index].rating??0,
                    name: '${_homeController.favouritesList[index].firstName??''} ${_homeController.favouritesList[index].lastName??''}',
                    avatar: ImageConstants.teacherAvtar,
                    countryIcon: _homeController.favouritesList[index].flagUrl,
                    countryName: _homeController.favouritesList[index].country,
                    // ignore: avoid_bool_literals_in_conditional_expressions
                    isPro: _homeController.favouritesList[index].subscription=='Free'?false:true,
                    isBookmarked: true,
                    subjects: 'Science - Accounta..');
              },
            ),
          )
      ),
    );
  }
}
