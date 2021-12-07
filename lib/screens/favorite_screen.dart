import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';
import '../models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const FavoriteScreen(this.favoriteMeals,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(favoriteMeals.isEmpty){
      return Container(
        color: Colors.white,
        child: const Text("You have no favorites yet - start adding some!"),
      );
    }
    else{
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (context, index)=>
            MealItem(
              id:favoriteMeals[index].id,
              title:favoriteMeals[index].title,
              imageUrl: favoriteMeals[index].imageUrl,
              duration: favoriteMeals[index].duration,
              complexity: favoriteMeals[index].complexity,
              affordability: favoriteMeals[index].affordability,

            ),
      );
    }
  }
}
