import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../profileSet/model/about_model.dart';
import '../../profileSet/viewModel/profile_view_model.dart';

class AboutAppBottomSheet extends StatelessWidget {
  AboutAppBottomSheet({this.data, super.key});

  List<AboutModel>? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: (MediaQuery.of(context).size.height * 0.80).px,
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.px),
          topRight: Radius.circular(30.px),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.px),
            children: <Widget>[
              SizedBox(
                height: 25.px,
              ),
              Align(
                alignment: Alignment.center,
                child: AppText(
                  'About Hessah',
                  fontWeight: FontWeight.w700,
                  fontSize: 14.px,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30.px,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (index == 0 || index == 2)
                        AppText(
                          data![index].role ?? '',
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.px,
                        ),
                      const SizedBox(
                        height: 4,
                      ),
                      AppText(
                        data![index].title ?? '',
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        data![index].content ?? '',
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 12.px)
                    ],
                  );
                },
              )
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: 14.px, right: 15.px),
              alignment: Alignment.center,
              height: 25.px,
              width: 25.px,
              decoration: const BoxDecoration(color: AppColors.appLightGrey, shape: BoxShape.circle),
              child: AppImageAsset(
                image: ImageConstants.closeIcon,
                height: 20.px,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
