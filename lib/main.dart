import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/tabs_screen.dart';

import 'screens/category_meals_screen.dart';
import 'screens/filters_screen.dart';
import 'screens/meal_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
   List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >=0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }
  void _setFilters(Map<String, bool> _filterData){
    setState(() {
      _filters =_filterData;

      _availableMeals =  DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }
  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor:Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
          ),
          bodyText2: const TextStyle(
              color: Color.fromRGBO(20, 50, 50, 1),
          ),
          subtitle1: const TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      routes: {
        '/': (context)=>  TabsScreen(_favoriteMeals),
        'CategoryMealsScreen': (context)=>  CategoryMealsScreen(_availableMeals),
        'MealDetailScreen': (context)=>  MealDetailScreen(_toggleFavorite,_isMealFavorite),
        'FiltersScreen': (context)=>  FiltersScreen(_filters,_setFilters),
      },

    );
  }
}
