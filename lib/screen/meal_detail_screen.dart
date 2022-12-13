import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final void Function(String mealId) toggleFavoriteMeal;
  final bool Function(String mealId) isFavorite;
  const MealDetailScreen(
      {Key? key, required this.toggleFavoriteMeal, required this.isFavorite})
      : super(key: key);

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium));
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(isFavorite(meal.id) ? Icons.star : Icons.star_border),
          onPressed: () => toggleFavoriteMeal(meal.id),
        ),
        appBar: AppBar(
          title: Text(meal.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Colors.orange,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(meal.ingredients[index]),
                    ),
                  );
                },
                itemCount: meal.ingredients.length,
              )),
              buildSectionTitle(context, 'Steps'),
              buildContainer(ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(meal.steps[index]),
                    ),
                    const Divider()
                  ],
                ),
                itemCount: meal.steps.length,
              )),
            ],
          ),
        ));
  }
}
