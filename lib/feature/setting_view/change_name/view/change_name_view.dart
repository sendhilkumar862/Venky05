// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../product/utils/validators.dart';
import '../controller/change_name_controller.dart';

class ChangeNameView extends StatefulWidget {
  const ChangeNameView({super.key});

  @override
  State<ChangeNameView> createState() => _ChangeNameViewState();
}

class _ChangeNameViewState extends State<ChangeNameView> {
  final formKey = GlobalKey<FormState>();

  final ChangeNameController _changeNameController =
      Get.put(ChangeNameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        title: 'changeName'.tr,
        isTitleOnly: true,
      ),
      body: Form(
        key: formKey,
        onChanged: () {
          if (formKey.currentState!.validate()) {
            _changeNameController.isDisable.value = false;
          } else {
            _changeNameController.isDisable.value = true;
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
                      controller: _changeNameController.firstName,
                      title: 'firstName'.tr,
                      hintText: 'firstName'.tr,
                    ),
                    AppTextFormField(
                      validate: Validators.requiredValidator.call,
                      controller: _changeNameController.lastName,
                      title: 'lastName'.tr,
                      hintText: 'lastName'.tr,
                    ),
                  ],
                ),
              ),
              Obx(
                () => AppButton(isDisable: _changeNameController.isDisable.value,
                    title: 'save'.tr,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final bool success =
                            await _changeNameController.changeName();
                        if (success) {
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
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
                                title: 'success'.tr,
                                buttonTitle: 'done'.tr,
                                content: 'youHaveSuccessfully'.tr,
                                isRouting: 'back',
                              );
                            },
                          );
                        }
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
