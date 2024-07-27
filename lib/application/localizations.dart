import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiple_localization/multiple_localization.dart';
import 'package:shopping_list_example/application/l10n/messages_all_locales.dart';

typedef DelegateBuilder<T> = FutureOr<T> Function(String locale);

class AppLocalizations {
  static const _locales = [Locale('ru'), Locale('en')];
  static const LocalizationsDelegate<AppLocalizations> delegate =
      DefLocalizationsDelegate<AppLocalizations>(
          AppLocalizations.new, _locales);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  final String locale;

  AppLocalizations(this.locale);

  String get applicationName =>
      Intl.message('Рабочее название', name: 'applicationName');

  String get welcomeScreenTitle =>
      Intl.message('За покупками!', name: 'welcomeScreenTitle');

  String get listsScreenTitle =>
      Intl.message('Мои списки', name: 'listsScreenTitle');

  String get productsScreenTitle =>
      Intl.message('Мои продукты', name: 'productsScreenTitle');

  String get emptyNameError =>
      Intl.message('Введите название', name: 'emptyNameError');

  String get existNameError =>
      Intl.message('Такое название уже есть', name: 'existNameError');

  String get existProductError =>
      Intl.message('Такой продукт уже есть', name: 'existProductError');

  String get noSavedListsTitle =>
      Intl.message('Нет сохраненных списков покупок',
          name: 'noSavedListsTitle');

  String get noSavedProductsTitle =>
      Intl.message('Нет сохраненных продуктов', name: 'noSavedProductsTitle');

  String get emptyShoppingListTitle =>
      Intl.message('Список покупок пуст', name: 'emptyShoppingListTitle');

  String get btnAdd => Intl.message('Добавить', name: 'btnAdd');
  String get btnCancel => Intl.message('Отменить', name: 'btnCancel');
  String get btnOk => Intl.message('OK', name: 'btnOk');
  String get hintCreateName =>
      Intl.message('Придумайте название', name: 'hintCreateName');
}

class DefLocalizationsDelegate<T> extends LocalizationsDelegate<T> {
  final DelegateBuilder<T> builder;
  final List<Locale> locales;

  const DefLocalizationsDelegate(this.builder, this.locales);

  @override
  bool isSupported(Locale locale) =>
      locales.any((l) => l.languageCode == locale.languageCode);

  @override
  Future<T> load(Locale locale) {
    return MultipleLocalizations.load(initializeMessages, locale, builder,
        setDefaultLocale: true, fallbackLocale: 'en');
  }

  @override
  bool shouldReload(LocalizationsDelegate<T> old) => false;
}
