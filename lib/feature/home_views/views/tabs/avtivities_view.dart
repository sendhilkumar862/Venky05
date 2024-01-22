

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/route.dart';

import '../../../../custom/cardView/app_card_view.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../custom/cardView/info_card_view_horizontal.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/extension/string_extension.dart';
import '../../../home/controller/home_controller.dart';
import 'classes_view.dart';
class ActivitiesView extends StatefulWidget {
  const ActivitiesView({Key? key}) : super(key: key);

  @override
  State<ActivitiesView> createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView> {
  String selectedProfile = '';
  String selectedUserStatus = '';
  bool isPending = false;
  final HomeController _homeController=Get.find();

  @override
  void initState() {
    super.initState();
    selectedProfile = LocaleManager.getValue(StorageKeys.profile) ??'';
  }

  @override
  Widget build(BuildContext context) {
   return  Obx( () {
     if(_homeController.homeData.value!=null){
       if (_homeController.homeData.value?.userStatus !='99' ) {
         return const ClassesView();
       }
       else {
         return Expanded(
           child: ListView(
             children: <Widget>[
               SizedBox(height: 20.px),
           Obx(() => _homeController.classActivityList.isEmpty?
                Padding(
                 padding: EdgeInsets.only( right: 8.px, bottom: 10.px, left: 8.px),
                 child: InfoCardVIew(
                   isShowButton: true,
                   title: 'No Activities Found!',
                   subTitle:
                   "You don't have any pending activities that require your action. If there are scheduled classes or new proposals for the classes you created, etc...\nyou will find them here.",
                   cardColor: AppColors.white,
                   buttonTitle: 'Create New Class',
                   buttonTap: () {
                     Get.toNamed(Routes.createClass);
                     // AppRouter.pushNamed(Routes.createClass);
                   },
                 ),
               ) :
           SizedBox(
                 width: MediaQuery.of(context).size.height * 0.90,
                 child: ListView.separated(
                   padding: EdgeInsets.only(
                       right: 15.px, top: 2.px, bottom: 40.px, left: 15.px),
                   shrinkWrap: true,
                   physics: const BouncingScrollPhysics(),
                   itemCount:  _homeController.classActivityList.length,
                   itemBuilder: (BuildContext context, int index) {
                     return  AppCardView(
                       proposals: 5,
                       cardTitle:
                       _homeController.classActivityList[index].subject,
                       date: _homeController
                           .classActivityList[index].classTime!
                           .toString()
                           .epochToNormal(),
                       timer: _homeController.classActivityList[index].duration
                           .toString()
                           .timeConvert(),
                       money:
                       "${_homeController.classActivityList[index].cost ?? ''} ${_homeController.classActivityList[index].currency ?? ''}",
                       status: _homeController.classActivityList[index].status,
                       // isPro: true,
                       avtar: ImageConstants.teacherAvtar,
                       countryIcon: ImageConstants.countryIcon,
                       countryName: 'Kuwait',
                       reViewLength: 3,
                       teacherName:
                       _homeController.classActivityList[index].name,
                       grade: _homeController.classActivityList[index].grade,
                       minParticipants: _homeController
                           .classActivityList[index].minParticipants,
                       maxParticipants: _homeController
                           .classActivityList[index].maxParticipants,
                       buttonTap: () {
                         Get.toNamed(Routes.classDetailsView,
                             arguments: <String, Object?>{'classNumber': _homeController
                                 .classActivityList[index].classNumber,'backIndex':1});
                       },
                     );
                   },
                   separatorBuilder: (BuildContext context, int index) {
                     return SizedBox(
                       height: 20.px,
                     );
                   },
                 ),
               ),)

             ],
           ),
         );
       }}else{
       return const SizedBox.shrink();
     } },);}

  }


