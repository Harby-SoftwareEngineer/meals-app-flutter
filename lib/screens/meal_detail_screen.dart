import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/providers/language_provider.dart';
import 'package:provider/provider.dart';

import '../providers/meal_provider.dart';
import '../dummy_data.dart';



class MealDetailScreen extends StatefulWidget {
   const MealDetailScreen({Key? key}) : super(key: key);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {

String mealId = '';
  @override
  void didChangeDependencies() {
    mealId = ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    final lan = Provider.of<LanguageProvider>(context, listen: true);

    var accentColor = Theme.of(context).colorScheme.secondary;

    final selectedMeal =DUMMY_MEALS.firstWhere((meal)=> meal.id == mealId );

    List<String> liIngredients =
    lan.getTexts('ingredients-$mealId') as List<String>;
    ListView buildListViewIngredients(Meal selectedMeal, Color accentColor) {
      return ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemCount: liIngredients.length,
        itemBuilder: (context,index)=>
            Card(
                color: accentColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    liIngredients[index],
                    style: TextStyle(color: useWhiteForeground(accentColor) ? Colors.white : Colors.black),
                  ),
                )),
      );
    }
    List<String> stepsLi =
    lan.getTexts('steps-$mealId') as List<String>;
    ListView buildListViewSteps(Meal selectedMeal) {
      return ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemCount: stepsLi.length,
        itemBuilder: (context,index)=>
            Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Text('#${index +1}'),
                  ),
                  title: Text(stepsLi[index],
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color:  Colors.black
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
      );
    }


    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(lan.isEn ? 10 : 10),
                title: Text(
                  lan.getTexts('meal-$mealId').toString(),
                ),
                background: Hero(
                    tag: mealId,
                    child: InteractiveViewer(
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(selectedMeal.imageUrl, ),
                          placeholder: const AssetImage('assets/images/a2.png'),
                        ))),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              if (isLandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        buildContainerTitle(context,'Ingredients'),
                        buildContainer(
                            buildListViewIngredients(selectedMeal, accentColor)
                            , context
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        buildContainerTitle(context,'Steps'),
                        buildContainer(
                            buildListViewSteps(selectedMeal)
                            , context
                        ),
                      ],
                    ),
                  ],
                ) else
                if (!isLandScape)buildContainerTitle(context,'Ingredients'),
              if (!isLandScape) buildContainer(
                  buildListViewIngredients(selectedMeal, accentColor)
                  , context
              ),
              if (!isLandScape) buildContainerTitle(context,'Steps'),
              if (!isLandScape) buildContainer(
                  buildListViewSteps(selectedMeal)
                  , context
              ),
            ])),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=> Provider.of<MealProvider>(context, listen: false).toggleFavorite(mealId),
          child:  Icon(
            Provider.of<MealProvider>(context, listen: true).isMealFavorite(mealId)
                ? Icons.star: Icons.star_border,
          ),
        ),
      ),
    );

  }

  Container buildContainer(Widget child ,BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    double dw = MediaQuery.of(context).size.width;
    double dh = MediaQuery.of(context).size.height;
    return Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          width: isLandScape ? (dw*0.5-30) : dw,
          height: isLandScape ? (dh*0.5) : (dh * 0.25),
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(1),
          child: child,
        );
  }

  Container buildContainerTitle(BuildContext context, String text) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    return Container(
      alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(lan.getTexts(text).toString(), style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
          ),
        );
  }
}
