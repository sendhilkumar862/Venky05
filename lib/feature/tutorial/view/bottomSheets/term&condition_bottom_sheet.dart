import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../password/view/password_view.dart';
import '../../password/viewModel/password_view_model.dart';
import '../../viewModel/tutorial_view_model.dart';

class TermAndConditionBottomSheet extends StatelessWidget {
  TermAndConditionBottomSheet({this.passwordViewModel, super.key});

  PasswordViewModel? passwordViewModel;

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
                          passwordViewModel!
                              .termAndConditionModel.data!.items![index].title
                              .toString(),
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.start,
                        ),
                        AppText(
                          passwordViewModel!
                              .termAndConditionModel.data!.items![index].content
                              .toString(),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10.px);
                  },
                  itemCount:passwordViewModel!
                      .termAndConditionModel.data!.items!.length)
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
