import 'package:flutter/material.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final enLocale = const Locale("en", "US");
  final arLocale = const Locale("ae", "AE");

  List<Locale> get supportedLocales => [enLocale, arLocale];
}
