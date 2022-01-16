import 'package:flutter/material.dart';
import 'package:meals/providers/language_provider.dart';
import 'package:meals/providers/theme_provider.dart';

import '../screens/categories_screen.dart';
import '../screens/favorite_screen.dart';
import '../widgets/main_drawer.dart';

import 'package:provider/provider.dart';

import '../providers/meal_provider.dart';

class TabsScreen extends StatefulWidget {

  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedPageIndex=0;
  List<Map<String, Object>> _pages = [];
  void _selectTap(int value) {
    setState(() {
      selectedPageIndex = value;
    });
  }
  @override
  void initState() {
    Provider.of<MealProvider>(context, listen: false).getData();
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColors();
    Provider.of<LanguageProvider>(context, listen: false).getLan();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    _pages = [
      {
        'page':const CategoriesScreen(),
        'title': lan.getTexts('categories'),
      },
      {
        'page': const FavoriteScreen(),
        'title': lan.getTexts('your_favorites'),
      }
    ];
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[selectedPageIndex]['title'].toString()),
        ),
        body: _pages[selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectTap,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.white,
          currentIndex: selectedPageIndex,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.category),
              label: lan.getTexts('categories').toString(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.star),
              label: lan.getTexts('your_favorites').toString(),
            ),
          ],
        ),
        drawer: const MainDrawer(),
      ),
    );
  }

}
