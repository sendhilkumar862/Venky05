import 'package:flutter/material.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';

class StudentBottomSheet extends StatelessWidget {
  const StudentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 14,right: 15),
              alignment: Alignment.center,
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                  color: AppColors.appLightGrey, shape: BoxShape.circle),
              child: const AppImageAsset(
                image: ImageConstants.closeIcon,
                height: 20,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              const AppText('Students',
                  fontWeight: FontWeight.w700, fontSize: 14),
              const SizedBox(
                height: 30,
              ),
              SizedBox(height: 560,
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  physics: const BouncingScrollPhysics(),
                  itemCount: 8,
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.appLightGrey),
                      ),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          const AppImageAsset(
                              image: ImageConstants.removeBookmark,
                              height: 18),
                          Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 8,
                              ),
                              const AppImageAsset(
                                image: ImageConstants.avtar,
                                height: 55,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const AppText(
                                'User Name',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const AppText(
                                'Grade 1 - 2 - 3',
                                fontSize: 12,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppButton(
                                title: 'Accept',
                                height: 45,
                                borderColor: AppColors.appBlue,
                                borderRadius: BorderRadius.circular(10),
                                onPressed: () {},
                              ),
                              const SizedBox(height: 22),
                              const AppText(
                                'Reject',
                                fontSize: 14,
                                color: AppColors.appLightRed,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              AppButton(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                title: 'Accept All Students',
                height: 45,
                borderRadius: BorderRadius.circular(10),
                borderColor: AppColors.appBlue,
                onPressed: () {},
              ),

            ],
          )
        ],
      ),
    );
  }
}
