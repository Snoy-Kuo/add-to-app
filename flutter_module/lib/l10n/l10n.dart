//copy all from flutter_gen/gen_l10n to /l10n/gen_l10n for using l10n in package, be sure all updates copied,
//or you can manually generate app_localizations files, ref = https://github.com/flutter/flutter/issues/70840#issuecomment-732548224
import 'package:flutter/widgets.dart';

import 'gen_l10n/app_localizations.dart';
import 'gen_l10n/app_localizations_en.dart';
import 'gen_l10n/app_localizations_zh.dart';

export 'gen_l10n/app_localizations.dart';

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

//TODO: wait for Dart 2.13
// https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87
// typedef L10N = AppLocalizations;
