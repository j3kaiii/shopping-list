import 'package:go_router/go_router.dart';
import 'package:shopping_list_example/application/consts.dart';
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
          path: shopping,
          name: shopping,
          builder: (context, state) => ShoppingScreen(
            shoppingArgs: state.extra as ShoppingScreenArgs,
          ),
          routes: [
            _createProductsRoute(shoppingProducts, common: false),
          ],
        ),
        _createProductsRoute(commonProducts),
        _createItemRoute(createList),
      ],
    ),
  ],
);

GoRoute _createProductsRoute(String route, {bool common = true}) => GoRoute(
        path: route,
        name: route,
        builder: (context, state) => ProductsScreen(
              shoppingListId: state.extra as String?,
            ),
        routes: [
          _createItemRoute(common ? createCommonProduct : createShoppingProduct)
        ]);

GoRoute _createItemRoute(String route) => GoRoute(
      path: route,
      name: route,
      builder: (context, state) =>
          CreateItemScreen(state.extra as CreateItemScreenArgs),
    );
