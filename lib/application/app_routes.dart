import 'package:go_router/go_router.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';
import 'package:shopping_list_example/screens/create_item_screen.dart';
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
            shoppingArgs: state.extra as ShoppingScreenArgs,
          ),
        ),
        GoRoute(
          path: productsPath,
          name: productsName,
          builder: (context, state) => ProductsScreen(
            shoppingList: state.extra as ShoppingList?,
          ),
        ),
        GoRoute(
          path: createPath,
          name: createName,
          builder: (context, state) =>
              CreateItemScreen(state.extra as CreateItemScreenArgs),
        ),
      ],
    ),
  ],
);
