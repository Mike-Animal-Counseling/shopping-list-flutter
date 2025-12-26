import 'package:equatable/equatable.dart';

abstract class ShoppingEvent extends Equatable {
  const ShoppingEvent();

  @override
  List<Object?> get props => [];
}

class ShoppingStarted extends ShoppingEvent {
  const ShoppingStarted();
}

class ShoppingItemToggled extends ShoppingEvent {
  const ShoppingItemToggled(this.itemId);
  final String itemId;

  @override
  List<Object?> get props => [itemId];
}
