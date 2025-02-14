class Recipe {
  final String title;
  final String image;
  final List<dynamic> ingredients;
  final String instructions;

  Recipe({
    required this.title,
    required this.image,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] ?? 'No Title',
      image: json['image'] ?? '',
      ingredients: json['extendedIngredients'] ?? [],
      instructions: json['instructions'] ?? 'No instructions provided.',
    );
  }
}
