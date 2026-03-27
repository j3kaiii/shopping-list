// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

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
      'applicationName': MessageLookupByLibrary.simpleMessage('Placeholder'),
    'btnAdd': MessageLookupByLibrary.simpleMessage('Add'),
    'btnCancel': MessageLookupByLibrary.simpleMessage('Cancel'),
    'btnDelete': MessageLookupByLibrary.simpleMessage('Delete'),
    'btnEdit': MessageLookupByLibrary.simpleMessage('Edit'),
    'btnOk': MessageLookupByLibrary.simpleMessage('OK'),
    'createListBottomButton': MessageLookupByLibrary.simpleMessage('Create List'),
    'createListExistError': MessageLookupByLibrary.simpleMessage('List exist'),
    'createListHeader': MessageLookupByLibrary.simpleMessage('Create a Shopping List'),
    'createListNameHint': MessageLookupByLibrary.simpleMessage('e.g. Weekly Groceries'),
    'createListNameLabel': MessageLookupByLibrary.simpleMessage('LIST NAME'),
    'createListSubheader': MessageLookupByLibrary.simpleMessage('Organize your shopping with a new list'),
    'createListTitle': MessageLookupByLibrary.simpleMessage('Create New List'),
    'createProductBottomButton': MessageLookupByLibrary.simpleMessage('Add to Database'),
    'createProductExistError': MessageLookupByLibrary.simpleMessage('Product exist'),
    'createProductHeader': MessageLookupByLibrary.simpleMessage('What do you need today?'),
    'createProductNameHint': MessageLookupByLibrary.simpleMessage('e.g. Oat Milk'),
    'createProductNameLabel': MessageLookupByLibrary.simpleMessage('ITEM NAME'),
    'createProductSubheader': MessageLookupByLibrary.simpleMessage('Add an item to your digital pantry'),
    'createProductTitle': MessageLookupByLibrary.simpleMessage('Add New Product'),
    'deleteListDialogTitle': MessageLookupByLibrary.simpleMessage('Do you want to delete current list?'),
    'emptyNameError': MessageLookupByLibrary.simpleMessage('Enter name'),
    'emptyShoppingListTitle': MessageLookupByLibrary.simpleMessage('Shopping list is empty'),
    'existNameError': MessageLookupByLibrary.simpleMessage('Such name already exists'),
    'existProductError': MessageLookupByLibrary.simpleMessage('Such product already exists'),
    'hintCreateName': MessageLookupByLibrary.simpleMessage('Come up with a name'),
    'listsScreenTitle': MessageLookupByLibrary.simpleMessage('My Lists'),
    'noSavedListsTitle': MessageLookupByLibrary.simpleMessage('No saved shopping lists'),
    'noSavedProductsTitle': MessageLookupByLibrary.simpleMessage('No saved products'),
    'productsScreenTitle': MessageLookupByLibrary.simpleMessage('My Products'),
    'settingsScreenTitle': MessageLookupByLibrary.simpleMessage('Settings'),
    'welcomeScreenTitle': MessageLookupByLibrary.simpleMessage('Go Shopping!')
  };
}
