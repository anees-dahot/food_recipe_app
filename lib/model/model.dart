// class RecipeModel{
//   late String name;
//   late String imageUrl;
//   // late String ingredient;
//   late double calories;

//   RecipeModel({ this.name = '',  this.imageUrl = '', this.calories = 0.0} );


//    factory RecipeModel.fromJson(Map<String, dynamic> recipe) {
    

    

//     return RecipeModel(
//       name: recipe['label'],
//       imageUrl: recipe['image'],
//       calories: recipe['calories'],

//     );
//   }
// }

// class Ingredient {
//   late String name;
//   late String image;
//   late String weight;

//   Ingredient({this.name = '', this.image = '', this.weight = ''})

// final List<dynamic> ingredientList = recipe['ingredients'];
//   final ingredients = ingredientList.map((ingredientData) {
      
//     }).toList();
//     factory RecipeModel.fromJson(Map<String, dynamic> recipe) {
    

    

//     return Ingredient(
//         name: recipe['text'],
//         image: recipe['image'],
//         weight: recipe['weight'],
//       );
//   }
    
    
// }

class RecipeModel {
  final String label;
  final String imageUrl;
  final double calories;
  final List<Ingredient> ingredients;

  RecipeModel({
    required this.label,
    required this.imageUrl,
    required this.calories,
    required this.ingredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    final List<Ingredient> parsedIngredients = (json['ingredients'] as List)
        .map((ingredient) => Ingredient.fromJson(ingredient))
        .toList();

    return RecipeModel(
      label: json['label'],
      imageUrl: json['image'],
      calories: json['calories'],
      ingredients: parsedIngredients,
    );
  }
}

class Ingredient {
  final String name;
  final String image;
  final double weight;

  Ingredient({
    required this.name,
    required this.image,
    required this.weight,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['text'],
      image: json['image'],
      weight: json['quantity'],
    );
  }
}


class RandomRecipeModel {
  final String label;
  final String imageUrl;
  final double calories;
  final List<Ingredient> ingredients;

  RandomRecipeModel({
    required this.label,
    required this.imageUrl,
    required this.calories,
    required this.ingredients,
  });

  factory RandomRecipeModel.fromJson(Map<String, dynamic> json) {
    final List<Ingredient> parsedIngredients = (json['ingredients'] as List)
        .map((ingredient) => Ingredient.fromJson(ingredient))
        .toList();

    return RandomRecipeModel(
      label: json['label'],
      imageUrl: json['image'],
      calories: json['calories'],
      ingredients: parsedIngredients,
    );
  }
}

