import 'package:hive/hive.dart';
import 'package:uuid/v4.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String _unitTypeRaw;

  Product({
    required this.id,
    required this.name,
    UnitType type = UnitType.pieces,
  }) : _unitTypeRaw = type.name;

  UnitType get unitType => UnitType.values.byName(_unitTypeRaw);

  // Hive не дает сохранять один объект в разные боксы, нужна копия
  static Product copy(Product item) => Product(
        id: const UuidV4().generate(),
        name: item.name,
      );

  factory Product.create(String name) {
    final id = const UuidV4().generate();
    return Product(id: id, name: name);
  }

  @override
  String toString() => 'Item $id, $name';
}

/// Типы единиц измерения для продуктов
enum UnitType {
  pieces, // штуки (по умолчанию)
  kilograms, // килограммы
  liters, // литры
  meters // метры
}
