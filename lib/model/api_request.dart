// import 'dart:convert';

// import 'package:food_recipe_app/model/model.dart';
// import 'package:food_recipe_app/screens/home.dart';
import 'dart:convert';

import 'package:http/http.dart';

// class ApiRequest{

// String appId = '0884c5e1';
// String appKey = 'e7673361d255692919846f756f9e6e85';



// Future<void> getRecipeWithCategory(String categorie) async{


// Response response = await get(Uri.parse('https://api.edamam.com/search?q=$categorie&app_id=$appId&app_key=$appKey'));

// Map data = jsonDecode(response.body);
// data['hits'].forEach((element){
//   RecipeModel recipeModel = new RecipeModel();
//   recipeModel  =recipeModel.fromMap(element['recipe']);
//   recipeList.add(recipeModel);

// });


// }

  
import 'model.dart';


class ApiRequest {
  static const String appId = '0884c5e1';
  static const String appKey = 'e7673361d255692919846f756f9e6e85';
  static const String baseUrl = 'https://api.edamam.com/search';

  Future<List<RecipeModel>> getRecipesByCategory(String category) async {
    final String url =
        '$baseUrl?q=$category&app_id=$appId&app_key=$appKey';

    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> hits = data['hits'];

      return hits.map((hit) {
        final Map<String, dynamic> recipeData = hit['recipe'];
        return RecipeModel.fromJson(recipeData);
      }).toList();
    } else {
      throw Exception('Failed to fetch recipes');
    }
  }


  Future<List<RandomRecipeModel>> getRandomRecipes() async {
  final String url = '$baseUrl?q=beef&app_id=$appId&app_key=$appKey';

  final response = await get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> hits = data['hits'];

    return hits.map((hit) {
      final Map<String, dynamic> recipeData = hit['recipe'];
      return RandomRecipeModel.fromJson(recipeData);
    }).toList();
  } else {
    throw Exception('Failed to fetch random recipes');
  }
}

 Future<List<RandomRecipeModel>> getRecipesOfTheWeek() async {
  final String url = '$baseUrl?q=custard&app_id=$appId&app_key=$appKey';

  final response = await get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> hits = data['hits'];

    return hits.map((hit) {
      final Map<String, dynamic> recipeData = hit['recipe'];
      return RandomRecipeModel.fromJson(recipeData);
    }).toList();
  } else {
    throw Exception('Failed to fetch random recipes');
  }
}



 Future<List<RecipeModel>> getRecipesBySearch(String query) async {
    final String url =
        '$baseUrl?q=$query&app_id=$appId&app_key=$appKey';

    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> hits = data['hits'];

      return hits.map((hit) {
        final Map<String, dynamic> recipeData = hit['recipe'];
        return RecipeModel.fromJson(recipeData);
      }).toList();
    } else {
      throw Exception('Failed to fetch recipes');
    }
  }

}
