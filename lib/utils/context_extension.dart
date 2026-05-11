import 'package:flutter/material.dart';
import 'package:go_shopping/application/localizations.dart';
import 'package:go_shopping/application/theme.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
  ShoppingThemeData get theme => ShoppingTheme.of(this);
}
