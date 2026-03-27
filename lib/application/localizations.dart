import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiple_localization/multiple_localization.dart';
import 'package:shopping_list_example/application/l10n/messages_all_locales.dart';
import 'package:shopping_list_example/screens/create_item_screen.dart';

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

  String get settingsScreenTitle =>
      Intl.message('Настройки', name: 'settingsScreenTitle');

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
  String get btnEdit => Intl.message('Редактировать', name: 'btnEdit');
  String get btnDelete => Intl.message('Удалить', name: 'btnDelete');
  String get hintCreateName =>
      Intl.message('Придумайте название', name: 'hintCreateName');

  String get createListTitle =>
      Intl.message('Создать список', name: 'createListTitle');

  String get createListBottomButton =>
      Intl.message('Создать список', name: 'createListBottomButton');

  String get createListHeader =>
      Intl.message('Создать список покупок', name: 'createListHeader');

  String get createListSubheader =>
      Intl.message('Организуйте свои покупки с помощью нового списка',
          name: 'createListSubheader');

  String get createListNameLabel =>
      Intl.message('НАЗВАНИЕ СПИСКА', name: 'createListNameLabel');

  String get createListNameHint =>
      Intl.message('например, Еженедельные продукты',
          name: 'createListNameHint');

  String get createProductTitle =>
      Intl.message('Добавить продукт', name: 'createProductTitle');

  String get createProductBottomButton =>
      Intl.message('Добавить в базу', name: 'createProductBottomButton');

  String get createProductHeader =>
      Intl.message('Что вам нужно сегодня?', name: 'createProductHeader');

  String get createProductSubheader =>
      Intl.message('Добавьте продукт в свою цифровую кладовую',
          name: 'createProductSubheader');

  String get createProductNameLabel =>
      Intl.message('НАЗВАНИЕ ПРОДУКТА', name: 'createProductNameLabel');

  String get createProductNameHint =>
      Intl.message('например, Овсяное молоко', name: 'createProductNameHint');

  String get createProductExistError =>
      Intl.message('Такой продукт есть', name: 'createProductExistError');

  String get createListExistError =>
      Intl.message('Такой список есть', name: 'createListExistError');

  String get deleteListDialogTitle =>
      Intl.message('Хотите удалить список?', name: 'deleteListDialogTitle');

  String createItemTitle(ItemType type) => switch (type) {
        ItemType.list => createListTitle,
        ItemType.product => createProductTitle,
      };

  String createItemBottomButton(ItemType type) => switch (type) {
        ItemType.list => createListBottomButton,
        ItemType.product => createProductBottomButton,
      };

  String createItemHeader(ItemType type) => switch (type) {
        ItemType.list => createListHeader,
        ItemType.product => createProductHeader,
      };

  String createItemSubheader(ItemType type) => switch (type) {
        ItemType.list => createListSubheader,
        ItemType.product => createProductSubheader,
      };

  String createItemNameLabel(ItemType type) => switch (type) {
        ItemType.list => createListNameLabel,
        ItemType.product => createProductNameLabel,
      };

  String createItemNameHint(ItemType type) => switch (type) {
        ItemType.list => createListNameHint,
        ItemType.product => createProductNameHint,
      };

  String createItemExistError(ItemType type) => switch (type) {
        ItemType.list => createListExistError,
        ItemType.product => createProductExistError,
      };
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
