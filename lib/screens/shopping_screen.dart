import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/application/localizations.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';
import 'package:shopping_list_example/models/shopping_list_item/shopping_list_item.dart';
import 'package:shopping_list_example/screens/common_content_screen.dart';
import 'package:shopping_list_example/utils/context_extension.dart';
import 'package:shopping_list_example/widgets/list_item.dart';
import 'package:shopping_list_example/widgets/stub.dart';

class ShoppingScreenArgs {
  final ShoppingList shopping;
  final bool editMode;

  ShoppingScreenArgs(this.shopping, {required this.editMode});
}

/// Экран списка продуктов.
///
/// При тапе на продукт отмечает его как купленный.
class ShoppingScreen extends StatelessWidget {
  final ShoppingScreenArgs shoppingArgs;
  const ShoppingScreen({super.key, required this.shoppingArgs});

  @override
  Widget build(BuildContext context) {
    final shopping = shoppingArgs.shopping;
    return CommonContentScreen(
      title: shopping.name,
      showBackButton: true,
      actions: [_buildResetButton(context)],
      onFABPressed: () => context.goNamed(productsName, extra: shopping),
      child: FutureBuilder(
        future: Hive.openBox<ShoppingListItem>(shopping.id),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ShoppingContent(
              box: snapshot.data as Box<ShoppingListItem>,
              list: shopping,
            );
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        // final box = await Hive.openBox<Product>(shopping.id);
        // box.resetAllToUnpurchased();
      },
      icon: Transform.flip(
        flipX: true,
        child: const Icon(
          Icons.refresh,
        ),
      ),
    );
  }
}

class ShoppingContent extends StatefulWidget {
  final ShoppingList list;
  final Box<ShoppingListItem> box;

  const ShoppingContent({super.key, required this.box, required this.list});

  @override
  State<ShoppingContent> createState() => _ShoppingContentState();
}

class _ShoppingContentState extends State<ShoppingContent> {
  late final Box<ShoppingListItem> _productsBox;

  @override
  void initState() {
    super.initState();
    _productsBox = widget.box;
  }

  @override
  void dispose() {
    _productsBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: _buildList(context, loc),
      ),
    );
  }

  Widget _buildList(BuildContext context, AppLocalizations loc) {
    final theme = context.theme;
    final items = widget.list.items;
    return items.isEmpty
        ? Stub(loc.emptyShoppingListTitle)
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListItem(
                name: item.baseName,
                color: theme.activeItemColor,
                onTap: () => _onItemTap(item.baseProductId),
              );
            },
          );
  }

  void _onItemTap(String productId) {
    widget.list.togglePurchaseStatus(productId);
  }
}
