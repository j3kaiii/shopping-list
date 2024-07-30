import 'package:flutter/material.dart';
import 'package:flutter_custom_theme/flutter_custom_theme.dart';

class ShoppingTheme {
  static final _data = ShoppingThemeData(
    coloredBackground:
        const Color.fromARGB(255, 218, 243, 244).withOpacity(0.9),
    activeItemColor: Colors.green,
    primaryBgColor: Colors.white,
    secondaryBgColor: Colors.lightBlue,
  );

  static final theme = _data.theme();

  static final main = CustomThemeDataSet(data: _data, dataDark: _data);

  ShoppingTheme._();
}

class ShoppingThemeData extends CustomThemeData {
  const ShoppingThemeData({
    this.coloredBackground,
    this.activeItemColor,
    this.primaryBgColor,
    this.secondaryBgColor,
  });

  static ShoppingThemeData of(BuildContext context) => CustomThemes.safeOf(
        context,
        mainDefault: const ShoppingThemeData(),
      );

  // Цвет фона шторки
  final Color? coloredBackground;

  // Цвет активного элемента
  final Color? activeItemColor;

  // Основной цвет фона
  final Color? primaryBgColor;

  // Дополнительный цвет фона
  final Color? secondaryBgColor;
}

extension _PlannerThemeDataExtension on ShoppingThemeData {
  ThemeData theme() => ThemeData();
}
