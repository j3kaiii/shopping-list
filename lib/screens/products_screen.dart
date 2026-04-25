import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/application/theme.dart';
import 'package:shopping_list_example/blocs/screens/products_screen/products_screen_bloc.dart';
import 'package:shopping_list_example/models/product/product.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';
import 'package:shopping_list_example/screens/common_content_screen.dart';
import 'package:shopping_list_example/screens/create_item_screen.dart';
import 'package:shopping_list_example/utils/context_extension.dart';
import 'package:shopping_list_example/widgets/stub.dart';

class ProductsScreen extends StatelessWidget {
  final ShoppingList? shoppingList;
  const ProductsScreen({this.shoppingList, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsScreenBloc>(
      create: (context) =>
          ProductsScreenBloc()..add(ProductsScreenStarted(shoppingList)),
      child: BlocBuilder<ProductsScreenBloc, ProductsScreenState>(
          builder: (context, state) {
        final isLoaded = state is ProductsScreenLoadSuccess;
        final fromShopping = shoppingList != null;
        final bloc = context.read<ProductsScreenBloc>();

        return CommonContentScreen(
          title: context.loc.productsScreenTitle,
          onFABPressed: () => context.pushNamed(
            fromShopping ? createShoppingProduct : createCommonProduct,
            extra: CreateItemScreenArgs(
              ItemType.product,
              productBox: isLoaded ? bloc.productsBox : null,
              ownerList: shoppingList?.id,
            ),
          ),
          showBackButton: fromShopping,
          child: isLoaded
              ? ProductsContent(
                  products: state.products,
                  shoppingList: state.shoppingList,
                )
              : const CircularProgressIndicator(),
        );
      }),
    );
  }
}

class ProductsContent extends StatelessWidget {
  final List<Product> products;
  final ShoppingList? shoppingList;

  const ProductsContent({
    super.key,
    required this.products,
    this.shoppingList,
  });

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = context.theme;

    return products.isEmpty
        ? Stub(loc.noSavedProductsTitle)
        : ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final item = products[index];
              return _ProductItem(
                product: item,
                inList: shoppingList?.containsProduct(item.id) ?? false,
                theme: theme,
              );
            },
          );
  }
}

class _ProductItem extends StatelessWidget {
  final Product product;
  final bool inList;
  final ShoppingThemeData theme;

  const _ProductItem({
    required this.product,
    required this.inList,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: inList ? theme.activeItemColor : theme.primaryBgColor,
      child: InkWell(
        onTap: () => context
            .read<ProductsScreenBloc>()
            .add(ProductsScreenProductToggled(product)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(product.name),
        ),
      ),
    );
  }
}