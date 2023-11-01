import 'package:flutter/material.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';
import 'heading_card_view.dart';

class DetailsCardViewHorizontal extends StatelessWidget {
  DetailsCardViewHorizontal({
    this.countryIcon,
    this.reViewLength,
    this.countryName,
    this.name,
    this.avatar,
    this.isPro,
    this.subjects,
    this.isShowViewAll,
    this.heading,
    this.isBookmarked,
    super.key,
  });

  num? reViewLength;
  String? avatar;
  String? name;
  bool? isPro;
  bool? isShowViewAll;
  bool? isBookmarked;
  String? countryIcon;
  String? countryName;
  String? subjects;
  String? heading;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        height: 124,
        decoration: BoxDecoration(
            color: AppColors.appWhite,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
                color: AppColors.appBorderColor.withOpacity(0.3),
                width: 1.2),
            boxShadow: AppColors.infoBoxShadow),
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Column(
                    children: [
                      const AppImageAsset(
                        image: ImageConstants.teacherAvtar,
                        height: 55,
                      ),
                      SizedBox(
                        height: 20,
                        width: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return AppImageAsset(
                              image: (index < reViewLength!)
                                  ? ImageConstants.reviewStarPurple
                                  : ImageConstants.reviewStar,
                              height: 10,
                              width: 10,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <InlineSpan>[
                            const TextSpan(
                              text: 'Mr. ',
                              style: TextStyle(
                                color: AppColors.appDarkBlack,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: name ?? ''!,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.appDarkBlack,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      if (isPro ?? false!)
                        const SizedBox(
                          height: 4,
                        ),
                      if (isPro ?? false!)
                        Container(
                          width: 50,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 8),
                          decoration: BoxDecoration(
                            color: AppColors.appDarkBlack,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AppImageAsset(
                                image: ImageConstants.proIcon,
                                height: 10,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              AppText(
                                'Pro',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.appYellow,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppImageAsset(
                            image: countryIcon ?? ''!,
                            height: 13,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          AppText(
                            countryName ?? ''!,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )
                        ],
                      ),
                      const Spacer(),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(subjects ?? ''!, fontSize: 12),
                          const AppText('+2', fontSize: 12),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ],
              ),
            ),
            AppImageAsset(
              image: (isBookmarked ?? false)
                  ? ImageConstants.removeBookmark
                  : ImageConstants.doBookmark,
              height: 22,
            ),
          ],
        ));

  }
}
