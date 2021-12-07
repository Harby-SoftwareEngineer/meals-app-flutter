import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;


  const MealItem({this.id,
    this.title,
    this.imageUrl,
    this.duration,
    this.complexity,
    this.affordability,
    }
      );

  String get complexityText{
    switch(complexity){
      case Complexity.simple: return 'Simple';break;
      case Complexity.challenging: return 'Challenging';break;
      case Complexity.hard: return 'Hard';break;
      default: return 'Unknown';break;

    }
  }
  String get affordabilityText{
    switch(affordability){
      case Affordability.affordable: return 'Affordable';break;
      case Affordability.pricey: return 'Pricey';break;
      case Affordability.luxurious: return 'Luxurious';break;
      default: return 'Unknown';break;

    }
  }
  void selectMeal(BuildContext ctx) {
    Navigator.pushNamed(
      ctx,
      MealDetailScreen.routeName,
      arguments: id,
    ).then((mealId) { //removeItem(mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>selectMeal(context),
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(imageUrl,height: 200,width: double.infinity,fit: BoxFit.cover,),
                ),
                Container(
                  width: 220,
                  padding: const EdgeInsets.all(8),
                  //margin: const EdgeInsets.only(bottom: 20),
                  color: Colors.black54,
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 24,color: Colors.white),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildRow(Icons.schedule,"$duration min"),
                  buildRow(Icons.work,complexityText),
                  buildRow(Icons.attach_money,affordabilityText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildRow(IconData icon, String text) {
    return Row(
                  children: [
                    Icon(icon),
                    const SizedBox(width: 5,),
                    Text(text),
                  ],
                );
  }
}
