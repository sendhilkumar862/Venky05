import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../product/constants/colors/app_colors_constants.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final String? copyText; // Text to be copied to the clipboard
  final bool showCopySnackbar; // Flag to show the snackbar on tap
  final bool? isBorderOnly;
  final Color? borderColor;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    this.borderRadius,
    this.textStyle,
    this.padding,
    this.copyText,
    this.showCopySnackbar = true,
    this.isBorderOnly = false,
    this.borderColor, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          if (copyText != null && showCopySnackbar) {
            _copyToClipboardAndShowSnackbar(context, copyText ?? "");
          }
          onPressed();
        },
        child: Padding(
          padding:
              padding ?? const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
          child: Container(
            height: height ?? 50,
            width: width,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor ?? Colors.grey),
              borderRadius: borderRadius ?? BorderRadius.circular(16),
              color:
                  isBorderOnly == true ? AppColors.trans : AppColors.appColor,
            ),
            child: Center(
              child: Text(
                title,
                style: textStyle ??
                    TextStyle(
                        color: isBorderOnly == true
                            ? AppColors.appColor
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
      content: Text(
        'Copied to Clipboard !',
      ),
    ));
  }
}
