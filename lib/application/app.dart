import 'package:flutter/material.dart';
import 'package:flutter_custom_theme/flutter_custom_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/app_routes.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/application/localizations.dart';
import 'package:shopping_list_example/application/theme.dart';
import 'package:shopping_list_example/models/purchase_item/item.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';

class ShoppingApp extends StatelessWidget {
  static final List<LocalizationsDelegate<dynamic>> _localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const _supportedLocales = [
    Locale('en'),
    Locale('ru'),
  ];

  static final _themesData = [ShoppingTheme.main];

  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomThemes(
      data: _themesData,
      child: Builder(
        builder: (themeContext) {
          final shoppingTheme = ShoppingTheme.of(context);

          return MaterialApp.router(
            theme: shoppingTheme.theme(),
            darkTheme: shoppingTheme.darkTheme(),
            themeMode: ThemeMode.system,
            routerConfig: appRoutes,
            localizationsDelegates: _localizationsDelegates,
            supportedLocales: _supportedLocales,
          );
        },
      ),
    );
  }
}

void runWithHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(ShoppingListAdapter());
  await Hive.openBox<ShoppingList>(listsBoxName);
  runApp(const ShoppingApp());
}
