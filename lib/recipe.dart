// class RecipeDetail {
//   final String title;
//   final String image;
//   final String summary;
//   final List<Map<String, dynamic>> ingredients;
//   final List<String> instructions;

//   RecipeDetail({
//     required this.title,
//     required this.image,
//     required this.summary,
//     required this.ingredients,
//     required this.instructions,
//   });

//   factory RecipeDetail.fromJson(Map<String, dynamic> json) {
//     return RecipeDetail(
//       title: json['title'] ?? 'No Title',
//       image: json['image'] ?? 'https://via.placeholder.com/150',
//       summary: json['summary'] ?? 'No description available',
//       ingredients: (json['extendedIngredients'] as List<dynamic>?)?.map((item) {
//         return {
//           'name': item['name'] ?? 'Unknown',
//           'quantity': item['amount'] ?? 'N/A',
//         };
//       }).toList() ?? [],
//       instructions: List<String>.from(json['instructions'] ?? []),
//     );
//   }
// }


// class Recipe {
//   final int id;
//   final String image;
//   final String title;
//   final List<Ingredient> extendedIngredients;  // List of ingredients

//   Recipe({
//     required this.id,
//     required this.image,
//     required this.title,
//     required this.extendedIngredients,
//   });

//   // From JSON parsing
//   factory Recipe.fromJson(Map<String, dynamic> json) {
//     var ingredientsFromJson = json['extendedIngredients'] as List;
//     List<Ingredient> ingredientsList =
//         ingredientsFromJson.map((i) => Ingredient.fromJson(i)).toList();

//     return Recipe(
//       id: json['id'],
//       image: json['image'],
//       title: json['title'],
//       extendedIngredients: ingredientsList,
//     );
//   }
// }

// class Ingredient {
//   final String name;
//   final String original;

//   Ingredient({
//     required this.name,
//     required this.original,
//   });

//   factory Ingredient.fromJson(Map<String, dynamic> json) {
//     return Ingredient(
//       name: json['name'],
//       original: json['original'],
//     );
//   }
// }
