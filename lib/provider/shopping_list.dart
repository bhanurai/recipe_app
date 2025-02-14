import 'package:flutter/foundation.dart';
import 'package:recipe_app/models/ingredient_model.dart';

class ShoppingListNotifier extends ChangeNotifier {
  final List<IngredientModel> _shoppingList = [];

  List<IngredientModel> get shoppingList => _shoppingList;

  void addIngredient(IngredientModel ingredient) {
    _shoppingList.add(ingredient);
    notifyListeners();
  }

  void removeIngredient(IngredientModel ingredient) {
    _shoppingList.remove(ingredient);
    notifyListeners();
  }
}
