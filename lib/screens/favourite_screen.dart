import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_service.dart';
import '../widgets/recipe_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.orange,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorite recipes'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return RecipeCard(
                  recipe: favorites[index],
                );
              },
            ),
    );
  }
}
