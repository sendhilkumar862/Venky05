import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/typography.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class TextFormsField extends StatelessWidget {

   TextFormsField({
    super.key,
    required this.controller,
    required this.hintText,
    this.errorText = '',
    this.obscureText = false,
    this.suffixIcon,
    this.prefix,
    this.onSuffixTap,
    this.validate,
    this.onChanged,
    this.isValid = '',
    this.onPrefixTap,
    this.keyboardType,
    this.title,
    this.onSaved,
    this.inputFormatters,
    this.maxLines = 1,
  });
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final String? title;
  final String? isValid;
  final int? validate;
  final int? maxLines;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onSaved;

  final GestureTapCallback? onSuffixTap;
  final GestureTapCallback? onPrefixTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title ?? '',
            fontSize: 12.px,
            fontWeight: FontWeight.w400,
            color: (validate == 1)
                ? AppColors.appBlue
                : (validate == 0)
                    ? AppColors.appRed
                    : AppColors.appGrey),
        SizedBox(height: 5.px),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
                color: (validate == 1)
                    ? AppColors.appBlue
                    : (validate == 0)
                        ? AppColors.appRed
                        : AppColors.lightPurple),
            color: AppColors.appWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (prefix != null) ...[
                InkWell(onTap: onPrefixTap, child: prefix),
              ],
              Expanded(
                child: TextFormField(maxLines: maxLines ,minLines: 1,
                  onFieldSubmitted: onSaved ?? (String value) {},
                  keyboardType: keyboardType ?? TextInputType.text,
                  controller: controller,
                  obscureText: obscureText,
                  onChanged: onChanged,inputFormatters: inputFormatters,
                  style: const TextStyle(
                      color: AppColors.appDarkBlack,
                      fontFamily: TextFontFamily.openSans,
                      fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 4, left: 16),
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: const TextStyle(
                        color: AppColors.appGrey,
                        fontFamily: TextFontFamily.openSans,
                        fontSize: 14),
                  ),
                ),
              ),
              if (suffixIcon != null) ...[
                InkWell(
                  onTap: onSuffixTap,
                  child: suffixIcon ?? const SizedBox(),
                ),
                const SizedBox(width: 12),
              ],
            ],
          ),
        ),
        if (errorText.isNotEmpty) ...[
          const SizedBox(height: 8),
          AppText(
            errorText,
            color: AppColors.appRed,
            fontSize: 12.px,
            fontWeight: FontWeight.w400,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
