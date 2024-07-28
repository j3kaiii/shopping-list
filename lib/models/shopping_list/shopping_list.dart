import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/v4.dart';

part 'shopping_list.g.dart';

@HiveType(typeId: 1)
class ShoppingList extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  ShoppingList(this.name) : id = const UuidV4().generate();
}
