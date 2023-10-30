import 'package:flutter/material.dart';
import '../../core/typography.dart';
import '../../product/constants/colors/app_colors_constants.dart';

class AppDropdown extends StatefulWidget {

  const AppDropdown({
    super.key,
    this.hintText,
    this.options = const [],
    required this.getLabel,
    required this.value,
    required this.onChanged,
    this.title,
    this.validate,
  });
  final String? hintText;
  final List options;
  final String value;
  final String? title;
  final String Function(String) getLabel;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validate;

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20,bottom: 7),
          child: Text(
            widget.title ?? '',
            style: TextStyle(color: const Color(0xff051335).withOpacity(0.5),fontSize: 8),

          ),
        ),
        DropdownButtonFormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: poppins.w300
                  .textColor(AppColors.black.withOpacity(0.5))
                  .get10,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              filled: true,
              fillColor: Colors.transparent,
              counterText: '',
              focusedBorder:  const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appBorderColor, width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appBorderColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                color: AppColors.appColor,
              )),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: AppColors.red)),
              errorStyle: poppins.red.get8

          ),
          validator: (String? value) {
            if (value != null) {
              return null;
            } else {
              return "Value Can't be Empty";
            }
          },
          value:
              widget.options.contains(widget.value) ? widget.value : null,
          items: List.generate(
              widget.options.length ?? 0,
              (int index) => DropdownMenuItem(
                    value: widget.options[index],
                    child: Text(
                      widget.options[index] ?? "",
                    ),
                  )),
          elevation: 2,
          onChanged: widget.onChanged,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.black,
          ),
          focusColor: Colors.transparent,
          style: poppins.black.w400.get10,
          dropdownColor: AppColors.gray,
        ),
      ],
    );
  }
}
