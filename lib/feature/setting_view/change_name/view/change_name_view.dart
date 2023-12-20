
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/utils/validators.dart';
import '../viewModel/change_name_view_model.dart';

class ChangeNameView extends StatefulWidget {
  const ChangeNameView({super.key});

  @override
  State<ChangeNameView> createState() => _ChangeNameViewState();
}

class _ChangeNameViewState extends State<ChangeNameView> {
  final formKey = GlobalKey<FormState>();
  bool isDisable = true;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<ChangeNameViewModel>(
        viewModel: ChangeNameViewModel(),
        onModelReady: (ChangeNameViewModel changeNameViewModel) {
          changeNameViewModel.setContext(context);
          changeNameViewModel.init();
        },
        onPageBuilder:
            (BuildContext context, ChangeNameViewModel changeNameViewModel) {
          return Scaffold(
            appBar: HessaAppBar(
              title: 'changeName'.tr,
              isTitleOnly: true,
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
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: [
                          AppTextFormField(
                            validate: Validators.requiredValidator.call,
                            controller: firstName,
                            title: 'firstName'.tr,
                            hintText: 'firstName'.tr,
                          ),
                          AppTextFormField(
                            validate: Validators.requiredValidator.call,
                            controller: lastName,
                            title: 'lastName'.tr,
                            hintText: 'lastName'.tr,
                          ),
                        ],
                      ),
                    ),
                    AppButton(
                        isDisable: isDisable,
                        title: 'save'.tr,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            showModalBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width - 30,
                                // here increase or decrease in width
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              builder: (BuildContext context) {
                                return SuccessFailsInfoDialog(
                                  title: 'success'.tr,
                                  buttonTitle: 'done'.tr,
                                  content: 'youHaveSuccessfully'.tr,
                                );
                              },
                            );
                          }
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
