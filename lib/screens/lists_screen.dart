import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/application/localizations.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';
import 'package:shopping_list_example/screens/common_content_screen.dart';
import 'package:shopping_list_example/screens/create_item_screen.dart';
import 'package:shopping_list_example/utils/context_extension.dart';
import 'package:shopping_list_example/widgets/list_item.dart';
import 'package:shopping_list_example/widgets/shopping_list_tile.dart';

/// Экран списков продуктов.
class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  late final TextEditingController _textController;
  late final Box<ShoppingList> _listsBox;
  bool _isCreating = false;
  String? _validator;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _listsBox = Hive.box<ShoppingList>(listsBoxName);
  }

  @override
  void dispose() {
    _textController.dispose();
    _listsBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return CommonContentScreen(
      title: loc.listsScreenTitle,
      onFABPressed: () => context.goNamed(createName,
          extra: const CreateItemScreenArgs(ItemType.list)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: _buildList(context, loc),
      ),
    );
  }

  void _onCreatePressed() async {
    final res = await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Create new list'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: TextFormField(
                      controller: _textController,
                      autofocus: true,
                      validator: (v) => _validate(v, context.loc),
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        hintText: context.loc.hintCreateName,
                        // constraints: BoxConstraints(maxWidth: widget.panelWidth),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Cencel'),
                      ),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('OK')),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  String? _validate(String? input, AppLocalizations loc) {
    if (input == null || input.isEmpty) {
      return loc.emptyNameError;
    } else if (_listsBox.values.any((l) => l.name == input)) {
      return loc.existNameError;
    }
    return null;
  }

  Widget _buildList(BuildContext context, AppLocalizations loc) {
    final shoppingLists = List.generate(
        10,
        (index) =>
            ShoppingList(id: index.toString(), name: 'List #${index + 1}'));
    return ValueListenableBuilder(
      valueListenable: _listsBox.listenable(),
      builder: ((context, value, _) {
        final lists = shoppingLists; // value.values.toList();
        final count = lists.length;

        return lists.isEmpty
            ? _buildEmptyStab(context)
            : ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) => ShoppingListTile(lists[index]),
              );
      }),
    );
  }

  Widget _buildEmptyStab(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(fit: BoxFit.contain, child: Icon(Icons.no_food)),
          SizedBox(height: 50),
          Text('Списков пока нет'),
        ],
      ),
    );
  }
}
