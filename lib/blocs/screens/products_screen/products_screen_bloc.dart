import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/models/product/product.dart';
import 'package:shopping_list_example/models/shopping_list/shopping_list.dart';
import 'package:shopping_list_example/models/shopping_list_item/shopping_list_item.dart';

part 'products_screen_event.dart';
part 'products_screen_state.dart';

class ProductsScreenBloc
    extends Bloc<ProductsScreenEvent, ProductsScreenState> {
  late final Box<Product> productsBox;
  late final Box<ShoppingList> listsBox;
  ShoppingList? _shoppingList;

  ProductsScreenBloc() : super(const ProductsScreenInitial()) {
    on<ProductsScreenStarted>(_mapScreenStartedToState);
    on<ProductsScreenProductToggled>(_mapProductToggledToState);
    on<ProductsBoxChanged>(_mapProductsBoxChanged);
  }

  @override
  Future<void> close() {
    productsBox.listenable().removeListener(_onBoxChanged);
    if (_shoppingList != null) {
      listsBox.listenable().removeListener(_onBoxChanged);
    }
    return super.close();
  }

  Future<void> _mapScreenStartedToState(
    ProductsScreenStarted event,
    Emitter<ProductsScreenState> emit,
  ) async {
    productsBox = await Hive.openBox<Product>(productsBoxName);
    listsBox = Hive.box<ShoppingList>(listsBoxName);

    final listId = event.shoppingListId;
    if (listId != null) {
      _shoppingList = listsBox.get(listId);
      listsBox.listenable().addListener(_onBoxChanged);
    }

    emit(ProductsScreenLoadSuccess(productsBox.values.toList(), _shoppingList));

    productsBox.listenable().addListener(_onBoxChanged);
  }

  void _mapProductsBoxChanged(
    ProductsBoxChanged event,
    Emitter<ProductsScreenState> emit,
  ) {
    if (_shoppingList != null) {
      final updatedList = listsBox.get(_shoppingList!.id);
      if (updatedList != null) {
        _shoppingList = updatedList;
      }
    }
    emit(ProductsScreenLoadSuccess(productsBox.values.toList(), _shoppingList));
  }

  Future<void> _mapProductToggledToState(
    ProductsScreenProductToggled event,
    Emitter<ProductsScreenState> emit,
  ) async {
    final list = _shoppingList;
    if (list == null) return;

    final product = event.product;

    if (list.containsProduct(product.id)) {
      _shoppingList = list.removeProduct(product.id);
    } else {
      final newListItem = ShoppingListItem.create(product);
      _shoppingList = list.addProduct(newListItem);
    }

    await listsBox.put(_shoppingList!.id, _shoppingList!);

    emit(ProductsScreenLoadSuccess(productsBox.values.toList(), _shoppingList));
  }

  void _onBoxChanged() {
    if (!isClosed) {
      add(const ProductsBoxChanged());
    }
  }
}
