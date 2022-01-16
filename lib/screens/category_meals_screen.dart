import 'package:flutter/material.dart';
import 'package:meals/providers/language_provider.dart';
import 'package:provider/provider.dart';

import '../providers/meal_provider.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const  routeName = 'displayedMealsScreen';
  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryId = '';
  List<Meal> displayedMeals = <Meal>[];

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals = Provider.of<MealProvider>(context, listen: true).availableMeals;
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
     categoryId = routeArg['id']!;
    displayedMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    double dw = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(lan.getTexts('cat-$categoryId').toString()),),
        body: GridView.builder(
          itemCount: displayedMeals.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw <=400 ? 400 : 500,
            childAspectRatio: isLandScape? dw/(dw*0.8) : dw/(dw*0.75),
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,

          ),
          itemBuilder: (context, index)=>
          MealItem(
            id:displayedMeals[index].id,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,

          ),
        ),
      ),
    );
  }

}
