import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> _availableMeals;

  CategoryMealsScreen(this._availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  List<Meal> _displayedMeals;
  bool _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final _routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      _categoryTitle = _routeArgs['title'];
      final _categoryId = _routeArgs['id'];
      _displayedMeals = widget._availableMeals.where((meal) {
        return meal.categories.contains(_categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(id) {
    setState(() {
      _displayedMeals.removeWhere((i) => i.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    //arguements data retriving

    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _displayedMeals[index].id,
            title: _displayedMeals[index].title,
            imageUrl: _displayedMeals[index].imageUrl,
            duration: _displayedMeals[index].duration,
            affordability: _displayedMeals[index].affordability,
            complexity: _displayedMeals[index].complexity,
          );
        },
        itemCount: _displayedMeals.length,
      ),
    );
  }
}
