import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/models/purchase_item/item.dart';

extension ResetBox on Box<Item> {
  void resetToContains(Box<Item> other) {
    if (isEmpty) return;
    if (other.isEmpty) {
      for (var v in values) {
        put(
          v.id,
          Item(id: v.id, name: v.name, isActive: false),
        );
      }
    } else {
      for (var v in values) {
        put(
          v.id,
          Item(id: v.id, name: v.name, isActive: other.containsKey(v.id)),
        );
      }
    }
  }
}
