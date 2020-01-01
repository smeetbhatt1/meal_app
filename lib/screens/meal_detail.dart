import 'package:flutter/material.dart';
import 'package:food_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  Widget buildSectionTitle(ctx, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final _id = _args['id'];
    final _selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == _id);
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedMeal.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(_selectedMeal.imageUrl),
              ),
              buildSectionTitle(context, "Ingredients"),
              buildContainer(ListView.builder(
                itemBuilder: (_, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(_selectedMeal.ingredients[index])),
                  );
                },
                itemCount: _selectedMeal.ingredients.length,
              )),
              buildSectionTitle(context, "Steps"),
              buildContainer(ListView.separated(
                separatorBuilder: (_, __) => Divider(
                  color: Colors.grey,
                ),
                itemCount: _selectedMeal.steps.length,
                itemBuilder: (_, i) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text("# ${i + 1}"),
                    ),
                    title: Text("${_selectedMeal.steps[i]}"),
                  );
                },
              )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context).pop(_id);
        },
      ),
    );
  }
}
