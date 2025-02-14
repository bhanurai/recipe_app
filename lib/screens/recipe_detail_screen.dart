
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../models/recipe_model.dart';
// import '../services/api_service.dart';

// class RecipeDetailScreen extends ConsumerWidget {
//   final RecipeModel recipe;

//   const RecipeDetailScreen({super.key, required this.recipe});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isFavorite = ref.watch(favoritesProvider).contains(recipe);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(recipe.title),
//         backgroundColor: Colors.orange,
//         actions: [
//           IconButton(
//             icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
//             onPressed: () {
//               if (isFavorite) {
//                 ref.read(favoritesProvider.notifier).removeFavorite(recipe);
//               } else {
//                 ref.read(favoritesProvider.notifier).addFavorite(recipe);
//               }
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(recipe.image, width: double.infinity, fit: BoxFit.cover),
//             const SizedBox(height: 10),
//             Text(recipe.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             const Text("Ingredients:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 5),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 for (String ingredient in ["Salt", "Pepper", "Chicken", "Garlic"]) 
//                   ListTile(
//                     leading: const Icon(Icons.check_box_outline_blank),
//                     title: Text(ingredient),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.add_shopping_cart),
//                       onPressed: () {
//                         ref.read(shoppingListProvider.notifier).addIngredient(ingredient);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('$ingredient added to shopping list')),
//                         );
//                       },
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const Text("Instructions:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 5),
//             const Text(
//               "1. Preheat oven to 350°F.\n"
//               "2. Season the chicken with salt and pepper.\n"
//               "3. Cook until golden brown and serve hot.",
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/services/api_service.dart';
import '../models/recipe_model.dart';

class RecipeDetailScreen extends ConsumerWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider).contains(recipe);

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              if (isFavorite) {
                ref.read(favoritesProvider.notifier).removeFavorite(recipe);
              } else {
                ref.read(favoritesProvider.notifier).addFavorite(recipe);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipe.image, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(recipe.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Ingredients:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recipe.ingredients.map((ingredient) {
                return ListTile(
                  leading: const Icon(Icons.check_box_outline_blank),
                  title: Text('${ingredient['name']} (${ingredient['quantity']} ${ingredient['unit']})'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      ref.read(shoppingListProvider.notifier).addIngredient(ingredient['name']);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${ingredient['name']} added to shopping list')),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            const Text("Instructions:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recipe.instructions.map((step) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(step, style: const TextStyle(fontSize: 16)),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
