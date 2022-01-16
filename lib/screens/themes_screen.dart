import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meals/providers/language_provider.dart';
import 'package:meals/providers/theme_provider.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:provider/provider.dart';


class ThemesScreen extends StatelessWidget {
  bool fromOnBoarding;
   ThemesScreen({this.fromOnBoarding = false,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: fromOnBoarding ? null : const MainDrawer(),
        appBar: fromOnBoarding ? AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0.0,
        ) : AppBar(
          title: Text( lan.getTexts('theme_appBar_title').toString(),),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                lan.getTexts('theme_screen_title').toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    lan.getTexts('theme_mode_title').toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildRadioListTile(ThemeMode.system,lan.getTexts('System_default_theme').toString(), null, context),
                buildRadioListTile(ThemeMode.light, lan.getTexts('light_theme').toString(), Icons.wb_sunny_outlined, context),
                buildRadioListTile(ThemeMode.dark,  lan.getTexts('dark_theme').toString(), Icons.nights_stay_outlined, context),
                buildListTile( context, 'primary'),
                buildListTile( context, 'accent'),
                SizedBox(height: fromOnBoarding ? 80:0,)
              ],
            )),

          ],
        ),
      ),
    );
  }

  RadioListTile buildRadioListTile(ThemeMode themeVal,String text, IconData? icon, BuildContext context){
    return RadioListTile(
      secondary: Icon(icon, color: Theme.of(context).iconTheme.color,),
      groupValue: Provider.of<ThemeProvider>(context,listen: true).tm,
      value: themeVal,
      title: Text(text),
      onChanged: (newThemeVal){
        Provider.of<ThemeProvider>(context,listen: false)
            .themeModeChange(newThemeVal);
      },
    );
  }

  ListTile buildListTile(BuildContext context, text){
    var primaryColor = Provider.of<ThemeProvider>(context,listen: true)
        .primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context,listen: true)
        .accentColor;
    final lan = Provider.of<LanguageProvider>(context, listen: true);

    return ListTile(
      title: Text(lan.getTexts(text).toString()),
      trailing: CircleAvatar(
        backgroundColor: text == 'primary' ? primaryColor : accentColor,
      ),
      onTap: (){
        showDialog(context: context, builder: (BuildContext ctx){
          return AlertDialog(
            elevation: 4,
            titlePadding: const EdgeInsets.all(0.0),
            contentPadding: const EdgeInsets.all(0.0),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: text == 'primary'
                    ? Provider.of<ThemeProvider>(context,listen: true)
                    .primaryColor
                    : Provider.of<ThemeProvider>(context,listen: true)
                    .accentColor,
                onColorChanged: (newColor){
                  Provider.of<ThemeProvider>(context,listen: false)
                      .onChanged(newColor, text == 'primary' ? 1 :2);
                },
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: true,
                showLabel: false,
              ),
            ),
          );
        });
      },
    );
  }
}
