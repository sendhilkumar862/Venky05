import 'package:flutter/material.dart';

import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import 'home_views.dart';

class ClassesView extends StatelessWidget {
  const ClassesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: const <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AppText(
                  'Related Classes',
                  fontWeight: FontWeight.w700,
                ),
                Row(
                  children: <Widget>[
                    AppText(
                      'View All',
                      color: AppColors.appColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    AppImageAsset(
                      image: ImageConstants.layersIcon,
                      height: 18,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CardView(),
            SizedBox(
              height: 10,
            ),
            CardView(),
            SizedBox(
              height: 10,
            ),
            CardView(),
            SizedBox(
              height: 10,
            ),
            CardView(),
          ],
        ),
      ),
    );
  }
}
