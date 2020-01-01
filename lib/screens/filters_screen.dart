import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const RouteName = "/filters";
  final Function saveFilters;
  final Map<String, bool> _currentFilters;
  FiltersScreen(this._currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _gluttenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactosFree = false;

  Widget _buildSwitchListTile(
      String title, String description, bool value, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: value,
      onChanged: updateValue,
    );
  }

  @override
  void initState() {
    _gluttenFree = widget._currentFilters['gluten'];
    _lactosFree = widget._currentFilters['lactose'];
    _vegetarian = widget._currentFilters['vegetarian'];
    _vegan = widget._currentFilters['vegan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _gluttenFree,
                  'lactose': _lactosFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                };
                widget.saveFilters(selectedFilters);
              }),
        ],
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile('Gluten free',
                      'Only includes gluten free mean', _gluttenFree, (newVal) {
                    setState(() => _gluttenFree = newVal);
                  }),
                  _buildSwitchListTile(
                      'Lactose free',
                      'Only includes loactose free mean',
                      _lactosFree, (newVal) {
                    setState(() => _lactosFree = newVal);
                  }),
                  _buildSwitchListTile(
                      'Vegetarian', 'Only includes egetarian mean', _vegetarian,
                      (newVal) {
                    setState(() => _vegetarian = newVal);
                  }),
                  _buildSwitchListTile(
                      'Vegan', 'Only includes vegan mean', _vegan, (newVal) {
                    setState(() => _vegan = newVal);
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
