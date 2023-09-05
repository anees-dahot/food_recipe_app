import 'package:flutter/material.dart';
import 'package:food_recipe_app/screens/recipe_details.dart';

import '../model/api_request.dart';
import '../model/model.dart';

class CategoryRecipeListPage extends StatelessWidget {
  final String category;

  CategoryRecipeListPage({required this.category});

  

  @override
  Widget build(BuildContext context) {
      double mWidth = MediaQuery.of(context).size.width;
     double mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes for $category'),
      ),
      body: FutureBuilder<List<RecipeModel>>(
        future: ApiRequest().getRecipesByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Add a loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No recipes found.');
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items in each row
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipe = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipeDetails(recipe: recipe)),
                      );
                    },
                    child: Container(
                      height: mheight * 0.77,
                      child: Card(
                        elevation: 0,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(recipe.imageUrl, width: 300, height: 110, fit: BoxFit.cover),
                                ),
                                SizedBox(height: 10),
                                Text(recipe.label, maxLines: 1),
                              ],
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  '${recipe.calories.toStringAsFixed(0)} Calories',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
