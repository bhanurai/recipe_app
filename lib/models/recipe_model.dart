// class RecipeModel {
//   final int id;
//   final String title;
//   final String image;
//   final String summary;
//   final List<Map<String, dynamic>> ingredients;
//   final List<String> instructions;

//   RecipeModel({
//     required this.id,
//     required this.title,
//     required this.image,
//     required this.summary,
//     required this.ingredients,
//     required this.instructions,
//   });

//   factory RecipeModel.fromJson(Map<String, dynamic> json) {
//     print('Parsing JSON for Recipe: $json'); // Log the raw JSON

//     return RecipeModel(
//       id: json['id'] ?? 0,
//       title: json['title'] ?? 'No Title',
//       image: json['image'] ?? 'https://via.placeholder.com/150',
//       summary: json['summary'] ?? 'No description available',
//       ingredients: _parseIngredients(json['extendedIngredients']),
//       instructions: _parseInstructions(json['instructions']),
//     );
//   }

//   // Parse ingredients and log out its data type
//   static List<Map<String, dynamic>> _parseIngredients(dynamic ingredients) {
//     print('Ingredients raw data: $ingredients'); // Log the raw ingredients data
//     if (ingredients is List) {
//       return ingredients.map<Map<String, dynamic>>((item) {
//         return {
//           'name': item['name'] ?? 'Unknown',
//           'quantity': item['amount'] ?? 'N/A',
//           'unit': item['unit'] ?? '',
//         };
//       }).toList();
//     }
//     return []; // Return an empty list if it's not a List
//   }

//   // Parse instructions and log out its data type
//   static List<String> _parseInstructions(dynamic instructions) {
//     print('Instructions raw data: $instructions'); // Log the raw instructions data
//     if (instructions is List) {
//       return instructions.map<String>((instruction) => instruction.toString()).toList();
//     } else if (instructions is String) {
//       return [instructions]; // If instructions is a string, wrap it in a list
//     }
//     return []; // Return an empty list if instructions are missing or not in expected format
//   }
// }


class RecipeModel {
  final int id;
  final String title;
  final String image;
  final String summary;
  final List<Map<String, dynamic>> ingredients;
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
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      image: json['image'] ?? 'https://via.placeholder.com/150',
      summary: json['summary'] ?? 'No description available',
      ingredients: _parseIngredients(json['extendedIngredients']),
      instructions: _parseInstructions(json['analyzedInstructions']),
    );
  }

  // Extracts ingredients properly
  static List<Map<String, dynamic>> _parseIngredients(dynamic data) {
    if (data is List) {
      return data.map((item) {
        return {
          'name': item['name'] ?? 'Unknown',
          'quantity': item['amount'] ?? 'N/A',
          'unit': item['unit'] ?? '',
        };
      }).toList();
    }
    return [];
  }

  // Extracts step-by-step instructions
  static List<String> _parseInstructions(dynamic data) {
    if (data is List && data.isNotEmpty) {
      return data[0]['steps']
              ?.map<String>((step) => '${step['number']}. ${step['step']}')
              .toList() ??
          [];
    }
    return ['No instructions available.'];
  }
}
