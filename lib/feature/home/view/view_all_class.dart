


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

class ViewAlaaClass extends StatelessWidget {
   ViewAlaaClass({super.key});
  final HomeController _homeController = Get.find();
   final LanguageController _languageController = Get.find();
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
      body: ListView.separated(
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
    );
  }
}
