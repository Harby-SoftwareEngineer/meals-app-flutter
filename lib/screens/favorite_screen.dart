import 'package:flutter/material.dart';
import 'package:meals/providers/language_provider.dart';
import 'package:provider/provider.dart';

import '../providers/meal_provider.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoriteScreen extends StatelessWidget {

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    double dw = MediaQuery.of(context).size.width;
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    final List<Meal> favoriteMeals = Provider.of<MealProvider>(context, listen: true).favoriteMeals;
    if(favoriteMeals.isEmpty){
      return  Center(child: Text(lan.getTexts('favorites_text').toString()));
    }
    else{
      return GridView.builder(
        itemCount: favoriteMeals.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw <=400 ? 400 : 500,
          childAspectRatio: isLandScape? dw/(dw*0.8) : dw/(dw*0.75),
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
        ),
        itemBuilder: (context, index)=>
            MealItem(
              id:favoriteMeals[index].id,
              imageUrl: favoriteMeals[index].imageUrl,
              duration: favoriteMeals[index].duration,
              complexity: favoriteMeals[index].complexity,
              affordability: favoriteMeals[index].affordability,

            ),
      );
    }
  }
}
