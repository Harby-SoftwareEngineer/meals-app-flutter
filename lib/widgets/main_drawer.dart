import 'package:flutter/material.dart';
import 'package:meals/providers/language_provider.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0.0,
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: lan.isEn ?Alignment.centerLeft : Alignment.centerRight,
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                (lan.getTexts('drawer_name')).toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            buildListTile((lan.getTexts('drawer_item1')).toString(), Icons.restaurant, (){Navigator.pushReplacementNamed(context, 'TabsScreen');} ,context),
            buildListTile((lan.getTexts('drawer_item2')).toString(), Icons.settings, (){Navigator.pushReplacementNamed(context, 'FiltersScreen');} ,context),
            buildListTile((lan.getTexts('drawer_item3')).toString(), Icons.color_lens, (){Navigator.pushReplacementNamed(context, 'ThemesScreen');} ,context),
            const Divider(),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 20,right: 22),
              child: Text(
                (lan.getTexts('drawer_switch_title')).toString(),
                style: Theme.of(context).textTheme.headline6,
              ),

            ),
            Padding(
                padding:EdgeInsets.only(right: (lan.isEn? 0 : 20), left: (lan.isEn? 20:0), bottom: (lan.isEn? 0 : 20)) ,
              child: Row(
                children: [
                  Text(
                      (lan.getTexts('drawer_switch_item1')).toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch(
                      value: Provider.of<LanguageProvider>(context, listen: true).isEn,
                      onChanged: (newValue){
                        Provider.of<LanguageProvider>(context, listen: false).changeLan(newValue);
                      },
                  ),
                  Text(
                    (lan.getTexts('drawer_switch_item2')).toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  Widget buildListTile(String title, IconData icon, Function() onTap, BuildContext context){
    return ListTile(
      leading: Icon(icon, size: 26, color: Theme.of(context).iconTheme.color,),
      title: Text(
        title,
        style:  TextStyle(
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
      onTap: onTap,
    );

  }
}
