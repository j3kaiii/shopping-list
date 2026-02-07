import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/models/shopping_list_item/shopping_list_item.dart';
import 'package:uuid/v4.dart';

part 'shopping_list.g.dart';

@HiveType(typeId: 1)
class ShoppingList extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  final List<ShoppingListItem> items;

  ShoppingList({
    required this.id,
    required this.name,
    this.items = const [],
  });

  ShoppingList.create({required this.name})
      : id = const UuidV4().generate(),
        items = [];
  
  ShoppingList addProduct(String productId) {
    if (containsProduct(productId)) {
      return this;
    }
    
    return ShoppingList(
      id: id,
      name: name,
      items: [
        ...items,
        ShoppingListItem(productId: productId),
      ],
    );
  }

  ShoppingList removeProduct(String productId) {
    return ShoppingList(
      id: id,
      name: name,
      items: items.where((item) => item.productId != productId).toList(),
    );
  }

  ShoppingList togglePurchaseStatus(String productId) {
    return ShoppingList(
      id: id,
      name: name,
      items: items.map((item) {
        if (item.productId == productId) {
          return item.copyWith(isPurchased: !item.isPurchased);
        }
        return item;
      }).toList(),
    );
  }

  ShoppingList resetAllPurchases() {
    return ShoppingList(
      id: id,
      name: name,
      items: items.map((item) => item.copyWith(isPurchased: false)).toList(),
    );
  }

  bool isProductPurchased(String productId) {
    return items
        .firstWhere(
          (item) => item.productId == productId,
          orElse: () => ShoppingListItem(
            productId: productId,
            isPurchased: false,
          ),
        )
        .isPurchased;
  }

  bool containsProduct(String productId) {
    return items.any((item) => item.productId == productId);
  }
}
