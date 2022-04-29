import 'package:flutter/material.dart';
import 'package:mightyvpn/language/LanguageKo.dart';
import 'LanguageAr.dart';
import 'LanguageEn.dart';
import 'LanguageDe.dart';
import 'LanguageBr.dart';
import 'LanguageEs.dart';
import 'base_language.dart';
import 'package:nb_utils/nb_utils.dart';

class AppLocalizations extends LocalizationsDelegate<BaseLanguage> {
  const AppLocalizations();

  @override
  Future<BaseLanguage> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ar':
        return LanguageAr();
      case 'de':
        return LanguageDe();
      case 'ko':
        return LanguageKo();
      case 'br':
        return LanguageBr();
      case 'es':
        return LanguageEs();
      default:
        return LanguageEn();
    }
  }

  @override
  bool isSupported(Locale locale) =>
      LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<BaseLanguage> old) => false;
}
