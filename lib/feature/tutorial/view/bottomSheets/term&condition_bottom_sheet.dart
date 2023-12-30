import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../password/controller/password_controller.dart';


class TermAndConditionBottomSheet extends StatelessWidget {
  TermAndConditionBottomSheet({ super.key});


  final PasswordController _passwordController=Get.find();
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
        children: <Widget>[
          ListView(
            children: <Widget>[
              SizedBox(
                height: 25.px,
              ),
              Align(
                alignment: Alignment.center,
                child: AppText(
                  'Terms & Conditions',
                  fontWeight: FontWeight.w700,
                  fontSize: 14.px,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30.px,
              ),
              ListView.separated(shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppText(
                          _passwordController
                              .termAndConditionModel.value[index].title
                              .toString(),
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.start,
                        ),
                        AppText(
                          _passwordController
                              .termAndConditionModel.value[index].content
                              .toString(),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10.px);
                  },
                  itemCount:_passwordController
                      .termAndConditionModel.value.length)
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 14.px,
              ),
              alignment: Alignment.center,
              height: 25.px,
              width: 25.px,
              decoration: const BoxDecoration(
                  color: AppColors.appLightGrey, shape: BoxShape.circle),
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
