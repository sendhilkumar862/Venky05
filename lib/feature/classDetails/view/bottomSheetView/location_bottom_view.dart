import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../custom/divider/divider.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';

class SelectLocationBottomSheet extends StatelessWidget {
  const SelectLocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.px, right: 15.px),
      height: (MediaQuery.of(context).size.height * 0.80).px,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.px),
          topRight: Radius.circular(30.px),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(top: 14.px),
              alignment: Alignment.center,
              height: 25.px,
              decoration: const BoxDecoration(
                  color: AppColors.appLightGrey, shape: BoxShape.circle),
              width: 25.px,
              child: AppImageAsset(
                image: ImageConstants.closeIcon,
                height: 20.px,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 28.px,
              ),
              AppText(
                'Select Class Location',
                fontSize: 14.px,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 22.px,
              ),
              Container(
                height: 50.px,
                padding: EdgeInsets.only(left: 15.px),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.px),
                  border: Border.all(width: 1.3.px, color: AppColors.lightPurple),
                ),
                child: AppText(
                  'Keep at the teacher location',
                  fontSize: 14.px,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 3.px,
              ),
              AppDivider(),
              SizedBox(
                height: 3.px,
              ),
              addressCardView(
                  title: 'Home',
                  subtitle:
                  'City, Block No., Street Name, Street Name 2, House No., Floor No., Apartment No.',
                  isDefault: true),
              SizedBox(
                height: 13.px,
              ),
              addressCardView(
                  title: 'Home',
                  subtitle:
                  'City, Block No., Street Name, Street Name 2, House No., Floor No., Apartment No.',
                  isDefault: false),
              SizedBox(
                height: 10.px,
              ),
              AppDivider(),
              SizedBox(
                height: 25.px,
              ),
              AppButton(
                borderColor: AppColors.appBlue,
                height: 45.px,
                title: 'Select',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    constraints: BoxConstraints(
                      maxWidth: (MediaQuery.of(context).size.width - 30).px,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.px),
                    ),
                    builder: (BuildContext context) {
                      return SuccessFailsInfoDialog(
                        title: 'Success',
                        buttonTitle: 'Done',
                        content:
                        'You have successfully booked your class, and you will get a notification to pay after the teacher accepts the class.',
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 30.px,
              ),
              InkWell(
                onTap: () {},
                child: AppText(
                  'Add New Address',
                  fontSize: 14.px,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBlue,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget circleButtonView(
      {Widget? widget, Color? color, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.px),
        height: 30.px,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.px), color: color),
        child: widget,
      ),
    );
  }

  Widget addressCardView(
      {String? title, String? subtitle, bool? isDefault}) {
    return Container(
      padding: EdgeInsets.all(15.px),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.px),
        border: Border.all(
            width: 1.3.px,
            color: (isDefault!) ? AppColors.appBlue : AppColors.lightPurple),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AppText(
                title ?? '',
                fontSize: 14.px,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                width: 4.px,
              ),
              if (isDefault)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightPurple,
                    borderRadius: BorderRadius.circular(30.px),
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 5.px, vertical: 3.px),
                  child: AppText(
                    'Default',
                    fontSize: 10.px,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              const Spacer(),
              if (isDefault)
                AppImageAsset(
                  image: ImageConstants.acceptedStatus,
                  height: 22.px,
                  color: AppColors.appBlue,
                )
            ],
          ),
          SizedBox(
            height: 10.px,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 260.px,
              child: AppText(
                subtitle ?? '',
                fontSize: 10.px,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
            height: 15.px,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              circleButtonView(
                  onTap: () {},
                  widget: const AppImageAsset(
                    image: ImageConstants.deleteIcon,
                  ),
                  color: AppColors.appBlue),
              SizedBox(
                width: 11.px,
              ),
              circleButtonView(
                  onTap: () {},
                  widget: const AppImageAsset(
                    image: ImageConstants.editIcon,
                  ),
                  color: AppColors.appLightRed),
              if (!isDefault)
                SizedBox(
                  width: 11.px,
                ),
              if (!isDefault)
                circleButtonView(
                    onTap: () {},
                    widget: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.px),
                      child: AppText('Set Default',
                          color: AppColors.appWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.px),
                    ),
                    color: AppColors.appBlue),
            ],
          )
        ],
      ),
    );
  }
}
