import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/recipe_model.dart';

const String apiKey = '17ef0c362dc94e5685c947bf703efdaf';
const String baseUrl = 'https://api.spoonacular.com/recipes/complexSearch';

final recipeProvider =
    FutureProvider.family<List<RecipeModel>, String>((ref, query) async {
  final url = Uri.parse(
      '$baseUrl?apiKey=$apiKey&query=$query&number=10&addRecipeInformation=true');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return (data['results'] as List)
        .map((recipe) => RecipeModel.fromJson(recipe))
        .toList();
  } else {
    throw Exception('Failed to load recipes');
  }
});

// Fetch recipe details by ID
Future<RecipeModel> fetchRecipeDetails(int recipeId) async {
  final url = Uri.parse(
      '$baseUrl/$recipeId/information?apiKey=$apiKey&includeNutrition=false');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return RecipeModel.fromJson(data);
  } else {
    throw Exception('Failed to load recipe details');
  }
}

final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<String>>((ref) {
  return ShoppingListNotifier();
});

class ShoppingListNotifier extends StateNotifier<List<String>> {
  ShoppingListNotifier() : super([]);

  void addIngredient(String ingredient) {
    if (!state.contains(ingredient)) {
      state = [...state, ingredient];
    }
  }

  void removeIngredient(String ingredient) {
    state = state.where((item) => item != ingredient).toList();
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<RecipeModel>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<RecipeModel>> {
  FavoritesNotifier() : super([]);

  void addFavorite(RecipeModel recipe) {
    if (!state.contains(recipe)) {
      state = [...state, recipe];
    }
  }

  void removeFavorite(RecipeModel recipe) {
    state = state.where((item) => item != recipe).toList();
  }
}
