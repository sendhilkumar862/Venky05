import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/typography.dart';
import '../../product/constants/colors/app_colors_constants.dart';

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
    this.height, this.top,
  });
  final bool? readOnly;
  final String? Function(String?)? validate;
  final String? labelText;
  final String? hintText;
  final String? title;
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only( top: top ??20,bottom: 7),
          child: Text(
            title ?? hintText ?? '',
            style:
            TextStyle(color: const Color(0xff051335).withOpacity(0.5),fontSize: 8),
          ),
        ),
        TextFormField(
          maxLength: maxLength,
          style: poppins.black.w500.get10,
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
                  EdgeInsets.symmetric(vertical: height ??7, horizontal: 10),
              filled: true,
              prefixIcon: prefix,
              fillColor: Colors.transparent,
              counterText: '',
              hintText: hintText,
              hintStyle: poppins.w300
                  .textColor(AppColors.black.withOpacity(0.5))
                  .get10,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xffC5CEEE),
                      width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              suffixIcon: suffix,
              border:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                color: AppColors.appColor,
              )),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: AppColors.red)),
              errorStyle: poppins.red.get8),
        ),
      ],
    );
  }
}
