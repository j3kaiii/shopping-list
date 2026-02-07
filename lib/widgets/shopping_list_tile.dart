import 'package:flutter/material.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';
import 'package:shopping_list_example/utils/context_extension.dart';

class ShoppingListTile extends StatelessWidget {
  final ShoppingList shoppingList;
  const ShoppingListTile(this.shoppingList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        child: Column(
          children: [
            _buildTitle(context),
            _buildProgress(context),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          shoppingList.name,
          style: context.theme.buttonTextStyle,
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
      ],
    );
  }

  Widget _buildProgress(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('12/20 items collected'), Text('60%')],
          ),
          LinearProgressIndicator(
            value: 0.6,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      style: context.theme.buttonStyle,
      onPressed: () {},
      child: const Text('Continue shopping'),
    );
  }
}
