// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.
// @dart=2.12
// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(
    String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'ru';

  String? lookupMessage(
      String? message_str,
      String? locale,
      String? name,
      List<Object>? args,
      String? meaning,
      {MessageIfAbsent? ifAbsent}) {
    String? failedLookup(
        String? message_str, List<Object>? args) {
      // If there's no message_str, then we are an internal lookup, e.g. an
      // embedded plural, and shouldn't fail.
      if (message_str == null) return null;
      throw UnsupportedError(
          "No translation found for message '$name',\n"
          "  original text '$message_str'");
    }
    return super.lookupMessage(message_str, locale, name, args, meaning,
        ifAbsent: ifAbsent ?? failedLookup);
  }

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'applicationName': MessageLookupByLibrary.simpleMessage('Рабочее название'),
    'btnAdd': MessageLookupByLibrary.simpleMessage('Добавить'),
    'btnCancel': MessageLookupByLibrary.simpleMessage('Отменить'),
    'btnDelete': MessageLookupByLibrary.simpleMessage('Удалить'),
    'btnEdit': MessageLookupByLibrary.simpleMessage('Редактировать'),
    'btnOk': MessageLookupByLibrary.simpleMessage('OK'),
    'btnUndo': MessageLookupByLibrary.simpleMessage('Отменить'),
    'continueShopping': MessageLookupByLibrary.simpleMessage('Продолжить покупки'),
    'createListBottomButton': MessageLookupByLibrary.simpleMessage('Создать список'),
    'createListExistError': MessageLookupByLibrary.simpleMessage('Такой список есть'),
    'createListHeader': MessageLookupByLibrary.simpleMessage('Создать список покупок'),
    'createListNameHint': MessageLookupByLibrary.simpleMessage('например, Еженедельные продукты'),
    'createListNameLabel': MessageLookupByLibrary.simpleMessage('НАЗВАНИЕ СПИСКА'),
    'createListSubheader': MessageLookupByLibrary.simpleMessage('Организуйте свои покупки с помощью нового списка'),
    'createListTitle': MessageLookupByLibrary.simpleMessage('Создать список'),
    'createProductBottomButton': MessageLookupByLibrary.simpleMessage('Добавить в базу'),
    'createProductExistError': MessageLookupByLibrary.simpleMessage('Такой продукт есть'),
    'createProductHeader': MessageLookupByLibrary.simpleMessage('Что вам нужно сегодня?'),
    'createProductNameHint': MessageLookupByLibrary.simpleMessage('например, Овсяное молоко'),
    'createProductNameLabel': MessageLookupByLibrary.simpleMessage('НАЗВАНИЕ ПРОДУКТА'),
    'createProductSubheader': MessageLookupByLibrary.simpleMessage('Добавьте продукт в свою цифровую кладовую'),
    'createProductTitle': MessageLookupByLibrary.simpleMessage('Добавить продукт'),
    'deleteListDialogTitle': MessageLookupByLibrary.simpleMessage('Хотите удалить список?'),
    'editProduct': MessageLookupByLibrary.simpleMessage('Редактировать продукт'),
    'emptyNameError': MessageLookupByLibrary.simpleMessage('Введите название'),
    'emptyShoppingListTitle': MessageLookupByLibrary.simpleMessage('Список покупок пуст'),
    'existNameError': MessageLookupByLibrary.simpleMessage('Такое название уже есть'),
    'existProductError': MessageLookupByLibrary.simpleMessage('Такой продукт уже есть'),
    'hintCreateName': MessageLookupByLibrary.simpleMessage('Придумайте название'),
    'itemsCollected': MessageLookupByLibrary.simpleMessage('товаров куплено'),
    'listsScreenTitle': MessageLookupByLibrary.simpleMessage('Мои списки'),
    'noSavedListsTitle': MessageLookupByLibrary.simpleMessage('Нет сохраненных списков покупок'),
    'noSavedListsYet': MessageLookupByLibrary.simpleMessage('Списков пока нет'),
    'noSavedProductsTitle': MessageLookupByLibrary.simpleMessage('Нет сохраненных продуктов'),
    'productsScreenTitle': MessageLookupByLibrary.simpleMessage('Мои продукты'),
    'quantity': MessageLookupByLibrary.simpleMessage('Количество'),
    'removedFromList': MessageLookupByLibrary.simpleMessage('удален из списка'),
    'settingsScreenTitle': MessageLookupByLibrary.simpleMessage('Настройки'),
    'welcomeScreenTitle': MessageLookupByLibrary.simpleMessage('За покупками!')
  };
}
