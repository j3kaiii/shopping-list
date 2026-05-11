import 'package:flutter/material.dart';
import 'package:flutter_custom_theme/flutter_custom_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_shopping/application/app_routes.dart';
import 'package:go_shopping/application/consts.dart';
import 'package:go_shopping/application/localizations.dart';
import 'package:go_shopping/application/theme.dart';
import 'package:go_shopping/models/product/product.dart';
import 'package:go_shopping/models/shopping_list/shopping_list.dart';
import 'package:go_shopping/models/shopping_list_item/shopping_list_item.dart';

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
          final shoppingTheme = ShoppingTheme.of(themeContext);

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
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(ShoppingListAdapter());
  Hive.registerAdapter(ShoppingListItemAdapter());
  await Hive.openBox<ShoppingList>(listsBoxName);
  await Hive.openBox<ShoppingListItem>(itemsBoxName);
  runApp(const ShoppingApp());
}
