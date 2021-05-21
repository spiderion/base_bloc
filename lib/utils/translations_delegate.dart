import 'package:base_bloc/utils/translations.dart';
import 'package:flutter/material.dart';

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  final bool isTest;

  const TranslationsDelegate({this.isTest = false});

  @override
  bool isSupported(Locale locale) => ['en', 'it'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) async {
    return isTest ? await Translations.loadTest() : await Translations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => false;
}
