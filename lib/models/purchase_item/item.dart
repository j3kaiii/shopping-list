import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  bool isActive;

  Item({required this.name, this.isActive = true});

  @override
  String toString() => 'Item $name, isActive: $isActive';
}
