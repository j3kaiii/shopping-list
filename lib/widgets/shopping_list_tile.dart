import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:animations/animations.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';
import 'package:shopping_list_example/screens/shopping_screen.dart';
import 'package:shopping_list_example/utils/context_extension.dart';

class ShoppingListTile extends StatefulWidget {
  final ShoppingList shoppingList;
  const ShoppingListTile(this.shoppingList, {super.key});

  @override
  State<ShoppingListTile> createState() => _ShoppingListTileState();
}

class _ShoppingListTileState extends State<ShoppingListTile> {
  static const _singleActionWidth = 45.0;
  static const _actionsHeight = 45.0;
  static const _doubleActionWidth = 100.0;
  bool _showFullActions = false;

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
          widget.shoppingList.name,
          style: context.theme.buttonTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
        _buildActions(context),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return SizedBox(
      height: _actionsHeight,
      child: Row(
        children: [
          _buildAnimatedChild(
            isVisible: !_showFullActions,
            width: _singleActionWidth,
            child: _buildMoreAction(context),
          ),
          _buildAnimatedChild(
            isVisible: _showFullActions,
            width: _doubleActionWidth,
            child: _buildEditActions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreAction(BuildContext context) {
    return IconButton(
      onPressed: _showActions,
      icon: const Icon(Icons.more_vert),
    );
  }

  Widget _buildEditActions(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => _editList(context),
            icon: const Icon(Icons.edit),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () => print('called delete'),
            icon: const Icon(Icons.delete),
            padding: EdgeInsets.zero,
          ),
        ],
      );

  void _editList(BuildContext content) {
    context.goNamed(shoppingName,
        extra: ShoppingScreenArgs(widget.shoppingList, editMode: true));
  }

  Widget _buildAnimatedChild({
    required bool isVisible,
    required double width,
    required Widget child,
  }) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: SizedBox(
        width: isVisible ? width : 0,
        height: _actionsHeight,
        child: isVisible ? child : null,
      ),
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

  void _showActions() {
    setState(() {
      _showFullActions = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showFullActions = false;
        });
      }
    });
  }
}
