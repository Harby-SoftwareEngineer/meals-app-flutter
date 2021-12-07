import 'package:flutter/material.dart';

import '../dummy_data.dart';
import 'package:meals/models/meal.dart';


class MealDetailScreen extends StatelessWidget {
  static const  routeName = 'MealDetailScreen';
  final Function toggleFavorite;
  final Function isMealFavorite;
  const MealDetailScreen(this.toggleFavorite,this.isMealFavorite,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments ;
    final categoryId = mealId;

    final selectedMeal =DUMMY_MEALS.firstWhere((meal)=> meal.id == categoryId );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedMeal.title,
          //style: const TextStyle(fontSize: 10),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover,),
            ),
            buildContainerTitle(context,'Ingredients'),
            buildContainer(
                ListView.builder(
                  itemCount: selectedMeal.ingredients.length,
                  itemBuilder: (context,index)=>
                      Card(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(selectedMeal.ingredients[index],),
                          )),
                )
            ),
            buildContainerTitle(context,'Steps'),
            buildContainer(
                ListView.builder(
                  itemCount: selectedMeal.steps.length,
                  itemBuilder: (context,index)=>
                      Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('#${index +1}'),
                            ),
                            title: Text(selectedMeal.steps[index],style: const TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                          ),
                          const Divider(),
                        ],
                      ),
                )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>toggleFavorite(mealId),
        child:  Icon(
          isMealFavorite(mealId) ? Icons.star: Icons.star_border,
        ),
      ),
    );
  }

  Container buildContainer(Widget child) {
    return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 300,
          height: 200,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: child,
        );
  }

  Container buildContainerTitle(BuildContext context, String text) {
    return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(text, style: Theme.of(context).textTheme.subtitle1,),
        );
  }
}
