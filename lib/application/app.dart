import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/app_routes.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/models/purchase_item/item.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoutes,
    );
  }
}

void runWithHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  await Hive.openBox<String>(listsBoxName);
  runApp(const ShoppingApp());
}
