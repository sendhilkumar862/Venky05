

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/route.dart';

import '../../../../core/api_end_points.dart';
import '../../../../custom/cardView/app_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../product/cache/key_value_storage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/extension/string_extension.dart';
import '../../../home/controller/home_controller.dart';
import '../../../tutorial/language/controller/language_controller.dart';
import '../../../tutorial/language/model/country_model.dart';
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
  final LanguageController _languageController = Get.put(LanguageController());

  @override
  void initState() {
    super.initState();
    selectedProfile = LocaleManager.getValue(StorageKeys.profile) ??'';
    _homeController.scrollController.addListener(pagination);
  }

  void pagination() async{
    if (_homeController.scrollController.position.pixels ==
        _homeController.scrollController.position.maxScrollExtent) {
      // ignore: avoid_dynamic_calls
      if(  _homeController.classActivityList.length<_homeController.totalActivityCount ){
        _homeController.activityPageIndex= _homeController.activityPageIndex+1;
        // ignore: avoid_dynamic_calls
        await _homeController.getClassList( SchoolEndpoint.ACTIVITY_CLASS,_homeController.activityPageIndex,isReload: true);
    }}}

  @override
  Widget build(BuildContext context) {
   return  Obx( () {
     if(_homeController.homeData.value!=null){
       if (_homeController.homeData.value?.userStatus !='99' ) {
         return const ClassesView();
       }
       else {
         return Expanded(
           child: Column(
             children: <Widget>[
               SizedBox(height: 20.px),
            if (_homeController.classActivityList.isEmpty)
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
               ) else
                 SizedBox(

                 height: MediaQuery.of(context).size.height*.7,
                 child: ListView.separated(
                   controller:  _homeController.scrollController,
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
                       isBook: false,
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
                       avtar: _homeController.classActivityList[index].imageId?.getImageUrl('profile'),
                       countryIcon: _homeController.classActivityList[index].country!=null && _languageController.countries.isNotEmpty?_languageController.countries.firstWhere((Country element) => element.name==_homeController.classActivityList[index].country).flag_url:ImageConstants.countryIcon,
                       countryName: _homeController.classActivityList[index].country??'',
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
               ),

             ],
           ),
         );
       }}else{
       return const SizedBox.shrink();
     } },);}

  }


