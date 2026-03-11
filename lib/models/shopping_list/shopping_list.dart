import 'package:collection/collection.dart';
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

  /// Добавляет новый [ShoppingListItem] к списку.
  ShoppingList addProduct(ShoppingListItem product) {
    if (containsProduct(product.baseProductId)) {
      return this;
    }

    return ShoppingList(
      id: id,
      name: name,
      items: [
        ...items,
        product,
      ],
    );
  }

  /// Удаляет из списка [ShoppingListItem] по id базового продукта.
  ShoppingList removeProduct(String productId) {
    return ShoppingList(
      id: id,
      name: name,
      items: items.where((item) => item.baseProductId != productId).toList(),
    );
  }

  /// Изменяет состояние покупки [ShoppingListItem] по id базового продукта.
  ShoppingList togglePurchaseStatus(String productId) {
    return ShoppingList(
      id: id,
      name: name,
      items: items.map((item) {
        if (item.baseProductId == productId) {
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

  /// Проверяет состояние покупки [ShoppingListItem] по id базового продукта.
  bool isProductPurchased(String productId) {
    return items
            .firstWhereOrNull(
              (item) => item.baseProductId == productId,
            )
            ?.isPurchased ??
        false;
  }

  /// Проверяет наличие в списке [ShoppingListItem] по id базового продукта.
  bool containsProduct(String productId) {
    return items.any((item) => item.baseProductId == productId);
  }
}
