
import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const  routeName = 'displayedMealsScreen';
  final List<Meal> availableMeals;
  const CategoryMealsScreen(this.availableMeals,{Key key}) : super(key: key);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;

  void _removeMeal(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArg = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    displayedMeals =widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle),),
      body: ListView.builder(
        itemCount: displayedMeals.length,
        itemBuilder: (context, index)=>
        MealItem(
          id:displayedMeals[index].id,
          title:displayedMeals[index].title,
          imageUrl: displayedMeals[index].imageUrl,
          duration: displayedMeals[index].duration,
          complexity: displayedMeals[index].complexity,
          affordability: displayedMeals[index].affordability,

        ),
      ),
    );
  }

}
