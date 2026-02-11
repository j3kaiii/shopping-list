import 'package:flutter/material.dart';
import 'package:shopping_list_example/screens/common_content_screen.dart';

class CreateItemScreenArgs {
  final ItemType type;
  final String? ownerList;

  const CreateItemScreenArgs(this.type, {this.ownerList});
}

class CreateItemScreen extends StatefulWidget {
  final CreateItemScreenArgs args;
  const CreateItemScreen(this.args, {super.key});

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  // TODO: при создании продукта он добавляется в общую базу
  // и сразу привязывается к списку ownerList.
  // При создании списка
  // проиграть анимашку с галочкой,
  // затем кнопка "Сохранить" меняется на "Добавить продукты"
  @override
  Widget build(BuildContext context) {
    return const CommonContentScreen(title: 'Add new', child: Placeholder());
  }
}

enum ItemType {
  list,
  product,
}
