import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/application/localizations.dart';
import 'package:shopping_list_example/blocs/screens/shopping_screen/shopping_screen_bloc.dart';
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
    return BlocProvider<ShoppingScreenBloc>(
      create: (context) => ShoppingScreenBloc()
        ..add(ShoppingShown(shoppingArgs.shopping, shoppingArgs.editMode)),
      child: BlocBuilder<ShoppingScreenBloc, ShoppingScreenState>(
          builder: (context, state) {
        final isLoaded = state is ShoppingLoadSuccess;
        final actions = isLoaded
            ? [
                _buildEditToggleButton(context, state.editMode),
                _buildResetButton(context),
              ]
            : null;

        return CommonContentScreen(
          title: isLoaded ? state.shopping.name : '',
          showBackButton: true,
          actions: actions,
          onFABPressed: () {
            isLoaded
                ? context.pushNamed(shoppingProducts,
                    extra: shoppingArgs.shopping.id)
                : null;
          },
          child: isLoaded
              ? ShoppingContent(
                  list: state.shopping,
                  editMode: state.editMode,
                )
              : const CircularProgressIndicator(),
        );
      }),
    );
  }

  Widget _buildEditToggleButton(BuildContext context, bool editMode) {
    return IconButton(
      onPressed: () {
        context.read<ShoppingScreenBloc>().add(const ShoppingToggleEditMode());
      },
      icon: Icon(editMode ? Icons.check : Icons.edit),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<ShoppingScreenBloc>().add(const ShoppingReset());
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
  final bool editMode;

  const ShoppingContent({
    super.key,
    required this.list,
    this.editMode = false,
  });

  @override
  State<ShoppingContent> createState() => _ShoppingContentState();
}

class _ShoppingContentState extends State<ShoppingContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
    if (items.isEmpty) {
      return Stub(loc.emptyShoppingListTitle);
    }

    final sortedItems = List<ShoppingListItem>.from(items)
      ..sort((a, b) {
        if (a.isPurchased == b.isPurchased) return 0;
        return a.isPurchased ? 1 : -1;
      });

    return ListView.builder(
      itemCount: sortedItems.length,
      itemBuilder: (context, index) {
        final item = sortedItems[index];
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
          confirmDismiss: (_) => _confirmDelete(context),
          onDismissed: (_) => _removeItem(context, item),
          child: ListItem(
            name: item.baseName,
            color: widget.editMode
                ? null
                : (item.isPurchased ? null : theme.activeItemColor),
            onTap: widget.editMode
                ? () => _showEditItemDialog(item, loc)
                : () => _onItemTap(context, item),
          ),
        );
      },
    );
  }

  bool _hasShownDialog = false;

  void _onItemTap(BuildContext context, ShoppingListItem item) {
    _hasShownDialog = false;
    context.read<ShoppingScreenBloc>().add(ShoppingItemStatusChanged(item));
  }

  @override
  void didUpdateWidget(ShoppingContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_hasShownDialog && widget.list.items.isNotEmpty) {
      final hasUnpurchased = widget.list.items.any((i) => !i.isPurchased);
      if (!hasUnpurchased) {
        _hasShownDialog = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showAllPurchasedDialog(context);
          }
        });
      }
    }
  }

  void _showAllPurchasedDialog(BuildContext context) {
    final loc = context.loc;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.congratulationsTitle),
        content: Text(loc.allItemsPurchasedMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(loc.btnCancel),
          ),
          FilledButton(
            onPressed: () {
              context.read<ShoppingScreenBloc>().add(const ShoppingReset());
              Navigator.of(dialogContext).pop();
            },
            child: Text(loc.btnReset),
          ),
        ],
      ),
    );
  }

  void _removeItem(BuildContext context, ShoppingListItem item) {
    context.read<ShoppingScreenBloc>().add(ShoppingItemRemoved(item));
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
              context
                  .read<ShoppingScreenBloc>()
                  .add(ShoppingItemEdit(updatedItem));

              Navigator.pop(context);
            },
            child: Text(loc.btnOk),
          ),
        ],
      ),
    );
  }
}
