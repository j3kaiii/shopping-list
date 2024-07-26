import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/screens/common_content_screen.dart';
import 'package:shopping_list_example/widgets/bottom_panel.dart';
import 'package:shopping_list_example/widgets/list_item.dart';
import 'package:shopping_list_example/widgets/stub.dart';

/// Экран списков продуктов.
class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  late final TextEditingController _textController;
  late final Box<String> _listsBox;
  bool _isCreating = false;
  String? _validator;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _listsBox = Hive.box<String>(listsBoxName);
  }

  @override
  void dispose() {
    _textController.dispose();
    _listsBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonContentScreen(
      title: 'My lists',
      child: LayoutBuilder(
        builder: (context, cts) {
          return Stack(
            children: [
              _buildList(context),
              if (_isCreating)
                Container(
                  color:
                      const Color.fromARGB(255, 218, 243, 244).withOpacity(0.9),
                ),
              PositionedDirectional(
                end: 8,
                bottom: 8,
                child: BottomPanel(
                  isAdding: _isCreating,
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
      ),
    );
  }

  String? _validate(String? input) {
    if (input == null || input.isEmpty) {
      return 'empty name';
    } else if (_listsBox.values.contains(input)) {
      return 'name already exists';
    }
    return null;
  }

  void _onAddPressed() {
    if (_isCreating) {
      _validator = _validate(_textController.text);
      if (_validator == null) {
        _listsBox.add(_textController.text);
        _textController.text = '';
        setState(() {
          _isCreating = !_isCreating;
        });
      }
    } else {
      setState(() {
        _isCreating = !_isCreating;
      });
    }
  }

  void _onCancel() {
    setState(() {
      _textController.text = '';
      _validator = null;
      _isCreating = !_isCreating;
    });
  }

  Widget _buildList(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _listsBox.listenable(),
      builder: ((context, value, _) {
        final lists = value.values.toList();

        if (lists.isEmpty) return const Stub('no lists');

        return ListView.builder(
          itemCount: lists.length,
          itemBuilder: (context, index) => ListItem(
            name: lists[index],
            onTap: () => context.goNamed(
              shoppingName,
              pathParameters: {shoppingParams: lists[index]},
            ),
          ),
        );
      }),
    );
  }
}
