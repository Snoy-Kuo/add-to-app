//copy all from flutter_gen/gen_l10n to /l10n/gen_l10n for using l10n in package, be sure all updates copied,
//or you can manually generate app_localizations files, ref = https://github.com/flutter/flutter/issues/70840#issuecomment-732548224
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';

import 'gen_l10n/module_localizations.dart';
import 'gen_l10n/module_localizations_en.dart';
import 'gen_l10n/module_localizations_zh.dart';

export 'gen_l10n/module_localizations.dart';

AppLocalizations l10n(BuildContext context) {
  return AppLocalizations.of(context)!;
}

List<LocalizationsDelegate<dynamic>> get l10nDelegates =>
    AppLocalizations.localizationsDelegates;

@visibleForTesting
LocalizationsDelegate<AppLocalizations> get l10nDelegate =>
    AppLocalizations.delegate;

@visibleForTesting
AppLocalizations l10nTest({Locale locale = const Locale('en', '')}) {
  switch (locale.languageCode) {
    case 'zh':
      return AppLocalizationsZh();
    default:
      return AppLocalizationsEn();
  }
}

extension l10nUtil on Locale {
  Locale supportLocale(){
    if (AppLocalizations.supportedLocales.indexOf(this)!=-1){
      return this;
    } else {
      return AppLocalizations.supportedLocales.first;
    }
  }
}

Locale languageToLocale(String value) {
  Locale locale;

  switch (value) {
    case 'English':
      {
        locale = Locale('en');
      }
      break;
    case '繁體中文':
      {
        locale = Locale('zh', 'TW');
      }
      break;
    case '简体中文':
      {
        locale = Locale('zh');
      }
      break;
    case 'System':
      {
        String languageCode = Platform.localeName.split('_')[0];
        String countryCode = '';
        try {
          countryCode = Platform.localeName.split('_')[1];
        } catch (e) {
          log('extract countryCode err, localeName=${Platform.localeName}, e=$e');
        }
        if (countryCode == 'Hant') {
          countryCode = 'TW';
          try {
            if (Platform.localeName.split('_')[2] == 'HK') {
              countryCode = 'HK';
            }
          } catch (e) {
            log('extract countryCode Hant err, localeName=${Platform.localeName}, e=$e');
          }
        }
        else if (countryCode == 'Hans'){
          countryCode = 'CN';
        }
        locale = Locale(languageCode, countryCode);
      }
      break;
    default:
      {
        locale = Locale('en');
      }
  }
  return locale;
}

//TODO: wait for Dart 2.13
// https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87
// typedef L10N = AppLocalizations;
