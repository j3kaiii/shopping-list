import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/application/localizations.dart';
import 'package:shopping_list_example/application/theme.dart';
import 'package:shopping_list_example/models/product/product.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';
import 'package:shopping_list_example/models/shopping_list_item/shopping_list_item.dart';
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
  final ShoppingList? shoppingList;
  const ProductsScreen({this.shoppingList, super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Box<Product>? _box;

  @override
  Widget build(BuildContext context) {
    final fromShopping = widget.shoppingList != null;
    return CommonContentScreen(
      title: context.loc.productsScreenTitle,
      onFABPressed: () => context.pushNamed(
        fromShopping ? createShoppingProduct : createCommonProduct,
        extra: CreateItemScreenArgs(ItemType.product, productBox: _box),
      ),
      showBackButton: fromShopping,
      child: FutureBuilder(
          future: Hive.openBox<Product>(productsBoxName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _box = snapshot.data as Box<Product>;
              return ProductsContent(
                productsBox: _box!,
                shoppingList: widget.shoppingList,
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
  final ShoppingList? shoppingList;

  const ProductsContent({
    super.key,
    this.shoppingList,
    required this.productsBox,
  });

  @override
  State<ProductsContent> createState() => _ProductsContentState();
}

class _ProductsContentState extends State<ProductsContent> {
  late final Box<Product> _productsBox;
  ShoppingList? _shoppingList;

  @override
  void initState() {
    super.initState();
    _productsBox = widget.productsBox;
    _shoppingList = widget.shoppingList;
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
    final inList = _shoppingList?.containsProduct(item.id) ?? false;
    return Card.outlined(
      color: inList ? theme.activeItemColor : theme.primaryBgColor,
      child: InkWell(
        onTap: () => _onItemTap(item),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(item.name),
        ),
      ),
    );
  }

  /// Добавление/удаление продукта [ShoppingListItem] для списка покупок,
  /// переданного параметром [ShoppingList] при переходе к экрану.
  ///
  /// Если данный [ShoppingListItem] содержится в списке,
  /// то необходимо удалить его из списка и из бокса.
  /// Если в списке такого нет, нужно создать экземпляр [ShoppingListItem],
  /// сохранить его в боксе и добавить в список [ShoppingList].
  /// ВАЖНО: переданный [Product] может содержаться в разных списках,
  /// но он содержится там не в чистом виде, а в виде экземпляров [ShoppingListItem],
  /// созданных на основе [Product].
  /// Id таких [ShoppingListItem] должны быть уникальными, это не [Product] id.
  void _onItemTap(Product item) {
    final list = _shoppingList;
    if (list == null) return;

    final shoppingItemsBox = Hive.box<ShoppingListItem>(itemsBoxName);
    final listsBox = Hive.box<ShoppingList>(listsBoxName);

    if (list.containsProduct(item.id)) {
      final updatedList = list.removeProduct(item.id);
      listsBox.put(updatedList.id, updatedList);
      shoppingItemsBox.delete(item.id);
    } else {
      final newListItem = ShoppingListItem.create(item);
      final updatedList = list.addProduct(newListItem);
      listsBox.put(updatedList.id, updatedList);
      shoppingItemsBox.put(newListItem.id, newListItem);
    }

    setState(() {
      _shoppingList = listsBox.get(list.id);
    });
  }
}
