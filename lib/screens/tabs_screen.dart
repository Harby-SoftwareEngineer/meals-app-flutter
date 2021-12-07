import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import '../screens/categories_screen.dart';
import '../screens/favorite_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsScreen(this.favoriteMeals,{Key key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedPageIndex=0;
  List<Map<String, Object>> _pages;
  void _selectTap(int value) {
    setState(() {
      selectedPageIndex = value;
    });
  }
  @override
  void initState() {
    _pages = [
      {
        'page':const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoriteScreen(widget.favoriteMeals),
        'title': 'Your Favorites',
      }
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[selectedPageIndex]['title']),
      ),
      body: _pages[selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTap,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }

}
