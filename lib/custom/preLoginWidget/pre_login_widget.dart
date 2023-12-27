import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../../product/utils/validators.dart';
import '../app_button/app_button.dart';
import '../image/app_image_assets.dart';

class PreLoginCustomBody extends StatelessWidget {
  PreLoginCustomBody({
    this.widget,
    super.key,
  });

  Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
         AppImageAsset(
          image: ImageConstants.splashBG,
          fit: BoxFit.fill,
          height:  227.px,
        ),
        Column(
          children: <Widget>[widget ?? const SizedBox()],
        ),
      ],
    );
  }
}

class OnTapBack extends StatelessWidget {
   OnTapBack({
    super.key,
    this.onTapBack
  });

  VoidCallback? onTapBack;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap:onTapBack?? () {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.pop(context);
          logs('back tapped >>>');
        },
        child: const Icon(
          Icons.keyboard_backspace,
          color: AppColors.appDarkBlack,
        ),
      ),
    );
  }
}

class PreLoginCommonButton extends StatelessWidget {
  PreLoginCommonButton({
    this.onTap,
    this.title,
    this.height,
    this.isDisable = true,
    super.key,
  });

  String? title;
  VoidCallback? onTap;
  double? height;
  bool? isDisable;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.px),
          child: AppButton(
            borderRadius: BorderRadius.circular(10.px),
            borderColor: AppColors.appBlue,
            title: title ?? '',
            onPressed: onTap ?? () {},
            isDisable: isDisable,
          ),
        ),
        SizedBox(
          height: height ?? 40.px,
        ),
      ],
    );
  }
}
