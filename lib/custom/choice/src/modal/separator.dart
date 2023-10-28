import 'package:flutter/material.dart';
import '../../selection.dart';

class ChoiceModalSeparator extends Divider {
  const ChoiceModalSeparator({
    super.key,
    super.color,
    super.endIndent,
    super.height,
    super.indent,
    super.thickness,
  });

  static ChoiceStateBuilder<T> create<T>({
    Key? key,
    Color? color,
    double? endIndent,
    double? height,
    double? indent,
    double? thickness,
  }) {
    return (_) {
      return ChoiceModalSeparator(
        key: key,
        color: color,
        endIndent: endIndent,
        height: height,
        indent: indent,
        thickness: thickness,
      );
    };
  }
}
