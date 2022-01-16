import 'package:flutter/material.dart';
import 'package:meals/providers/language_provider.dart';
import 'package:meals/screens/on_boarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/category_meals_screen.dart';
import '../providers/meal_provider.dart';
import 'screens/meal_detail_screen.dart';
import 'providers/theme_provider.dart';
import 'screens/filters_screen.dart';
import 'screens/themes_screen.dart';
import 'screens/tabs_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen =  prefs.getBool('watched') ?? false ? const TabsScreen() : const OnBoardingScreen();

  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<MealProvider>(
          create: (ctx)=> MealProvider(),
        ),

        ChangeNotifierProvider<ThemeProvider>(
          create: (ctx)=> ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (ctx)=> LanguageProvider(),
        ),
      ],
        child: MyApp(homeScreen),
      )
  );
}

class MyApp extends StatelessWidget {
  Widget homeScreen;
  MyApp(this.homeScreen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context,listen: true)
        .primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context,listen: true)
        .accentColor;
    var tm = Provider.of<ThemeProvider>(context,listen: true)
        .tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        cardColor: Colors.white,
        shadowColor: Colors.white60,

        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
            //  Color.fromRGBO(20, 51, 51, 1),
          ),
          headline6: const TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
          headline4: const TextStyle(
            //fontSize: 20,
            color: Colors.black87,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor),
      ),
      darkTheme: ThemeData(
        canvasColor: const Color.fromRGBO(14, 27, 23, 1),
        fontFamily: 'Raleway',
        iconTheme: const IconThemeData(
          color: Colors.white70,
        ),
        cardColor: const Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.black45,
        unselectedWidgetColor: Colors.white70,
        textTheme: ThemeData.dark().textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Colors.white60,
          //  Color.fromRGBO(20, 51, 51, 1),
          ),
          headline6: const TextStyle(
            fontSize: 20,
            color: Colors.white70,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
          headline4: const TextStyle(
            //fontSize: 20,
            color: Colors.white,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor),
      ),
      routes: {
        '/': (context)=> homeScreen,
        'TabsScreen': (context)=>  const TabsScreen(),
        'CategoryMealsScreen': (context)=>  const CategoryMealsScreen(),
        'MealDetailScreen': (context)=>  const MealDetailScreen(),
        'FiltersScreen': (context)=>   FiltersScreen(),
        'ThemesScreen': (context)=> ThemesScreen(),

      },

    );
  }
}
