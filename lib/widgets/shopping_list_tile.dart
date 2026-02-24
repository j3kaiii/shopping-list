import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list_example/application/consts.dart';
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
    final buttonKey = GlobalKey();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          shoppingList.name,
          style: context.theme.buttonTextStyle,
        ),
        IconButton(
          key: buttonKey,
          onPressed: () => _showActions(context, buttonKey),
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  Widget _buildProgress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('12/20 items collected'), Text('60%')],
          ),
          LinearProgressIndicator(
            color: context.theme.secondaryBgColor,
            value: 0.6,
            minHeight: 8.0,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      style: context.theme.titledButtonStyle,
      onPressed: () {},
      child: const Text('Continue shopping'),
    );
  }

  void _showActions(BuildContext context, GlobalKey buttonKey) {
    const editKey = 'edit';
    const deleteKey = 'delete';
    final loc = context.loc;
    final RenderBox button =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<String>(value: editKey, child: Text(loc.btnEdit)),
        PopupMenuItem<String>(value: deleteKey, child: Text(loc.btnDelete)),
      ],
    ).then((value) {
      if (value == editKey) {
        if (context.mounted) {
          context.goNamed(shoppingName, extra: shoppingList);
        }
      } else if (value == deleteKey) {
        // TODO
      }
    });
  }
}
