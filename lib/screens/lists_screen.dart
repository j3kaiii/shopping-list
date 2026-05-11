import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_shopping/application/consts.dart';
import 'package:go_shopping/application/localizations.dart';
import 'package:go_shopping/models/shopping_list/shopping_list.dart';
import 'package:go_shopping/screens/common_content_screen.dart';
import 'package:go_shopping/screens/create_item_screen.dart';
import 'package:go_shopping/utils/context_extension.dart';
import 'package:go_shopping/widgets/shopping_list_tile.dart';

/// Экран списков продуктов.
class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  late final TextEditingController _textController;
  late final Box<ShoppingList> _listsBox;

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
      onFABPressed: () => context.pushNamed(createList,
          extra: const CreateItemScreenArgs(ItemType.list)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: _buildList(context, loc),
      ),
    );
  }

  Widget _buildList(BuildContext context, AppLocalizations loc) {
    return ValueListenableBuilder(
      valueListenable: _listsBox.listenable(),
      builder: ((context, value, _) {
        final lists = value.values.toList();

        lists.sort((a, b) {
          final progressA = a.items.isEmpty
              ? 0.0
              : a.items.where((i) => i.isPurchased).length / a.items.length;
          final progressB = b.items.isEmpty
              ? 0.0
              : b.items.where((i) => i.isPurchased).length / b.items.length;

          if (progressA == 1.0 && progressB != 1.0) return 1;
          if (progressB == 1.0 && progressA != 1.0) return -1;
          return 0;
        });

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FittedBox(fit: BoxFit.contain, child: Icon(Icons.no_food)),
          const SizedBox(height: 50),
          Text(
            context.loc.noSavedListsYet,
            style: context.theme.hintTextStyle,
          ),
        ],
      ),
    );
  }
}
