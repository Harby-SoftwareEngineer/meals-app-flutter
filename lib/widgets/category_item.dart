import 'package:flutter/material.dart';
import 'package:meals/providers/language_provider.dart';
import 'package:provider/provider.dart';


class CategoryItem extends StatelessWidget {
  final String id;

  final Color color;
  const CategoryItem(this.id,this.color,{Key? key}) : super(key: key);

  void selectCategory(BuildContext ctx){
    Navigator.pushNamed(ctx,
        'CategoryMealsScreen',
    arguments: {
      'id':id,

    }
    );
  }
  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);

    return InkWell(
        onTap: ()=> selectCategory(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Text((lan.getTexts('cat-$id')).toString(),style: Theme.of(context).textTheme.subtitle1,),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.5),
                color,
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),);
  }
}
