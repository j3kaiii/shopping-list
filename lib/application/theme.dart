import 'package:flutter/material.dart';
import 'package:flutter_custom_theme/flutter_custom_theme.dart';

class ShoppingTheme {
  static final _data = ShoppingThemeData();

  static final _dataDark = ShoppingThemeData(
    coloredBackground:
        const Color.fromARGB(255, 6, 67, 88).withValues(alpha: .9),
    primaryBgColor: _Colors.greyLight,
    secondaryBgColor: _Colors.blue,
    textColor: Colors.white,
  );

  static final main = CustomThemeDataSet(data: _data, dataDark: _dataDark);

  static ShoppingThemeData of(BuildContext context) => CustomThemes.safeOf(
        context,
        mainDefault: ShoppingTheme._data,
        darkDefault: ShoppingTheme._dataDark,
      );

  ShoppingTheme._();
}

class ShoppingThemeData extends CustomThemeData {
  factory ShoppingThemeData({
    Color? coloredBackground,
    Color activeItemColor = Colors.green,
    Color primaryBgColor = _Colors.greyLight,
    Color secondaryBgColor = _Colors.blue,
    Color textColor = _Colors.greyDark,
    Color? inputBorderColor,
    TextStyle? titleH1TextStyle,
    TextStyle? titleH2TextStyle,
    TextStyle? buttonTextStyle,
    TextStyle? defaultTextStyle,
    TextStyle? hintTextStyle,
    TextStyle? subheaderTextStyle,
    TextStyle? labelTextStyle,
    TextStyle? inputHintStyle,
    ButtonStyle? titledButtonStyle,
    ButtonStyle? iconButtonStyle,
  }) {
    coloredBackground ??=
        const Color.fromARGB(255, 218, 243, 244).withValues(alpha: .9);

    titleH1TextStyle ??= const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: _Colors.black,
    );

    titleH2TextStyle ??= const TextStyle(
      color: _Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );

    buttonTextStyle ??= const TextStyle(
      color: _Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    defaultTextStyle ??= const TextStyle(
      color: _Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    );

    hintTextStyle ??= const TextStyle(
      color: _Colors.greyDark,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );

    subheaderTextStyle ??= TextStyle(
      fontSize: 16,
      color: Colors.grey[600],
    );

    labelTextStyle ??= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Color(0xFF3B3BFF),
      letterSpacing: 0.5,
    );

    inputHintStyle ??= TextStyle(
      color: Colors.grey[400],
      fontSize: 16,
    );

    inputBorderColor ??= const Color(0xFF3B3BFF);

    titledButtonStyle ??= ButtonStyle(
        textStyle: const WidgetStatePropertyAll(TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )),
        backgroundColor: WidgetStatePropertyAll(secondaryBgColor),
        foregroundColor: const WidgetStatePropertyAll(_Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ));

    iconButtonStyle ??= IconButton.styleFrom(
      backgroundColor: secondaryBgColor,
      shadowColor: _Colors.black,
      elevation: 2.0,
    );

    return ShoppingThemeData._raw(
      coloredBackground: coloredBackground,
      activeItemColor: activeItemColor,
      primaryBgColor: primaryBgColor,
      secondaryBgColor: secondaryBgColor,
      textColor: textColor,
      inputBorderColor: inputBorderColor,
      titleH1TextStyle: titleH1TextStyle,
      titleH2TextStyle: titleH2TextStyle,
      buttonTextStyle: buttonTextStyle,
      defaultTextStyle: defaultTextStyle,
      hintTextStyle: hintTextStyle,
      subheaderTextStyle: subheaderTextStyle,
      labelTextStyle: labelTextStyle,
      inputHintStyle: inputHintStyle,
      titledButtonStyle: titledButtonStyle,
      iconButtonStyle: iconButtonStyle,
    );
  }

  const ShoppingThemeData._raw({
    required this.coloredBackground,
    required this.activeItemColor,
    required this.primaryBgColor,
    required this.secondaryBgColor,
    required this.textColor,
    required this.inputBorderColor,
    required this.titleH1TextStyle,
    required this.titleH2TextStyle,
    required this.buttonTextStyle,
    required this.defaultTextStyle,
    required this.hintTextStyle,
    required this.subheaderTextStyle,
    required this.labelTextStyle,
    required this.inputHintStyle,
    required this.titledButtonStyle,
    required this.iconButtonStyle,
  });

  // Цвет фона шторки
  final Color? coloredBackground;
  // Цвет активного элемента
  final Color? activeItemColor;
  // Основной цвет фона
  final Color primaryBgColor;
  // Дополнительный цвет фона
  final Color? secondaryBgColor;
  final Color? textColor;
  final Color inputBorderColor;

  final TextStyle? titleH1TextStyle;
  final TextStyle? titleH2TextStyle;
  final TextStyle? buttonTextStyle;
  final TextStyle? defaultTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? subheaderTextStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? inputHintStyle;

  final ButtonStyle? titledButtonStyle;
  final ButtonStyle? iconButtonStyle;
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
  static const greenDark = Color(0xFF4F967A);
  static const greenLight = Color.fromARGB(255, 0, 217, 0);
  static const greyLight = Color(0xFFF4F4F4);
  static const greyDark = Color.fromARGB(255, 112, 111, 111);
  static const white = Color.fromARGB(255, 245, 245, 245);
  static const black = Color(0xFF090909);
  static const blue = Color(0xFF257BF4);
}
