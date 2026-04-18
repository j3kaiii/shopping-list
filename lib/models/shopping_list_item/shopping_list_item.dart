import 'package:hive/hive.dart';
import 'package:shopping_list_example/models/product/product.dart';
import 'package:uuid/uuid.dart';

part 'shopping_list_item.g.dart';

const _uuid = Uuid();

/// Реализация продукта, добавленного в список покупок.
@HiveType(typeId: 2)
class ShoppingListItem extends HiveObject {
  // id текущего продукта
  @HiveField(0)
  final String id;
  // id базового продукта [Product],
  // на основании которого создан текущий объект.
  @HiveField(1)
  final String baseProductId;
  // Название базового продукта [Product],
  // на основании которого создан текущий объект.
  @HiveField(2)
  final String baseName;
  // отметка о покупке
  @HiveField(3)
  bool isPurchased;
  // кол-во, объем или масса...
  // например: 2 буханки хлеба или 500 грамм соли.
  @HiveField(4)
  int quantity = 1;

  ShoppingListItem({
    String? id,
    required this.baseProductId,
    required this.baseName,
    this.isPurchased = false,
    this.quantity = 1,
    UnitType unitType = UnitType.pieces,
  }) : id = id ?? _uuid.v4();

  static ShoppingListItem create(Product product, {int quantity = 1}) =>
      ShoppingListItem(
        baseProductId: product.id,
        baseName: product.name,
        quantity: quantity,
      );

  ShoppingListItem copyWith({
    bool? isPurchased,
    int? quantity,
  }) {
    return ShoppingListItem(
      id: id,
      baseProductId: baseProductId,
      baseName: baseName,
      isPurchased: isPurchased ?? this.isPurchased,
      quantity: quantity ?? this.quantity,
    );
  }
}
