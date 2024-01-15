import 'package:flutter/material.dart';

void showCommonBottomSheet(
    {required BuildContext context, required Widget commonWidget, bool? showDragHandle}) {
  showModalBottomSheet(
      showDragHandle: showDragHandle??true,
      useSafeArea: true,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: commonWidget,
        );
      });
}
