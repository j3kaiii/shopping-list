import 'package:flutter/material.dart';
import 'package:shopping_list_example/application/localizations.dart';
import 'package:shopping_list_example/application/theme.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
  ShoppingThemeData get theme => ShoppingTheme.of(this);
}
