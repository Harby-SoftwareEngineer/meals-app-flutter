import 'package:flutter/material.dart';
import 'package:meals/providers/language_provider.dart';
import 'package:meals/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../providers/meal_provider.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatelessWidget {
  bool? fromOnBoarding;

  FiltersScreen({Key? key, fromOnBoarding = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;
    final lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: fromOnBoarding ?? false ? null : const MainDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              title: fromOnBoarding ?? false
                  ? null
                  : Text(
                      lan.getTexts('filters_appBar_title').toString(),
                    ),
              backgroundColor: fromOnBoarding ?? false
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).colorScheme.primary,
              elevation: fromOnBoarding ?? false ? 0 : 5,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  lan.getTexts('filters_screen_title').toString(),
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ),
              buildSwitchListTile(
                  lan.getTexts('Gluten-free').toString(),
                  lan.getTexts('Gluten-free-sub').toString(),
                  currentFilters['gluten']!, (newValue) {
                currentFilters['gluten'] = newValue;
                Provider.of<MealProvider>(context, listen: false).setFilters();
              },
                context,
              ),
              buildSwitchListTile(
                  lan.getTexts('Lactose-free').toString(),
                  lan.getTexts('Lactose-free_sub').toString(),
                  currentFilters['lactose']!, (newValue) {
                currentFilters['lactose'] = newValue;
                Provider.of<MealProvider>(context, listen: false).setFilters();
              },
                context,
              ),
              buildSwitchListTile(
                  lan.getTexts('Vegetarian').toString(),
                  lan.getTexts('Vegetarian-sub').toString(),
                  currentFilters['vegetarian']!, (newValue) {
                currentFilters['vegetarian'] = newValue;

                Provider.of<MealProvider>(context, listen: false).setFilters();
              },
                context,
              ),
              buildSwitchListTile(
                  lan.getTexts('Vegan').toString(),
                  lan.getTexts('Vegan-sub').toString(),
                  currentFilters['vegan']!, (newValue) {
                currentFilters['vegan'] = newValue;
                Provider.of<MealProvider>(context, listen: false).setFilters();
              },
                context,
              ),
              SizedBox(
                height: fromOnBoarding ?? false ? 80 : 0,
              )
            ])),
          ],
        ),
      ),
    );
  }

  SwitchListTile buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue, BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
      inactiveTrackColor:
          Provider.of<ThemeProvider>(context, listen: true).tm ==
                  ThemeMode.light
              ? null
              : Colors.black,
    );
  }
}
