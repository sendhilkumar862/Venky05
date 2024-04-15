import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/common_dropdown/app_dropdown.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/typography.dart';
import '../controller/rating_controller.dart';
import '../model/review_rating_model.dart';


class RatingView extends StatefulWidget {
  const RatingView({super.key});

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> with TickerProviderStateMixin {
     final RatingController _ratingController =
      Get.put(RatingController());
      
  @override
  void initState() {
    super.initState();
    _ratingController.onInit();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppColors.appWhite,
        appBar: HessaAppBar(
          icon: ImageConstants.avtar,
          title: 'Class Details',
          isTitleOnly: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: <Widget>[
                Obx(() => AppDropdown(
                      options: _ratingController.sessionNumber.value,
                      title: 'Session',
                      hintStyle:openSans.w400
                              .textColor(
                                  AppColors.appTextColor.withOpacity(0.25))
                              .get14,
                      value: '',
                      hintText: 'Select Sessionn',
                      onChanged: (String? id) {
                          final ReviewSessionModal selectedSession = _ratingController.fullSessionRecord.where((p0) => p0.sessionNo.toString()==id?.replaceAll("Session - ", "")).toList()[0];
                          _ratingController.session_id.value=selectedSession.sessionId.toString();
                      },
                    ),),
              const SizedBox(
                height: 20,
              ),
               AppText(
                'What do you rate educational skills for Mr. ${Get.arguments['teacherName']}?',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 8,
              ),
              RatingBar(
                itemSize: 35,
                ratingWidget: RatingWidget(
                  full: const AppImageAsset(
                    image: ImageConstants.starBlue,
                  ),
                  half: const AppImageAsset(
                    image: ImageConstants.starBlue,
                  ),
                  empty: const AppImageAsset(
                    image: ImageConstants.starGrey,
                  ),
                ),
                itemPadding:
                const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (double rating) {
                   _ratingController.educational_skills.value='$rating';
                },
              ),
              const SizedBox(
                height: 27,
              ),
               AppText(
                'What do you rate friendliness of Teacher ${Get.arguments['teacherName']}?',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 8,
              ),
              RatingBar(
                itemSize: 35,
                ratingWidget: RatingWidget(
                  full: const AppImageAsset(
                    image: ImageConstants.starBlue,
                  ),
                  half: const AppImageAsset(
                    image: ImageConstants.starBlue,
                  ),
                  empty: const AppImageAsset(
                    image: ImageConstants.starGrey,
                  ),
                ),
                itemPadding:
                const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (double rating) {
                   _ratingController.friendliness.value='$rating';
                },
              ),
              const SizedBox(
                height: 27,
              ),
               AppText(
                'Did Teacher ${Get.arguments['teacherName']} arrive on time?',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 8,
              ),
              RatingBar(
                itemSize: 35,
                ratingWidget: RatingWidget(
                  full: const AppImageAsset(
                    image: ImageConstants.starBlue,
                  ),
                  half: const AppImageAsset(
                    image: ImageConstants.starBlue,
                  ),
                  empty: const AppImageAsset(
                    image: ImageConstants.starGrey,
                  ),
                ),
                itemPadding:
                const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (double rating) {
                   _ratingController.ontime_arrival.value='$rating';
                },
              ),
              const SizedBox(
                height: 27,
              ),
               AppText(
                'What is the Teacher ${Get.arguments['teacherName']} overall rating?',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 8,
              ),
              RatingBar(
                itemSize: 35,
                ratingWidget: RatingWidget(
                  full: const AppImageAsset(
                    image: ImageConstants.starBlue,
                  ),
                  half: const AppImageAsset(
                    image: ImageConstants.starBlue,
                  ),
                  empty: const AppImageAsset(
                    image: ImageConstants.starGrey,
                  ),
                ),
                itemPadding:
                const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (double rating) {
                  _ratingController.overall_rating.value='$rating';
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Spacer(),
             Obx(() =>  AppButton(
                isDisable: _ratingController.session_id.isEmpty||_ratingController.educational_skills.isEmpty||_ratingController.friendliness.isEmpty||_ratingController.ontime_arrival.isEmpty||_ratingController.overall_rating.isEmpty,
                title: 'Submit Your Rating',
                borderColor: AppColors.appBlue,
                onPressed: _ratingController.submittingReview,
              ),),
              const SizedBox(height: 30)
            ],
          ),
        ));
  }
}
