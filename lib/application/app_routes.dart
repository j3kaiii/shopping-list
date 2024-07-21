import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/models/purchase_item/item.dart';
import 'package:shopping_list_example/screens/lists_screen.dart';
import 'package:shopping_list_example/screens/loading_screen.dart';
import 'package:shopping_list_example/screens/products_screen.dart';
import 'package:shopping_list_example/screens/shopping_screen.dart';

final appRoutes = GoRouter(
  initialLocation: loading,
  routes: [
    GoRoute(
      path: loading,
      name: loading,
      builder: (context, state) => const LoadingScreen(),
    ),
    GoRoute(
      path: root,
      name: root,
      builder: (context, state) => const ListsScreen(),
      routes: [
        GoRoute(
          path: shoppingPath,
          name: shoppingName,
          builder: (context, state) => ShoppingScreen(
            shoppingId: state.pathParameters[shoppingParams] as String,
          ),
          routes: [
            GoRoute(
              path: productsPath,
              name: products,
              builder: (context, state) => ProductsScreen(
                shoppingBox: state.extra as Box<Item>,
              ),
            )
          ],
        )
      ],
    ),
  ],
);
