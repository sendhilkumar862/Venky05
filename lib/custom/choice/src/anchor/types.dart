import 'package:flutter/widgets.dart';
import '../../selection.dart';

typedef ChoiceAnchorBuilder<T> = Widget Function(
  ChoiceController<T> state,
  VoidCallback openModal,
);
