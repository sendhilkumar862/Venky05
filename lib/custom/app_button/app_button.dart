import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/typography.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? textStyle;
  final String? copyText; // Text to be copied to the clipboard
  final bool showCopySnackbar; // Flag to show the snackbar on tap
  final bool? isBorderOnly;
  final Color? borderColor;
  final bool isDisable;
  final double? top;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    this.borderRadius,
    this.textStyle,
    this.copyText,
    this.showCopySnackbar = true,
    this.isBorderOnly,
    this.borderColor,
    required this.isDisable,
    this.top,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Align(
      child: GestureDetector(
        onTap: () {
          if (copyText != null && showCopySnackbar) {
            _copyToClipboardAndShowSnackbar(context, copyText ?? "");
          }
          onPressed();
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 2, right: 2, top: 10, bottom: 10),
          child: Container(
            height: height ?? 50,
            width: width,
            decoration: BoxDecoration(
                border: !isDisable || isBorderOnly == true
                    ? Border.all(color: borderColor ?? Colors.grey)
                    : null,
                borderRadius: borderRadius ?? BorderRadius.circular(16),
                color: isBorderOnly == true
                    ? AppColors.trans
                    : !isDisable
                        ? AppColors.appBlue
                        : AppColors.isDisableColor,
                boxShadow: [
                  if (isDisable == false || isBorderOnly == false)
                    BoxShadow(
                        blurRadius: 24,
                        offset: Offset(0, 12),
                        color: AppColors.appBlue.withOpacity(0.25))
                ]),
            child: Center(
              child: Text(
                title,
                style: textStyle ??
                    TextStyle(
                        color: isBorderOnly == true
                            ? AppColors.appBlue
                            : isDisable
                                ? AppColors.white.withOpacity(0.6)
                                : AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _copyToClipboardAndShowSnackbar(
      BuildContext context, String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      behavior: SnackBarBehavior.floating,
      width: 47,
      duration: const Duration(seconds: 1),
      content: Text('Copied to Clipboard !', style: openSans.white),
    ));
  }
}
