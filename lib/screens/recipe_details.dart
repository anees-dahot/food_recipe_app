import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/model.dart';

class RecipeDetails extends StatelessWidget {
  final RecipeModel recipe;

  

 

  RecipeDetails({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(recipe.label),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Image.network(
                recipe.imageUrl,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Text(
              //     recipe.label,
              //     style: GoogleFonts.poppins(
              //       fontSize: 30,
              //       fontWeight: FontWeight.bold,
              //       height: 1,
              //     ),
              //   ),
              // ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Ingredients:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              for (var ingredient in recipe.ingredients)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: ListTile(
                    leading: Image.network(
                      ingredient.image,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    title: Text(ingredient.name, style: GoogleFonts.montserrat(fontSize: 14),),
                    trailing: Text('Quantity: ${ingredient.weight}'),
                  ),
                ),
                SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}
