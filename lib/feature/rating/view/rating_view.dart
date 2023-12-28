import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';


class RatingView extends StatefulWidget {
  const RatingView({super.key});

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> with TickerProviderStateMixin {
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
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              const AppText(
                'What do you rate educational skills for Mr. “Name”?',
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
                onRatingUpdate: (double rating) {},
              ),
              const SizedBox(
                height: 27,
              ),
              const AppText(
                'What do you rate educational skills for Mr. “Name”?',
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
                onRatingUpdate: (double rating) {},
              ),
              const SizedBox(
                height: 27,
              ),
              const AppText(
                'What do you rate educational skills for Mr. “Name”?',
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
                onRatingUpdate: (double rating) {},
              ),
              const SizedBox(
                height: 27,
              ),
              const AppText(
                'What do you rate educational skills for Mr. “Name”?',
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
                onRatingUpdate: (double rating) {},
              ),
              const SizedBox(
                height: 25,
              ),
              const Spacer(),
              AppButton(
                title: 'Submit Your Rating',
                borderColor: AppColors.appBlue,
                onPressed: () {},
              ),
              const SizedBox(height: 30)
            ],
          ),
        ));
  }
}
