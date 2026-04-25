part of 'shopping_screen_bloc.dart';

abstract class ShoppingScreenEvent extends Equatable {
  const ShoppingScreenEvent();

  @override
  bool get stringify => true;
}

class ShoppingShown extends ShoppingScreenEvent {
  final ShoppingList shopping;
  final bool editMode;
  const ShoppingShown(this.shopping, this.editMode);

  @override
  List<Object> get props => [shopping, editMode];
}

class ShoppingItemStatusChanged extends ShoppingScreenEvent {
  final ShoppingListItem item;
  const ShoppingItemStatusChanged(this.item);

  @override
  List<Object> get props => [item];
}

class ShoppingItemRemoved extends ShoppingScreenEvent {
  final ShoppingListItem item;
  const ShoppingItemRemoved(this.item);

  @override
  List<Object> get props => [item];
}

class ShoppingToggleEditMode extends ShoppingScreenEvent {
  const ShoppingToggleEditMode();

  @override
  List<Object> get props => const [];
}

class ShoppingReset extends ShoppingScreenEvent {
  const ShoppingReset();

  @override
  List<Object> get props => const [];
}

class ShoppingItemEdit extends ShoppingScreenEvent {
  final ShoppingListItem item;
  const ShoppingItemEdit(this.item);

  @override
  List<Object> get props => [item];
}

class _ListsBoxChanged extends ShoppingScreenEvent {
  const _ListsBoxChanged();

  @override
  List<Object> get props => const [];
}
