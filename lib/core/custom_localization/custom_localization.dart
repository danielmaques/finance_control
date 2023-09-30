import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomLocalization {
  static final List<Locale> supportedLocales = [
    const Locale('pt', ''),
    const Locale('en', ''),
  ];

  static const Locale defaultLocale = Locale('pt', '');

  CustomLocalization(
    this._locale, {
    this.isTest = false,
  });

  late final Locale _locale;
  late bool isTest;
  Map<String, String>? _sentences;

  static CustomLocalization of(BuildContext context) {
    return Localizations.of<CustomLocalization>(context, CustomLocalization)!;
  }

  Future<CustomLocalization> loadTest(Locale locale) async {
    return CustomLocalization(locale);
  }

  Future<CustomLocalization> load() async {
    String data;
    try {
      data = await rootBundle
          .loadString('./assets/langs/${_locale.languageCode}.json');
    } catch (e) {
      debugPrint(
          '*assets for ${_locale.languageCode} locale is not found loading default language');
      data = await rootBundle.loadString(
          './assets/langs/${CustomLocalization.defaultLocale.languageCode}.json');
    }

    Map<String, dynamic> result = json.decode(data);
    _sentences = {};
    result.forEach((String key, value) {
      _sentences![key] = value.toString();
    });
    return CustomLocalization(_locale);
  }

  String translate(String key) {
    if (isTest) return key;

    return _sentences![key] ?? key;
  }
}

class CustomLocalizationDelegate
    extends LocalizationsDelegate<CustomLocalization> {
  final bool isTest;

  CustomLocalizationDelegate({
    this.isTest = false,
  });

  @override
  bool isSupported(Locale locale) => CustomLocalization.supportedLocales
      .any((e) => e.languageCode == locale.languageCode);

  @override
  Future<CustomLocalization> load(Locale locale) async {
    var localizations = CustomLocalization(locale, isTest: isTest);
    if (isTest) {
      await localizations.loadTest(locale);
    } else {
      await localizations.load();
    }

    return localizations;
  }

  @override
  bool shouldReload(CustomLocalizationDelegate old) => false;
}
