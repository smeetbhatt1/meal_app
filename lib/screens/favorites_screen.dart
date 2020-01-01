import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favouritesMeal;

  FavoritesScreen(this._favouritesMeal);

  @override
  Widget build(BuildContext context) {
    return _favouritesMeal.isEmpty
        ? Center(
            child: Text("No favorites added yet!!!"),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                id: _favouritesMeal[index].id,
                title: _favouritesMeal[index].title,
                imageUrl: _favouritesMeal[index].imageUrl,
                duration: _favouritesMeal[index].duration,
                affordability: _favouritesMeal[index].affordability,
                complexity: _favouritesMeal[index].complexity,
              );
            },
            itemCount: _favouritesMeal.length,
          );
  }
}
