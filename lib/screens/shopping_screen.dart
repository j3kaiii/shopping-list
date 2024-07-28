import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/application/localizations.dart';
import 'package:shopping_list_example/models/purchase_item/item.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';
import 'package:shopping_list_example/screens/common_content_screen.dart';
import 'package:shopping_list_example/utils/context_extension.dart';
import 'package:shopping_list_example/widgets/list_item.dart';
import 'package:shopping_list_example/widgets/stub.dart';

/// Экран списка продуктов.
///
/// При тапе на продукт отмечает его как купленный.
/// listUid - uid списка продуктов,
/// если не указан, то это новый список,
/// нужно показать заглушку и предложить добавить продукты
/// (переход на экран выбора продуктов)

class ShoppingScreen extends StatelessWidget {
  final ShoppingList shopping;
  const ShoppingScreen({super.key, required this.shopping});

  @override
  Widget build(BuildContext context) {
    return CommonContentScreen(
      title: shopping.name,
      child: FutureBuilder(
        future: Hive.openBox<Item>(shopping.id),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ShoppingContent(
              box: snapshot.data as Box<Item>,
              listId: shopping.id,
            );
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}

class ShoppingContent extends StatefulWidget {
  final String listId;
  final Box<Item> box;

  const ShoppingContent({super.key, required this.box, required this.listId});

  @override
  State<ShoppingContent> createState() => _ShoppingContentState();
}

class _ShoppingContentState extends State<ShoppingContent> {
  late final Box<Item> _productsBox;

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
        child: Stack(
          children: [
            _buildList(context, loc),
            _buildAddProduct(context, loc),
          ],
        ),
      ),
    );
  }

  Widget _buildAddProduct(BuildContext context, AppLocalizations loc) {
    return PositionedDirectional(
      end: 20,
      bottom: 20,
      child: ElevatedButton.icon(
        onPressed: () => context.pushNamed(
          products,
          extra: _productsBox,
        ),
        icon: const Icon(Icons.add),
        label: Text(loc.btnAdd),
      ),
    );
  }

  Widget _buildList(BuildContext context, AppLocalizations loc) {
    return ValueListenableBuilder(
      valueListenable: _productsBox.listenable(),
      builder: ((context, value, _) {
        final items = value.values.toList();
        items.sort((a, b) => b.isActive ? 1 : -1);

        return items.isEmpty
            ? Stub(loc.emptyShoppingListTitle)
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListItem(
                    name: item.name,
                    color: item.isActive ? Colors.lightBlue : null,
                    onTap: () => _onItemTap(item),
                  );
                },
              );
      }),
    );
  }

  void _onItemTap(Item item) {
    _productsBox.put(item.id, item.switchActive());
  }
}
