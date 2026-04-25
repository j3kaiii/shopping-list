part of 'shopping_screen_bloc.dart';

abstract class ShoppingScreenState extends Equatable {
  const ShoppingScreenState();

  @override
  bool get stringify => true;
}

class ShoppingInitial extends ShoppingScreenState {
  const ShoppingInitial();

  @override
  List<Object> get props => const [];
}

class ShoppingLoadSuccess extends ShoppingScreenState {
  final ShoppingList shopping;
  final bool editMode;
  const ShoppingLoadSuccess(this.shopping, this.editMode);

  @override
  List<Object> get props => [shopping, editMode];
}
