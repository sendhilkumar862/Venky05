import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../custom/app_button/app_button.dart';
import '../../custom/app_textformfield/app_field.dart';
import '../../custom/appbar/appbar.dart';
import '../../custom/dialog/success_fail_dialog.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/typography.dart';

class FinancingView extends StatefulWidget {
  const FinancingView({super.key});

  @override
  State<FinancingView> createState() => _FinancingViewState();
}

class _FinancingViewState extends State<FinancingView> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: HessaAppBar(
        trailingText: 'cancel'.tr(),
        title: 'completeProfile'.tr(),
        isTitleOnly: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text('financing'.tr(),
                          style: openSans.get20.w700
                              .textColor(AppColors.appTextColor)),
                    ),
                    AppTextFormField(
                      title: 'enterIBANNumber'.tr(),
                      hintText: 'enterIBANNumber'.tr(),
                    ),
                    AppTextFormField(
                      title: 'bankAccountNickname'.tr(),
                      hintText: 'enterNickname'.tr(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 40),
                        height: 64,
                        width: width,
                        decoration: BoxDecoration(
                            color: AppColors.lightPurpleTwo,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: Icon(Icons.info,
                                  size: 25, color: AppColors.downArrowColor),
                            ),
                            Expanded(
                              child: Text(
                                'IBANNumberIsNeeded'.tr(),
                                style: openSans.get12.w400.appTextColor,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppButton(
                title: 'completeYourProfile'.tr(),
                onPressed: () {
                  successBottomSheet(context);
                },
                isDisable: false)
          ],
        ),
      ),
    );
  }

  Future<void> successBottomSheet(BuildContext context) {
    return showModalBottomSheet(
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
          title: 'success'.tr(),
          buttonTitle: 'done'.tr(),
          content: 'successMsg'.tr(),
        );
      },
    );
  }
}
