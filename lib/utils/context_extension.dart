import 'package:flutter/material.dart';
import 'package:shopping_list_example/application/localizations.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
