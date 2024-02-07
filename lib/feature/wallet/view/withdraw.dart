import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../product/utils/typography.dart';
import '../../../product/utils/validators.dart';
import '../../classDetails/view/bottomSheetView/booking_bottom_view.dart';
import '../controller/wallet_controller.dart';

class WithDrawScreen extends StatefulWidget {
  const WithDrawScreen({super.key});

  @override
  State<WithDrawScreen> createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController topUp = TextEditingController();
  final WalletController _walletController=Get.put(WalletController());
  bool isDisable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        title: 'Invoice Details',
        isBack: true,
      ),
      body: Form(
        key: formKey,
        onChanged: () {
          if (formKey.currentState!.validate()) {
            setState(() {
              isDisable = false;
            });
          } else {
            setState(() {
              isDisable = true;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: topUp,
                validate: Validators.requiredValidator1.call,
                suffix: Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: Text('KWD', style: openSans.get16.w400),
                ),
                title: 'Top Up Amount',
                hintText: 'Enter top up amount',
              ),
              AppButton(
                  title: 'Top Up',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      constraints: const BoxConstraints(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.px),
                          topLeft: Radius.circular(25.px),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return BookingBottomSheet();
                      },
                    );
                  },
                  isDisable: isDisable)
            ],
          ),
        ),
      ),
    );
  }
}
