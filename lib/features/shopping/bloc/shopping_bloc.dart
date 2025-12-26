import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/grocery_item.dart';
import 'shopping_event.dart';
import 'shopping_state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  ShoppingBloc() : super(const ShoppingState(items: [], selectedIds: {})) {
    on<ShoppingStarted>(_onStarted);
    on<ShoppingItemToggled>(_onToggled);
  }

  void _onStarted(ShoppingStarted event, Emitter<ShoppingState> emit) {
    const items = [
      GroceryItem(id: 'apples', name: 'Apples', price: 3.99),
      GroceryItem(id: 'bread', name: 'Bread', price: 2.49),
      GroceryItem(id: 'milk', name: 'Milk', price: 4.29),
      GroceryItem(id: 'eggs', name: 'Eggs', price: 5.99),
      GroceryItem(id: 'cheese', name: 'Cheese', price: 6.49),
      GroceryItem(id: 'chicken', name: 'Chicken', price: 8.99),
      GroceryItem(id: 'rice', name: 'Rice', price: 4.79),
      GroceryItem(id: 'pasta', name: 'Pasta', price: 3.29),
      GroceryItem(id: 'tomatoes', name: 'Tomatoes', price: 3.49),
      GroceryItem(id: 'coffee', name: 'Coffee', price: 12.99),
    ];

    emit(state.copyWith(items: items, selectedIds: <String>{}));
  }

  void _onToggled(ShoppingItemToggled event, Emitter<ShoppingState> emit) {
    final next = {...state.selectedIds};
    if (next.contains(event.itemId)) {
      next.remove(event.itemId);
    } else {
      next.add(event.itemId);
    }
    emit(state.copyWith(selectedIds: next));
  }
}
