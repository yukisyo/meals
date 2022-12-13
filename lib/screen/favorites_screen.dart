import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal>? favoriteMeals;
  const FavoritesScreen({Key? key, this.favoriteMeals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals == null || favoriteMeals!.isEmpty) {
      return const Center(child: Text('no data yet'));
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            meal: favoriteMeals![index],
            removeItem: () {},
          );
        },
        itemCount: favoriteMeals?.length,
      );
    }
  }
}
