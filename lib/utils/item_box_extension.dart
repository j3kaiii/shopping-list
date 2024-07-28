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

  void resetAllToUnpurchased() {
    if (isEmpty) return;
    final itemsList = values.toList();
    itemsList.sort((a, b) => a.name.compareTo(b.name));
    final activeMap = {
      for (var e in itemsList) e.id: !e.isActive ? e.switchActive() : e
    };
    putAll(activeMap);
  }
}
