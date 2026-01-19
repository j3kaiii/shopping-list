import 'package:flutter/material.dart';
import 'package:flutter_custom_theme/flutter_custom_theme.dart';

class ShoppingTheme {
  static final _data = ShoppingThemeData();

  static final _dataDark = ShoppingThemeData(
    coloredBackground:
        const Color.fromARGB(255, 6, 67, 88).withValues(alpha: .9),
    primaryBgColor: _Colors.greyLight,
    secondaryBgColor: const Color.fromARGB(255, 20, 157, 225),
    textColor: Colors.white,
  );

  static final main = CustomThemeDataSet(data: _data, dataDark: _dataDark);

  static ShoppingThemeData of(BuildContext context) => CustomThemes.safeOf(
        context,
        mainDefault: ShoppingTheme._data,
        darkDefault: ShoppingTheme._dataDark,
      );

  // Удаляем статические theme и darkTheme, так как они должны браться из контекста
  ShoppingTheme._();
}

class ShoppingThemeData extends CustomThemeData {
  factory ShoppingThemeData({
    Color? coloredBackground,
    Color activeItemColor = Colors.green,
    Color primaryBgColor = _Colors.greyLight,
    Color secondaryBgColor = _Colors.greenDark,
    Color textColor = _Colors.greyDark,
    TextStyle? titleTextStyle,
    TextStyle? defaultTextStyle,
    TextStyle? hintTextStyle,
  }) {
    coloredBackground ??=
        const Color.fromARGB(255, 218, 243, 244).withValues(alpha: .9);

    titleTextStyle ??= const TextStyle(
      color: _Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );

    defaultTextStyle ??= TextStyle(
      color: textColor,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );

    hintTextStyle ??= const TextStyle(
      color: _Colors.greyDark,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );

    return ShoppingThemeData._raw(
      coloredBackground: coloredBackground,
      activeItemColor: activeItemColor,
      primaryBgColor: primaryBgColor,
      secondaryBgColor: secondaryBgColor,
      textColor: textColor,
      titleTextStyle: titleTextStyle,
      defaultTextStyle: defaultTextStyle,
      hintTextStyle: hintTextStyle,
    );
  }

  const ShoppingThemeData._raw({
    required this.coloredBackground,
    required this.activeItemColor,
    required this.primaryBgColor,
    required this.secondaryBgColor,
    required this.textColor,
    required this.titleTextStyle,
    required this.defaultTextStyle,
    required this.hintTextStyle,
  });

  // Цвет фона шторки
  final Color? coloredBackground;
  // Цвет активного элемента
  final Color? activeItemColor;
  // Основной цвет фона
  final Color? primaryBgColor;
  // Дополнительный цвет фона
  final Color? secondaryBgColor;
  final Color? textColor;

  final TextStyle? titleTextStyle;
  final TextStyle? defaultTextStyle;
  final TextStyle? hintTextStyle;
}

extension ShoppingThemeDataExtension on ShoppingThemeData {
  ThemeData theme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      );

  ThemeData darkTheme() => ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
      );
}

class _Colors {
  static const greenDark = Color.fromARGB(255, 0, 129, 0);
  static const greenLight = Color.fromARGB(255, 0, 217, 0);
  static const greyLight = Color.fromARGB(255, 208, 208, 208);
  static const greyDark = Color.fromARGB(255, 112, 111, 111);
  static const white = Color.fromARGB(255, 245, 245, 245);
  static const black = Color.fromARGB(255, 50, 50, 50);
}
