import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/models/purchase_item/item.dart';
import 'package:shopping_list_example/screens/common_content_screen.dart';
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
  final String shoppingId;
  const ShoppingScreen({super.key, required this.shoppingId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox<Item>(shoppingId),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ShoppingContent(
              box: snapshot.data as Box<Item>,
              listName: shoppingId,
            );
          } else {
            return const CircularProgressIndicator();
          }
        }));
  }
}

class ShoppingContent extends StatefulWidget {
  final String listName;
  final Box<Item> box;

  const ShoppingContent({super.key, required this.box, required this.listName});

  @override
  State<ShoppingContent> createState() => _ShoppingContentState();
}

class _ShoppingContentState extends State<ShoppingContent> {
  @override
  void dispose() {
    widget.box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonContentScreen(
      title: widget.listName,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            children: [
              _buildList(context),
              _buildAddProduct(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddProduct(BuildContext context) {
    return PositionedDirectional(
      end: 20,
      bottom: 20,
      child: ElevatedButton.icon(
        onPressed: () => context.goNamed(
          products,
          pathParameters: {shoppingParams: widget.listName},
          extra: widget.box,
        ),
        icon: const Icon(Icons.add),
        label: const Text('add products'),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.box.listenable(),
      builder: ((context, value, _) {
        final count = value.values.length;

        if (count < 1) return const Stub('No products');
        final lists = value.values.toList();

        return ListView.builder(
          itemCount: count,
          itemBuilder: (context, index) => ListItem(
            name: lists[index].name,
            onTap: () {},
          ),
        );
      }),
    );
  }
}
