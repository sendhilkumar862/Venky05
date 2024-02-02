


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/route.dart';
import '../../../core/api_end_points.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/cardView/app_card_view.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/string_extension.dart';
import '../../tutorial/language/controller/language_controller.dart';
import '../../tutorial/language/model/country_model.dart';
import '../controller/home_controller.dart';
import '../model/getClassList.dart';
class ViewAllClass extends StatefulWidget {
  const ViewAllClass({Key? key}) : super(key: key);

  @override
  State<ViewAllClass> createState() => _ViewAlaaClassState();
}

class _ViewAlaaClassState extends State<ViewAllClass> {
  final HomeController _homeController = Get.find();
   final LanguageController _languageController = Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeController.scrollController.addListener(pagination);
  }
  void pagination() async{
    if (_homeController.scrollController.position.pixels ==
        _homeController.scrollController.position.maxScrollExtent) {
      // ignore: avoid_dynamic_calls
      if( Get.arguments['type']==SchoolEndpoint.RELATED_CLASS && _homeController.classRelatedList.length<_homeController.totalRelatedCount ){
        _homeController.relatedPageIndex= _homeController.relatedPageIndex+1;
        // ignore: avoid_dynamic_calls
        await _homeController.getClassList( Get.arguments['type'],_homeController.relatedPageIndex,isReload: true);



        // ignore: avoid_dynamic_calls
      }else  if( Get.arguments['type']==SchoolEndpoint.HISTORY_CLASS && _homeController.classHistoryList.length<_homeController.totalHistoryCount ){
        _homeController.historyPageIndex= _homeController.historyPageIndex+1;
        // ignore: avoid_dynamic_calls
        await _homeController.getClassList( Get.arguments['type'],_homeController.historyPageIndex,isReload: true);

      }
      // ignore: avoid_dynamic_calls
      else  if( Get.arguments['type']==SchoolEndpoint.UPCOMING_CLASS && _homeController.classUpcomingList.length<_homeController.totalUpcomingCount ){
        _homeController.upcomingPageIndex= _homeController.upcomingPageIndex+1;
        // ignore: avoid_dynamic_calls
        await _homeController.getClassList( Get.arguments['type'],_homeController.upcomingPageIndex,isReload: true);

      }
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
        ListView.separated(
          controller: _homeController.scrollController,
          padding: const EdgeInsets.only(
              right: 15, top: 5, bottom: 20, left: 15),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          // ignore: avoid_dynamic_calls
          itemCount:  Get.arguments['type']==SchoolEndpoint.RELATED_CLASS?_homeController.classRelatedList.length:Get.arguments['type']==SchoolEndpoint.UPCOMING_CLASS?_homeController.classUpcomingList.length:_homeController.classHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            // ignore: avoid_dynamic_calls
            final GetClassListModel data=Get.arguments['type']==SchoolEndpoint.RELATED_CLASS?_homeController.classRelatedList[index]:Get.arguments['type']==SchoolEndpoint.UPCOMING_CLASS?_homeController.classUpcomingList[index]:_homeController.classHistoryList[index];
            return SizedBox(
              width: 340.px,
              child: AppCardView(
                proposals: 5,
                cardTitle:
                data.subject,
                date: data.classTime!
                    .toString()
                    .epochToNormal(),
                timer: data.duration
                    .toString()
                    .timeConvert(),
                money:
                "${data.cost ?? ''} ${data.currency ?? ''}",
                status:data.status,
                // isPro: true,
                avtar: data.imageId?.getImageUrl('profile') ,
                countryIcon:  data.country!=null && _languageController.countries.isNotEmpty?_languageController.countries.firstWhere((Country element) => element.name==data.country).flag_url:ImageConstants.countryIcon,
                countryName:  data.country,
                reViewLength: 3,
                teacherName:
                data.name,
                grade: data.grade,
                minParticipants: data.minParticipants,
                maxParticipants: data.maxParticipants,
                buttonTap: () {
                  Get.toNamed(Routes.classDetailsView,
                      arguments: <String, Object?>{'classNumber': _homeController
                          .classRelatedList[index].classNumber,'backIndex':1});
                },
              ),
            );
          },
          separatorBuilder:
              (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
        ),
      ),
    );
  }
}
