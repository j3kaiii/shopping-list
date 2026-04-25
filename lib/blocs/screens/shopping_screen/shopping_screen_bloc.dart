import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';
import 'package:shopping_list_example/models/shopping_list_item/shopping_list_item.dart';

part 'shopping_screen_state.dart';
part 'shopping_screen_event.dart';

class ShoppingScreenBloc
    extends Bloc<ShoppingScreenEvent, ShoppingScreenState> {
  late final Box<ShoppingList> listsBox;
  late ShoppingList shopping;
  bool _editMode = false;

  ShoppingScreenBloc() : super(const ShoppingInitial()) {
    on<ShoppingShown>(_mapScreenShownToState);
    on<ShoppingItemStatusChanged>(_mapItemStatusChangedToState);
    on<ShoppingItemRemoved>(_mapItemRemovedToState);
    on<ShoppingItemEdit>(_mapItemEditToState);
    on<ShoppingToggleEditMode>(_mapToggleEditModToState);
    on<ShoppingReset>(_mapShoppingResetToState);
    on<_ListsBoxChanged>(_mapListsBoxChanged);
  }

  @override
  Future<void> close() {
    listsBox.listenable().removeListener(_onBoxChanged);
    return super.close();
  }

  Future<void> _mapScreenShownToState(
    ShoppingShown event,
    Emitter<ShoppingScreenState> emit,
  ) async {
    _editMode = event.editMode;
    shopping = event.shopping;
    listsBox = Hive.box<ShoppingList>(listsBoxName);

    emit(ShoppingLoadSuccess(shopping, event.editMode));

    listsBox.listenable().addListener(_onBoxChanged);
  }

  Future<void> _mapItemStatusChangedToState(
    ShoppingItemStatusChanged event,
    Emitter<ShoppingScreenState> emit,
  ) async {
    shopping = shopping.togglePurchaseStatus(event.item.baseProductId);
    await listsBox.put(shopping.id, shopping);
    emit(ShoppingLoadSuccess(shopping, _editMode));
  }

  Future<void> _mapItemRemovedToState(
    ShoppingItemRemoved event,
    Emitter<ShoppingScreenState> emit,
  ) async {
    shopping = shopping.removeProduct(event.item.baseProductId);
    await listsBox.put(shopping.id, shopping);
    emit(ShoppingLoadSuccess(shopping, _editMode));
  }

  Future<void> _mapItemEditToState(
    ShoppingItemEdit event,
    Emitter<ShoppingScreenState> emit,
  ) async {
    shopping = shopping.updateItem(event.item);
    await listsBox.put(shopping.id, shopping);
    emit(ShoppingLoadSuccess(shopping, _editMode));
  }

  Future<void> _mapToggleEditModToState(
    ShoppingToggleEditMode event,
    Emitter<ShoppingScreenState> emit,
  ) async {
    _editMode = !_editMode;
    emit(ShoppingLoadSuccess(shopping, _editMode));
  }

  Future<void> _mapShoppingResetToState(
    ShoppingReset event,
    Emitter<ShoppingScreenState> emit,
  ) async {
    shopping = shopping.resetAllPurchases();
    await listsBox.put(shopping.id, shopping);
    emit(ShoppingLoadSuccess(shopping, _editMode));
  }

  void _mapListsBoxChanged(
    _ListsBoxChanged event,
    Emitter<ShoppingScreenState> emit,
  ) {
    final currentList = listsBox.get(shopping.id);
    if (currentList != null) {
      shopping = currentList;
      emit(ShoppingLoadSuccess(shopping, _editMode));
    }
  }

  void _onBoxChanged() {
    if (!isClosed) {
      add(const _ListsBoxChanged());
    }
  }
}
