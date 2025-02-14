// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:recipe_app/screens/favourite_screen.dart';
// import 'package:recipe_app/screens/shopping_list_screen.dart';
// import 'package:recipe_app/widgets/serach_bar.dart';

// import '../services/api_service.dart';
// import '../widgets/recipe_card.dart';

// final searchProvider = StateProvider<String>((ref) => '');

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final searchQuery = ref.watch(searchProvider);
//     final recipeAsyncValue = ref.watch(recipeProvider(searchQuery));

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Interactive Recipe App'),
//         backgroundColor: Colors.orange,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.favorite),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const FavoritesScreen()),
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.shopping_cart),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const ShoppingListScreen()),
//               );
//             },
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: SearchBarWidget(),
//           ),
//           Expanded(
//             child: recipeAsyncValue.when(
//               data: (recipes) => recipes.isEmpty
//                   ? const Center(child: Text('No recipes found'))
//                   : ListView.builder(
//                       itemCount: recipes.length,
//                       itemBuilder: (context, index) {
//                         return RecipeCard(recipe: recipes[index]);
//                       },
//                     ),
//               loading: () => const Center(child: CircularProgressIndicator()),
//               error: (err, _) => Center(child: Text('Error: $err')),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/screens/favourite_screen.dart';
import 'package:recipe_app/screens/shopping_list_screen.dart';
import 'package:recipe_app/services/api_service.dart';
import 'package:recipe_app/widgets/serach_bar.dart';

import '../widgets/recipe_card.dart';

// Define the searchProvider state for managing search query
final searchProvider = StateProvider<String>((ref) => '');

// Define HomeScreen that uses Riverpod to manage state
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchProvider);  // Watch the current search query
    final recipeAsyncValue = ref.watch(recipeProvider(searchQuery));  // Watch the recipeProvider for fetching recipes

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Recipe App'),
        backgroundColor: Colors.orange,
        actions: [
          // Favorite screen button
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesScreen()),
              );
            },
          ),
          // Shopping cart button
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShoppingListScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar widget
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchBarWidget(),
          ),
          Expanded(
            child: recipeAsyncValue.when(
              // When recipes are successfully fetched
              data: (recipes) {
                return recipes.isEmpty
                    ? const Center(child: Text('No recipes found'))
                    : ListView.builder(
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = recipes[index];
                          return RecipeCard(recipe: recipe);  
                        },
                      );
              },
              // Loading state
              loading: () => const Center(child: CircularProgressIndicator()),
              // Error state
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
