import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/application/localizations.dart';
import 'package:shopping_list_example/models/product/product.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';
import 'package:shopping_list_example/models/shopping_list_item/shopping_list_item.dart';
import 'package:shopping_list_example/screens/common_content_screen.dart';
import 'package:shopping_list_example/screens/shopping_screen.dart';
import 'package:shopping_list_example/utils/context_extension.dart';

class CreateItemScreenArgs {
  final ItemType type;
  final String? ownerList;
  final Box<Product>? productBox;

  const CreateItemScreenArgs(this.type, {this.ownerList, this.productBox});
}

class CreateItemScreen extends StatefulWidget {
  final CreateItemScreenArgs args;
  const CreateItemScreen(this.args, {super.key});

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  final _itemNameController = TextEditingController();
  bool _validateNameExist = false;

  @override
  void initState() {
    super.initState();
    _itemNameController.addListener(_resetValidation);
  }

  @override
  void dispose() {
    _itemNameController.removeListener(_resetValidation);
    _itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = context.theme;
    final type = widget.args.type;
    return CommonContentScreen(
      title: loc.createItemTitle(type),
      showBackButton: true,
      bottomButtonText: loc.createItemBottomButton(type),
      onBottomButtonPressed: () => _addItem(context, type),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              loc.createItemHeader(type),
              style: theme.titleH1TextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              loc.createItemSubheader(type),
              style: theme.subheaderTextStyle,
            ),
            const SizedBox(height: 40),
            Text(
              loc.createItemNameLabel(type),
              style: theme.labelTextStyle,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _itemNameController,
              decoration: InputDecoration(
                hintText: loc.createItemNameHint(type),
                hintStyle: theme.inputHintStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: theme.inputBorderColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: theme.inputBorderColor, width: 2),
                ),
                errorText: _errorMsg(loc, type),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addItem(BuildContext context, ItemType type) async {
    final name = _itemNameController.text.trim();
    if (name.isEmpty) return;

    if (type == ItemType.list) {
      await _addList(context, name);
    } else if (type == ItemType.product) {
      await _addProduct(name);
      if (context.mounted) {
        context.pop();
      }
    }
  }

  Future<void> _addList(BuildContext context, String name) async {
    final listsBox = Hive.box<ShoppingList>(listsBoxName);
    if (listsBox.values
        .any((l) => l.name.toLowerCase() == name.toLowerCase())) {
      setState(() {
        _validateNameExist = true;
      });
      return;
    }
    final newList = ShoppingList.create(name: name);
    await listsBox.put(newList.id, newList);
    if (context.mounted) {
      context.replaceNamed(shopping,
          extra: ShoppingScreenArgs(newList, editMode: true));
    }
  }

  Future<void> _addProduct(String name) async {
    final productsBox = widget.args.productBox;
    if (productsBox == null) {
      // TODO: возможна ли такая ситуация?
      // Добавить логирование
      return;
    }
    if (productsBox.values
        .any((p) => p.name.toLowerCase() == name.toLowerCase())) {
      setState(() {
        _validateNameExist = true;
      });
      return;
    }
    final newProduct = Product.create(name);
    await productsBox.put(newProduct.id, newProduct);
    final ownerListId = widget.args.ownerList;
    if (ownerListId != null) {
      final listsBox = Hive.box<ShoppingList>(listsBoxName);
      final currentShoppingList = listsBox.get(ownerListId);
      if (currentShoppingList?.containsProduct(newProduct.id) ?? false) {
        // TODO: какая-то ошибка
        // Добавить логирование
      }
      if (currentShoppingList != null) {
        final newListItem = ShoppingListItem.create(newProduct);
        final updatedList = currentShoppingList.addProduct(newListItem);
        listsBox.put(updatedList.id, updatedList);
        final shoppingItems = Hive.box<ShoppingListItem>(itemsBoxName);
        shoppingItems.put(newListItem.id, newListItem);
      }
    }
  }

  void _resetValidation() {
    if (_validateNameExist) {
      setState(() {
        _validateNameExist = false;
      });
    }
  }

  String? _errorMsg(AppLocalizations loc, ItemType type) =>
      _validateNameExist ? loc.createItemExistError(type) : null;
}

enum ItemType {
  list,
  product,
}
