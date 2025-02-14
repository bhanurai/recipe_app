class IngredientModel {
  final String name;
  final String quantity;
  final String unit;
  bool isChecked;

  IngredientModel({
    required this.name,
    required this.quantity,
    required this.unit,
    this.isChecked = false,
  });

  IngredientModel copyWith({bool? isChecked}) {
    return IngredientModel(
      name: name,
      quantity: quantity,
      isChecked: isChecked ?? this.isChecked, unit: '',
    );
  }
}

class RecipeModel {
  final int id;
  final String title;
  final String image;
  final String summary;
  final List<Map<String, dynamic>> ingredients; // Changed to dynamic
  final List<String> instructions;

  RecipeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.summary,
    required this.ingredients,
    required this.instructions,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      image: json['image'] ?? 'https://via.placeholder.com/150',
      summary: json['summary'] ?? 'No description available',
      ingredients: (json['extendedIngredients'] as List<dynamic>? ?? [])
          .map((item) {
            return {
              'name': item['name'] ?? 'Unknown',
              'quantity': item['amount'] ?? 'N/A'
            };
          }).toList(),
      instructions: List<String>.from(json['instructions'] ?? []),
    );
  }
}
