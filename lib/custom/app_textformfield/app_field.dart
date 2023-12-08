import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/typography.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.readOnly,
    this.labelText,
    this.hintText,
    this.icon,
    this.title,
    this.validate,
    this.controller,
    this.suffix,
    this.width,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.maxLength,
    this.keyboardType,
    this.prefix,
    this.height,
    this.top,
    this.titleColor,
    this.borderColor,
    this.hintFontSize,
    this.maxLines,
    this.minLines,
    this.fillColor,
    this.contentPadding,
  });

  final bool? readOnly;
  final String? Function(String?)? validate;
  final String? labelText;
  final String? hintText;
  final String? title;
  final Color? titleColor;
  final Color? borderColor;
  final IconData? icon;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController? controller;
  final double? width;
  final double? height;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextInputType? keyboardType;
  final double? top;
  final double? hintFontSize;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: top ?? 20, bottom: 7),
          child: Text(
            title ?? hintText ?? '',
            style: TextStyle(
                color: titleColor ?? AppColors.appTextColor.withOpacity(0.5),
                fontSize: 12.px,
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFormField(
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          style: openSans.black.w500.get16.textColor(AppColors.appTextColor),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType ?? TextInputType.text,
          onTap: onTap,
          onChanged: onChanged,
          readOnly: readOnly ?? false,
          controller: controller,
          validator: validate,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: AppColors.black,
          decoration: InputDecoration(
              contentPadding:
                  contentPadding ?? EdgeInsets.symmetric(horizontal: 15.px),
              // contentPadding:
              //     EdgeInsets.symmetric(vertical: height ?? 7, horizontal: 10),
              filled: true,
              prefixIcon: prefix,
              fillColor: fillColor ?? Colors.transparent,
              counterText: '',
              hintText: hintText,
              hintStyle: openSans.w400
                  .textColor(AppColors.appTextColor.withOpacity(0.25))
                  .get14,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffC5CEEE),),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: borderColor ?? AppColors.appBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              suffixIcon: suffix,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: AppColors.appBlue,
                  )),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: AppColors.red)),
              errorStyle: openSans.red.get8),
        ),
      ],
    );
  }
}
