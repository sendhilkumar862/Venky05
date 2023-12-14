import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';
import '../viewmodel/financing_view_model.dart';

class FinancingView extends StatefulWidget {
  const FinancingView({super.key});

  @override
  State<FinancingView> createState() => _FinancingViewState();
}

class _FinancingViewState extends State<FinancingView> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
     return BaseView<FinancingViewModel>(
        viewModel: FinancingViewModel(),
        onModelReady: (FinancingViewModel model, WidgetRef ref) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, FinancingViewModel financingViewModel, WidgetRef ref) {
          return Scaffold(
      appBar: HessaAppBar(
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
                      child: Text('Financing', style: openSans.get20.w700.textColor(AppColors.appTextColor)),
                    ),
                    TextFormsField(
                      controller: financingViewModel.ibanController,
                      title: 'Enter IBAN Number',
                      hintText: 'Enter IBAN Number',
                      errorText: financingViewModel.ibanError,
                        onChanged: (String value) {
                          financingViewModel.validateIBAN(value);
                        },
                    ),
                     AppTextFormField(
                      controller: financingViewModel.nickNameController,
                      title: 'Bank Account Nickname',
                      hintText: 'Enter nickname',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 40),
                        height: 64,
                        width: width,
                        decoration:
                            BoxDecoration(color: AppColors.lightPurpleTwo, borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: Icon(Icons.info, size: 25, color: AppColors.downArrowColor),
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
                onPressed: () {
                  successBottomSheet(context);
                },
                isDisable: false)
          ],
        ),
      ),
    );
        });
    
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
          title: 'Success',
          buttonTitle: 'Done',
          content:
              "You have successfully submitted your profile information, and your account is pending for review.\n\nOnce approved, you'll be ready to commence teaching.\n\nWe'll notify you soon!.",
        );
      },
    );
  }

}
