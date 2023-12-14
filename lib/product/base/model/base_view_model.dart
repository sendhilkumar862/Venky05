import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseViewModel {
  late BuildContext viewModelContext;
  late WidgetRef ref;

  void setContext(BuildContext context);
  void init();
}
