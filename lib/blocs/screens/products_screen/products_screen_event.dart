part of 'products_screen_bloc.dart';

abstract class ProductsScreenEvent extends Equatable {
  const ProductsScreenEvent();

  @override
  bool get stringify => true;
}

class ProductsScreenStarted extends ProductsScreenEvent {
  final String? shoppingListId;
  const ProductsScreenStarted(this.shoppingListId);

  @override
  List<Object?> get props => [shoppingListId];
}

// Событие добавления/удаления продукта в списке покупок.
class ProductsScreenProductToggled extends ProductsScreenEvent {
  final Product product;
  const ProductsScreenProductToggled(this.product);

  @override
  List<Object> get props => [product];
}

// Общий список продуктов изменился.
class ProductsBoxChanged extends ProductsScreenEvent {
  const ProductsBoxChanged();

  @override
  List<Object> get props => const [];
}
