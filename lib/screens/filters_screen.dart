import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'FiltersScreen';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  const FiltersScreen(this.currentFilters,this.saveFilters,{Key key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
    bool _glutenFree = widget.currentFilters['gluten'];
    bool _lactoseFree = widget.currentFilters['lactose'];
    bool _vegan = widget.currentFilters['vegan'];
    bool _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: (){
              final Map<String, bool> selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children:  [
          Padding(
            padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.subtitle1,
              ),),
          Expanded(
              child: ListView(
                children: [
                  buildSwitchListTile(
                    'Gluten-free',
                    'Only include gluten-free meals',
                      _glutenFree,
                      (newValue){
                      setState(() {
                        _glutenFree = newValue;
                      });
                      }
                  ),
                  buildSwitchListTile(
                      'Lactose-free',
                      'Only include lactose-free meals',
                      _lactoseFree,
                          (newValue){
                        setState(() {
                          _lactoseFree = newValue;
                        });
                      }
                  ),
                  buildSwitchListTile(
                      'Vegetarian-free',
                      'Only include vegetarian-free meals',
                      _vegetarian,
                          (newValue){
                        setState(() {
                          _vegetarian = newValue;
                        });
                      }
                  ),
                  buildSwitchListTile(
                      'Vegan-free',
                      'Only include vegan-free meals',
                      _vegan,
                          (newValue){
                        setState(() {
                          _vegan = newValue;
                        });
                      }
                  ),
                ],
          ))

        ],
      ),
    );
  }

  SwitchListTile buildSwitchListTile(String title, String description, bool currentValue, Function updateValue){
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }
}
