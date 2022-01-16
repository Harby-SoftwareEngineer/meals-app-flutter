import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/language_provider.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;


  const MealItem({
    required this.id,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    Key? key
    }
      ) : super(key: key);



  void selectMeal(BuildContext ctx) {
    Navigator.pushNamed(
      ctx,
      'MealDetailScreen',
      arguments: id,
    ).then((mealId) { //removeItem(mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);

    return InkWell(
      onTap: ()=>selectMeal(context),
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
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
                    child: Hero(
                        tag: id,
                        child: InteractiveViewer(
                            child: FadeInImage(
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 235,
                                placeholder: const AssetImage('assets/images/a2.png'),
                                image: NetworkImage(imageUrl,)))),
                  ),
                  Container(
                    width: 220,
                    padding: const EdgeInsets.all(8),
                    //margin: const EdgeInsets.only(bottom: 20),
                    color: Colors.black54,
                    child: Text(
                      lan.getTexts('meal-$id').toString(),
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
                    buildRow(
                        Icons.schedule,
                       duration <= 10
                           ?duration.toString()+ lan.getTexts('min2').toString()
                           :duration.toString()+ lan.getTexts('min').toString(),
                        context),
                    buildRow(Icons.work,lan.getTexts(complexity.toString()) , context),
                    buildRow(Icons.attach_money,lan.getTexts(affordability.toString()), context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildRow(IconData icon, dynamic text, BuildContext context) {
    return Row(
                  children: [
                    Icon(icon,color: Theme.of(context).iconTheme.color,),
                    const SizedBox(width: 6,),
                    Text(text.toString()),
                  ],
                );
  }
}
