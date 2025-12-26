import 'package:equatable/equatable.dart';
import '../model/grocery_item.dart';

class ShoppingState extends Equatable {
  const ShoppingState({
    required this.items,
    required this.selectedIds,
  });

  final List<GroceryItem> items;
  final Set<String> selectedIds;

  bool isSelected(String id) => selectedIds.contains(id);

  double get total {
    double sum = 0.0;
    for (final item in items) {
      if (selectedIds.contains(item.id)) sum += item.price;
    }
    return sum;
  }

  ShoppingState copyWith({
    List<GroceryItem>? items,
    Set<String>? selectedIds,
  }) {
    return ShoppingState(
      items: items ?? this.items,
      selectedIds: selectedIds ?? this.selectedIds,
    );
  }

  @override
  List<Object?> get props => [items, selectedIds];
}
