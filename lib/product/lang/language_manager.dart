import 'package:flutter/material.dart';

class LanguageManager {
  LanguageManager._init();

  static LanguageManager? _instance;

  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  final Locale enLocale = const Locale('en', 'US');
  final Locale arLocale = const Locale('ar', 'AR');

  List<Locale> get supportedLocales => <Locale>[enLocale, arLocale];
}
