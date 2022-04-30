import 'package:flutter/material.dart';
import 'package:mightyvpn/language/LanguageCn.dart';
import 'package:mightyvpn/language/LanguageFr.dart';
import 'package:mightyvpn/language/LanguageIs.dart';
import 'package:mightyvpn/language/LanguageKo.dart';
import 'package:mightyvpn/language/LanguagePh.dart';
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
      case 'pt':
        return LanguageBr();
      case 'es':
        return LanguageEs();
      case 'fr':
        return LanguageFr();
      case 'zh':
        return LanguageCn();
      case 'fil':
        return LanguagePh();
      case 'id':
        return LanguageIs();
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
