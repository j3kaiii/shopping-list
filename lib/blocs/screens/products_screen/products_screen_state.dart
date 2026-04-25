part of 'products_screen_bloc.dart';

abstract class ProductsScreenState extends Equatable {
  const ProductsScreenState();

  @override
  bool get stringify => true;
}

class ProductsScreenInitial extends ProductsScreenState {
  const ProductsScreenInitial();

  @override
  List<Object> get props => const [];
}

class ProductsScreenLoadSuccess extends ProductsScreenState {
  final List<Product> products;
  final ShoppingList? shoppingList;
  const ProductsScreenLoadSuccess(this.products, this.shoppingList);

  @override
  List<Object?> get props => [products, shoppingList];
}