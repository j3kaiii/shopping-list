import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/models/purchase_item/item.dart';
import 'package:shopping_list_example/widgets/buttons.dart';

/// Экран выбора продуктов.
///
/// Содержит список всех продуктов и по тапу добавляет продукт в список покупок.

class ProductsScreen extends StatelessWidget {
  final Box<Item> shoppingBox;
  const ProductsScreen({super.key, required this.shoppingBox});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All products'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder(
          future: Hive.openBox<String>(productsBoxName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ProductsContent(
                shoppingBox: shoppingBox,
                productsBox: snapshot.data as Box<String>,
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
  final Box<String> productsBox;
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
  bool _isAdding = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
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
              child: _buildBottonPanel(context, cts.maxWidth),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottonPanel(BuildContext context, double width) {
    final addButton = AddButton(
      onPressed: _onAddPressed,
      inProgress: _isAdding,
    );

    if (_isAdding) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _textController,
              autofocus: true,
              // validator: (value) => _validate(value),
              autovalidateMode: AutovalidateMode.always,
              decoration: InputDecoration(
                hintText: 'Create name',
                constraints: BoxConstraints(maxWidth: width - 46),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CancelButton(onPressed: _onCancel),
              const SizedBox(width: 12),
              addButton,
            ],
          )
        ],
      );
    } else {
      return addButton;
    }
  }

  void _onCancel() {
    setState(() {
      _textController.text = '';
      //   _validator = null;
      _isAdding = false;
    });
  }

  void _onAddPressed() {
    if (_isAdding) {
      widget.productsBox.add(_textController.text);
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

  Widget _buildStab(BuildContext context) {
    return const Center(
      child: Text('No lists'),
    );
  }

  Widget _buildProuductsList(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.productsBox.listenable(),
      builder: (context, value, _) => value.isEmpty
          ? _buildStab(context)
          : ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                return _buildProductItem(context, value.values.toList()[index]);
              },
            ),
    );
  }

  Widget _buildProductItem(BuildContext context, String productName) {
    return InkWell(
      onTap: () => widget.shoppingBox.add(Item(name: productName)),
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(productName),
        ),
      ),
    );
  }
}
