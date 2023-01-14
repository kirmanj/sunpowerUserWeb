import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Lang {
  static const String ENGLISH = "en";
  static const String KURDISH = "ku";
  static const String ARABIC = "ar";

  static const List<String> values = [KURDISH ,ARABIC, ENGLISH];
}

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  late Map<String, String> _sentences;

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('assets/lang/${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    _sentences =  {};
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });
    return true;
  }

  String trans(String key) {
    return _sentences[key] ?? '';
  }

  get textDirection{
    if(locale.languageCode == "en" || locale.languageCode == "kt" || locale.languageCode == "tr" ) return TextDirection.ltr;
    return TextDirection.rtl;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => Lang.values.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();

    print("Load ${locale.languageCode}");

    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
