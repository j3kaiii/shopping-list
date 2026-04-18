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
      actions: [
        _buildEditToggleButton(context),
        _buildResetButton(context),
      ],
      onFABPressed: () => context.pushNamed(shoppingProducts, extra: shopping),
      child: FutureBuilder(
        future: Hive.openBox<ShoppingListItem>(shopping.id),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ShoppingContent(
              box: snapshot.data as Box<ShoppingListItem>,
              list: shopping,
              editMode: shoppingArgs.editMode,
            );
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }

  Widget _buildEditToggleButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pushNamed(
          shopping,
          extra: ShoppingScreenArgs(
            shoppingArgs.shopping,
            editMode: !shoppingArgs.editMode,
          ),
        );
      },
      icon: Icon(
        shoppingArgs.editMode ? Icons.check : Icons.edit,
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
  final bool editMode;

  const ShoppingContent({
    super.key,
    required this.box,
    required this.list,
    this.editMode = false,
  });

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
              return Dismissible(
                key: Key(item.id),
                direction: widget.editMode
                    ? DismissDirection.endToStart
                    : DismissDirection.none,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                dismissThresholds: const {DismissDirection.endToStart: 0.25},
                confirmDismiss: (direction) => _confirmDelete(context),
                onDismissed: (direction) {
                  _removeItem(item.baseProductId);
                },
                child: ListItem(
                  name: item.baseName,
                  color: widget.editMode
                      ? null
                      : (item.isPurchased ? theme.activeItemColor : null),
                  onTap: widget.editMode
                      ? () => _showEditItemDialog(item, loc)
                      : () => _onItemTap(item.baseProductId),
                ),
              );
            },
          );
  }

  void _onItemTap(String productId) {
    widget.list.togglePurchaseStatus(productId);
    setState(() {});
  }

  void _removeItem(String productId) {
    final item = widget.list.items.firstWhere(
      (i) => i.baseProductId == productId,
    );
    _productsBox.delete(item.id);

    final updatedList = widget.list.removeProduct(productId);
    final listsBox = Hive.box<ShoppingList>(listsBoxName);
    listsBox.put(updatedList.id, updatedList);

    setState(() {});
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final loc = context.loc;
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        content: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(loc.deleteProductDialogTitle),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(loc.btnCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(loc.btnDelete),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _showEditItemDialog(ShoppingListItem item, AppLocalizations loc) {
    final quantityController =
        TextEditingController(text: item.quantity.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.editProduct),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.baseName),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: loc.quantity,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.btnCancel),
          ),
          TextButton(
            onPressed: () {
              final newQuantity = int.tryParse(quantityController.text) ?? 1;
              final updatedItem = item.copyWith(quantity: newQuantity);
              _productsBox.put(updatedItem.id, updatedItem);

              final updatedList = widget.list;
              final itemIndex = updatedList.items.indexWhere(
                (i) => i.baseProductId == item.baseProductId,
              );
              if (itemIndex != -1) {
                updatedList.items[itemIndex] = updatedItem;
                final listsBox = Hive.box<ShoppingList>(listsBoxName);
                listsBox.put(updatedList.id, updatedList);
              }

              Navigator.pop(context);
              setState(() {});
            },
            child: Text(loc.btnOk),
          ),
        ],
      ),
    );
  }
}
