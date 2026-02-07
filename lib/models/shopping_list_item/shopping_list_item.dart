import 'package:hive/hive.dart';

part 'shopping_list_item.g.dart';

@HiveType(typeId: 2)
class ShoppingListItem extends HiveObject {
  @HiveField(0)
  final String productId;
  @HiveField(1)
  bool isPurchased;
  @HiveField(2)
  int quantity; // кол-во бутылок молока?
  
  ShoppingListItem({
    required this.productId,
    this.isPurchased = false,
    this.quantity = 1,
  });

  ShoppingListItem copyWith({
    bool? isPurchased,
    int? quantity,
  }) {
    return ShoppingListItem(
      productId: productId,
      isPurchased: isPurchased ?? this.isPurchased,
      quantity: quantity ?? this.quantity,
    );
  }
}