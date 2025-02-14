import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ingredient_model.dart';

final shoppingListProvider = StateNotifierProvider<ShoppingListNotifier, List<IngredientModel>>(
  (ref) => ShoppingListNotifier(),
);

class ShoppingListNotifier extends StateNotifier<List<IngredientModel>> {
  ShoppingListNotifier() : super([]);

  void addIngredient(IngredientModel ingredient) {
    state = [...state, ingredient];
  }

  void removeIngredient(IngredientModel ingredient) {
    state = state.where((item) => item != ingredient).toList();
  }

  void toggleChecked(IngredientModel ingredient) {
    state = state.map((item) {
      if (item == ingredient) {
        return item.copyWith(isChecked: !item.isChecked);
      }
      return item;
    }).toList();
  }
}
