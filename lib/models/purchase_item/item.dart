import 'package:hive/hive.dart';
import 'package:uuid/v4.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  bool isActive;

  Item({required this.id, required this.name, this.isActive = false});

  Item switchActive() => Item(
        id: id,
        name: name,
        isActive: !isActive,
      );

  // Hive не дает сохранять один объект в разные боксы, нужна копия
  static Item copy(Item item) => Item(
        id: const UuidV4().generate(),
        name: item.name,
        isActive: item.isActive,
      );

  factory Item.create(String name) {
    final id = const UuidV4().generate();
    return Item(id: id, name: name);
  }

  @override
  String toString() => 'Item $name, $id, isActive: $isActive';
}
