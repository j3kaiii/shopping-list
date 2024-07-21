import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/widgets/buttons.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('My lists'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: LayoutBuilder(
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
                child: _buildBottonPanel(context, cts.maxWidth),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottonPanel(BuildContext context, double width) {
    final addButton = AddButton(
      onPressed: _onAddPressed,
      inProgress: _isCreating,
    );

    if (_isCreating) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _textController,
              autofocus: true,
              validator: (value) => _validate(value),
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

  String? _validate(String? input) {
    if (input == null || input.isEmpty) {
      return 'empty name';
    } else if (_listsBox.containsKey(input)) {
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
        final count = value.values.length;

        if (count < 1) return _buildStab(context);
        final lists = value.values.toList();

        return ListView.builder(
          itemCount: count,
          itemBuilder: (context, index) =>
              _buildListItem(context, lists[index]),
        );
      }),
    );
  }

  Widget _buildStab(BuildContext context) {
    return const Center(
      child: Text('No lists'),
    );
  }

  Widget _buildListItem(BuildContext context, String listName) {
    return InkWell(
      onTap: () => context
          .goNamed(shoppingName, pathParameters: {shoppingParams: listName}),
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(listName),
        ),
      ),
    );
  }
}
