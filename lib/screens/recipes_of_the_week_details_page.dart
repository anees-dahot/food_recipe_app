import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/model.dart';

class GetRecipeOfTheWeekDetailsPage extends StatelessWidget {
  final RandomRecipeModel recipe;

  

 

  GetRecipeOfTheWeekDetailsPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
      double mWidth = MediaQuery.of(context).size.width;
     double mheight = MediaQuery.of(context).size.height;
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
         
              SizedBox(height: mheight *0.03),
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
              SizedBox(height: mheight * 0.03),
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
                SizedBox(height: mheight * 0.05,)
            ],
          ),
        ),
      ),
    );
  }
}
