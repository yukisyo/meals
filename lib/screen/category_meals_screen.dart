import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  const CategoryMealsScreen({super.key, required this.availableMeals});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal>? displayedMeals;
  String? title;
  bool _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_loadedInitData == false) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, Category>;
      title = routeArgs['category']!.title;
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(routeArgs['category']?.id);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals?.removeWhere((element) => element.id == mealId);
    });
  }

  // final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            meal: displayedMeals![index],
            removeItem: () => _removeMeal(displayedMeals![index].id),
          );
        },
        itemCount: displayedMeals?.length,
      ),
    );
  }
}
