import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/application/localizations.dart';
import 'package:shopping_list_example/application/theme.dart';
import 'package:shopping_list_example/models/product/product.dart';
import 'package:shopping_list_example/screens/common_content_screen.dart';
import 'package:shopping_list_example/screens/create_item_screen.dart';
import 'package:shopping_list_example/utils/context_extension.dart';
import 'package:shopping_list_example/widgets/stub.dart';

/// Экран выбора продуктов.
///
/// Содержит список всех продуктов
/// и по тапу добавляет продукт в список покупок.
/// Все продукты, содержащиеся в текущем спике покупок, отмечены цветом.
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Box<Product>? _box;

  @override
  Widget build(BuildContext context) {
    return CommonContentScreen(
      title: context.loc.productsScreenTitle,
      onFABPressed: () => context.goNamed(createName,
          extra: CreateItemScreenArgs(ItemType.product, productBox: _box)),
      child: FutureBuilder(
          future: Hive.openBox<Product>(productsBoxName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _box = snapshot.data as Box<Product>;
              return ProductsContent(
                productsBox: _box!,
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class ProductsContent extends StatefulWidget {
  final Box<Product> productsBox;
  const ProductsContent({
    super.key,
    required this.productsBox,
  });

  @override
  State<ProductsContent> createState() => _ProductsContentState();
}

class _ProductsContentState extends State<ProductsContent> {
  late final Box<Product> _productsBox;

  @override
  void initState() {
    super.initState();
    _productsBox = widget.productsBox;
    // _productsBox.resetToContains(_shoppingBox);
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = context.theme;

    return _buildProuductsList(context, loc, theme);
  }

  Widget _buildProuductsList(
    BuildContext context,
    AppLocalizations loc,
    ShoppingThemeData theme,
  ) {
    return ValueListenableBuilder(
      valueListenable: _productsBox.listenable(),
      builder: (context, value, _) {
        final products = value.values.toList();
        return products.isEmpty
            ? Stub(loc.noSavedProductsTitle)
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  return _buildProductItem(
                    context,
                    item,
                    theme,
                  );
                },
              );
      },
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    Product item,
    ShoppingThemeData theme,
  ) {
    return Card.outlined(
      color: theme.activeItemColor,
      child: InkWell(
        onTap: () => _onItemTap(item),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(item.name),
        ),
      ),
    );
  }

  void _onItemTap(Product item) {
    // final changed = item.switchActive();
    // if (item.isActive) {
    //   _productsBox.put(changed.id, changed);
    //   _shoppingBox.delete(changed.id);
    // } else {
    //   final copy = Product.copy(changed);
    //   _shoppingBox.put(copy.id, copy);

    //   _productsBox.put(changed.id, changed);
    // }
  }
}
