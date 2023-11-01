import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: MediaQuery.of(context).size.height * 0.80,
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
              margin: const EdgeInsets.only(top: 14),
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
                height: 28,
              ),
              const AppText(
                'Select Class Location',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1.3, color: AppColors.lightPurple),
                ),
                child: const AppText(
                  'Keep at the teacher location',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const AppDivider(),
              const SizedBox(
                height: 3,
              ),
              addressCardView(
                  title: 'Home',
                  subtitle:
                  'City, Block No., Street Name, Street Name 2, House No., Floor No., Apartment No.',
                  isDefault: true),
              const SizedBox(
                height: 13,
              ),
              addressCardView(
                  title: 'Home',
                  subtitle:
                  'City, Block No., Street Name, Street Name 2, House No., Floor No., Apartment No.',
                  isDefault: false),
              const SizedBox(
                height: 10,
              ),
              const AppDivider(),
              const SizedBox(
                height: 25,
              ),
              AppButton(
                borderColor: AppColors.appBlue,
                height: 45,
                title: 'Select',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 30,
                      // here increase or decrease in width
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    builder: (BuildContext context) {
                      return SuccessFailsInfoDialog(
                        title: 'Success',
                        buttonTitle: 'Done',
                        content:
                        'You have successfully booked your class, and you will get notification to pay after the teacher accept the class.',
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {},
                child: const AppText(
                  'Add New Address',
                  fontSize: 14,
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

  Widget circleButtonView({Widget? widget, Color? color, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: color),
        child: widget,
      ),
    );
  }

  Widget addressCardView({
    String? title,
    String? subtitle,
    bool? isDefault,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            width: 1.3,
            color: (isDefault!) ? AppColors.appBlue : AppColors.lightPurple),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AppText(
                title ?? '',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                width: 4,
              ),
              if (isDefault)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightPurple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: const AppText(
                    'Default',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              const Spacer(),
              if (isDefault)
                const AppImageAsset(
                  image: ImageConstants.acceptedStatus,
                  height: 22,
                  color: AppColors.appBlue,
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 260,
              child: AppText(
                subtitle ?? '',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
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
              const SizedBox(
                width: 11,
              ),
              circleButtonView(
                  onTap: () {},
                  widget: const AppImageAsset(
                    image: ImageConstants.editIcon,
                  ),
                  color: AppColors.appLightRed),
              if (!isDefault)
                const SizedBox(
                  width: 11,
                ),
              if (!isDefault)
                circleButtonView(
                    onTap: () {},
                    widget: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: AppText('Set Default',
                          color: AppColors.appWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                    color: AppColors.appBlue),
            ],
          )
        ],
      ),
    );
  }
}
