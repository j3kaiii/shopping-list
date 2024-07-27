import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/models/purchase_item/item.dart';
import 'package:shopping_list_example/screens/common_content_screen.dart';
import 'package:shopping_list_example/utils/item_box_extension.dart';
import 'package:shopping_list_example/widgets/bottom_panel.dart';
import 'package:shopping_list_example/widgets/stub.dart';

/// Экран выбора продуктов.
///
/// Содержит список всех продуктов
/// и по тапу добавляет продукт в список покупок.

class ProductsScreen extends StatelessWidget {
  final Box<Item> shoppingBox;
  const ProductsScreen({super.key, required this.shoppingBox});

  @override
  Widget build(BuildContext context) {
    return CommonContentScreen(
      title: 'All products',
      child: FutureBuilder(
          future: Hive.openBox<Item>(productsBoxName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ProductsContent(
                shoppingBox: shoppingBox,
                productsBox: snapshot.data as Box<Item>,
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class ProductsContent extends StatefulWidget {
  final Box<Item> shoppingBox;
  final Box<Item> productsBox;
  const ProductsContent({
    super.key,
    required this.shoppingBox,
    required this.productsBox,
  });

  @override
  State<ProductsContent> createState() => _ProductsContentState();
}

class _ProductsContentState extends State<ProductsContent> {
  late final TextEditingController _textController;
  late final Box<Item> _productsBox;
  late final Box<Item> _shoppingBox;
  bool _isAdding = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _productsBox = widget.productsBox;
    _shoppingBox = widget.shoppingBox;
    _productsBox.resetToContains(_shoppingBox);
  }

  @override
  void dispose() {
    _textController.dispose();
    _productsBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, cts) {
        return Stack(
          children: [
            _buildProuductsList(context),
            if (_isAdding)
              Container(
                color:
                    const Color.fromARGB(255, 218, 243, 244).withOpacity(0.9),
              ),
            PositionedDirectional(
              end: 8,
              bottom: 8,
              child: BottomPanel(
                isAdding: _isAdding,
                onAddPressed: _onAddPressed,
                onCancel: _onCancel,
                panelWidth: cts.maxWidth - 46,
                textController: _textController,
                validator: (value) => _validate(value),
              ),
            ),
          ],
        );
      },
    );
  }

  String? _validate(String? value) =>
      _productsBox.containsKey(value) ? 'Already exist' : null;

  void _onCancel() {
    setState(() {
      _textController.text = '';
      //   _validator = null;
      _isAdding = false;
    });
  }

  void _onAddPressed() {
    if (_isAdding) {
      final name = _textController.text;
      _productsBox.put(name, Item(name: name, isActive: false));
      _textController.text = '';
      setState(() {
        _isAdding = false;
      });
    } else {
      setState(() {
        _isAdding = true;
      });
    }
  }

  Widget _buildProuductsList(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _productsBox.listenable(),
      builder: (context, value, _) {
        final products = value.values.toList();
        return products.isEmpty
            ? const Stub('no products')
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  return _buildProductItem(
                    context,
                    item,
                  );
                },
              );
      },
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    Item item,
  ) {
    return Card.outlined(
      color: item.isActive ? Colors.green : null,
      child: InkWell(
        onTap: () => _onItemTap(item),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(item.name),
        ),
      ),
    );
  }

  void _onItemTap(Item item) {
    if (item.isActive) {
      _productsBox.put(item.name, Item(name: item.name, isActive: false));
      _shoppingBox.delete(item.name);
    } else {
      _shoppingBox.put(item.name, Item(name: item.name));
      _productsBox.put(item.name, Item(name: item.name));
    }
  }
}
