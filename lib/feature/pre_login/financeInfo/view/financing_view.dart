import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';
import '../controller/finance_info_controller.dart';

class FinancingView extends StatefulWidget {
  const FinancingView({super.key});

  @override
  State<FinancingView> createState() => _FinancingViewState();
}

class _FinancingViewState extends State<FinancingView> {
  final FinanceInfoController _financeInfoController =
      Get.put(FinanceInfoController());
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: HessaAppBar(
        trailingText: 'Cancel',
        title: 'Complete Profile',
        isTitleOnly: true,
        trailingTap: () => Navigator.popUntil(
            context, ModalRoute.withName(Routes.HomeScreenRoute)),
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
                    TextFormsField(
                      controller: _financeInfoController.ibanController,
                      title: 'Enter IBAN Number',
                      hintText: 'Enter IBAN Number',
                      errorText: _financeInfoController.ibanError.value,
                      onChanged: (String value) {
                        setState(() {
                          _financeInfoController.validateIBAN(value);
                        });
                      },
                      inputFormatters: [
                        IBANTextInputFormatter(),
                      ],
                    ),
                    AppTextFormField(
                      controller: _financeInfoController.nickNameController,
                      title: 'Bank Account Nickname',
                      hintText: 'Enter nickname',
                      onChanged: (String value) {
                        setState(() {
                          _financeInfoController.validateIBAN(value);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 40),
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
                onPressed: () async {
                  if (_financeInfoController.ibanController.text.isNotEmpty &&
                      _financeInfoController
                          .nickNameController.text.isNotEmpty) {
                    final bool status =
                        await _financeInfoController.financeInformationUpdate();
                    if (status) {
                      successBottomSheet(context);
                    }
                  }
                },
                isDisable:
                    _financeInfoController.ibanController.text.isNotEmpty &&
                            _financeInfoController
                                .nickNameController.text.isNotEmpty
                        ? false
                        : true)
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
          title: 'Success',
          buttonTitle: 'Done',
          content:
              "You have successfully submitted your profile information, and your account is pending for review.\n\nOnce approved, you'll be ready to commence teaching.\n\nWe'll notify you soon!.",
        );
      },
    ).whenComplete(() {
      Navigator.popUntil(context, ModalRoute.withName(Routes.HomeScreenRoute));
    });
  }
}
