import 'package:flutter/material.dart';

import '../../custom/app_button/app_button.dart';
import '../../custom/app_textformfield/app_field.dart';
import '../../custom/appbar/appbar.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/typography.dart';

class FinancingView extends StatefulWidget {
  const FinancingView({Key? key}) : super(key: key);

  @override
  State<FinancingView> createState() => _FinancingViewState();
}

class _FinancingViewState extends State<FinancingView> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: HessaAppBar(
        isBack: true,
        trailingText: 'Cancel',
        title: 'Complete Profile',
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
                      child: Text('Financing',
                          style: openSans.get20.w700
                              .textColor(AppColors.appTextColor)),
                    ),
                    const AppTextFormField(
                      title: 'Enter IBAN Number',
                      hintText: 'Enter IBAN Number',
                    ),
                    const AppTextFormField(
                      title: 'Bank Account Nickname',
                      hintText: 'Enter nickname',
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
                                'IBAN number is needed to receive your classes income.',
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
                title: 'Complete Your Profile',
                onPressed: () {},
                isDisable: false)
          ],
        ),
      ),
    );
  }
}
