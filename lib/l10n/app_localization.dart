import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations get instance => _AppLocalizationsDelegate.instance!;

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('bn')
  ];

  Map<String, String> _localizedStrings = {};

  Map flattenTranslations(Map<String, dynamic> json, [String prefix = '']) {
    final Map<String, String> translations = {};
    json.forEach((String key, dynamic value) {
      if (value is Map<String, dynamic>) {
        translations.addAll(
            flattenTranslations(value, '$prefix$key.') as Map<String, String>);
      } else {
        translations['$prefix$key'] = value.toString();
      }
    });
    return translations;
  }

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    _localizedStrings = flattenTranslations(jsonMap) as Map<String, String>;
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'bn'].contains(locale.languageCode);
  }

  static AppLocalizations? instance;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();

    instance = localizations;
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
