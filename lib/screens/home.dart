import 'package:flutter/material.dart';
import 'package:food_recipe_app/screens/recipe_details.dart';
import 'package:food_recipe_app/screens/top_pick_recipe_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/api_request.dart';
import '../model/model.dart';
import 'category_recipe_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List CategoriesList = [
  'breakfast',
  'lunch',
  'dinner',
  'appetizers',
  'soup',
  'beef',
  'pork',
  'sandwich',
  'desserts'
];

List categoryImages = [
  'assets/burger.png',
  'assets/lunch-box.png',
  'assets/dinner-time.png',
  'assets/cocktail.png',
  'assets/hot-soup.png',
  'assets/butcher-ax.png',
  'assets/steak.png',
  'assets/sandwich.png',
  'assets/cake.png',
];

List recipeList = [];

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  List<RandomRecipeModel> searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  void performSearch(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiRequest = ApiRequest();
    double mWidth = MediaQuery.of(context).size.width;
     double mheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: mheight * 0.02,),
                const Text('Hello There'),
                Text(
                  'What would you like\nto cook today?',
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.bold, height: 1),
                ),
                SizedBox(height: mheight * 0.02,),
                TextField(
                  controller: _searchController,
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                  onSubmitted: (_) {
                    performSearch(_searchController.text);
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.green
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: 'Search for recipes...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        performSearch(_searchController.text);
                      },
                    ),
                  ),
                ),
                 SizedBox(
                  height: mheight * 0.02,
                ),
                if (searchQuery.isNotEmpty)
                  FutureBuilder<List<RecipeModel>>(
                    future: ApiRequest().getRecipesBySearch(searchQuery),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Add a loading indicator
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return const Text('No recipes found.');
                      } else {
                        return SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final recipe = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeDetails(
                                                  recipe: recipe)),
                                    );
                                  },
                                  child: SizedBox(
                                    // height: 700,
                                    width: mWidth * 0.25,
                                    child: Card(
                                      elevation: 0,
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    recipe.imageUrl,
                                                    width: 300,
                                                    height: 110,
                                                    fit: BoxFit.cover),
                                              ),
                                               SizedBox(height: mheight * 0.01),
                                              Text(recipe.label, maxLines: 1),
                                            ],
                                          ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                '${recipe.calories.toStringAsFixed(0)} Calories',
                                                style: const TextStyle(
                                                    color: Colors.white),
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
                          ),
                        );
                      }
                    },
                  ),
                 SizedBox(
                  height: mheight * 0.02,
                ),
                if (searchQuery.isEmpty)
                  Text('Categories',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                if (searchQuery.isEmpty)
                  SizedBox(
                    height: mheight * 0.16,
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: CategoriesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CategoryRecipeListPage(
                                  category: CategoriesList[index],
                                ),
                              ));
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(categoryImages[index],
                                        width: 50, height: 50),
                                    Text(
                                      CategoriesList[index],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                 SizedBox(
                  height: mheight * 0.03,
                ),
                if (searchQuery.isEmpty)
                  Text('Top Picks For you',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                if (searchQuery.isEmpty)
                   SizedBox(
                    height: mheight * 0.02,
                  ),
                if (searchQuery.isEmpty)
                  FutureBuilder<List<RandomRecipeModel>>(
                    future: ApiRequest().getRandomRecipes(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Add a loading indicator
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return const Text('No recipes found.');
                      } else {
                        return SizedBox(
                          height: mheight * 0.25,
                          width: double.maxFinite,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final recipe = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TopPicksRecipeDetailsScreen(
                                                  recipe: recipe)),
                                    );
                                  },
                                  child: SizedBox(
                                    height: mheight * 0.77,
                                    width: mWidth * 0.6,
                                    child: Card(
                                      elevation: 0,
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    recipe.imageUrl,
                                                    width: 300,
                                                    height: 110,
                                                    fit: BoxFit.cover),
                                              ),
                                               SizedBox(height: mheight * 0.03),
                                              Text(recipe.label, maxLines: 1),
                                            ],
                                          ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                '${recipe.calories.toStringAsFixed(0)} Calories',
                                                style: const TextStyle(
                                                    color: Colors.white),
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
                          ),
                        );
                      }
                    },
                  ),
                if (searchQuery.isEmpty)
                   SizedBox(
                    height: mheight * 0.02,
                  ),
                if (searchQuery.isEmpty)
                  Text('Recipe Of the week',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                if (searchQuery.isEmpty)
                   SizedBox(
                    height: mheight * 0.02,
                  ),
                if (searchQuery.isEmpty)
                  FutureBuilder<List<RandomRecipeModel>>(
                    future: ApiRequest().getRecipesOfTheWeek(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Add a loading indicator
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return const Text('No recipes found.');
                      } else {
                        return SizedBox(
                          height: mheight * 0.26,
                          width: double.maxFinite,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final recipe = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TopPicksRecipeDetailsScreen(
                                                  recipe: recipe)),
                                    );
                                  },
                                  child: SizedBox(
                                    height: mheight * 0.8,
                                    width: mWidth * 0.6,
                                    child: Card(
                                      elevation: 0,
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    recipe.imageUrl,
                                                    width: 300,
                                                    height: 110,
                                                    fit: BoxFit.cover),
                                              ),
                                               SizedBox(height: mheight * 0.03),
                                              Text(recipe.label, maxLines: 1),
                                            ],
                                          ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                '${recipe.calories.toStringAsFixed(0)} Calories',
                                                style: const TextStyle(
                                                    color: Colors.white),
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
                          ),
                        );
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
