import 'module_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get goodNews => 'Good News';

  @override
  String get badNews => 'Bad News';

  @override
  String get more => 'more';

  @override
  String get flash => 'Flash';

  @override
  String get calendar => 'Calendar';

  @override
  String get live => 'Live';

  @override
  String get support => 'Support';

  @override
  String thisIsFromModule(String widgetName) {
    return 'This is $widgetName Widget\n from module';
  }

  @override
  String get rookie => 'Rookie';

  @override
  String get veteran => 'Veteran';

  @override
  String get articles => 'Articles';
}
