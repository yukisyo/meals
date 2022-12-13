import 'package:flutter/material.dart';
import 'package:meals/dummy_categories.dart';
import 'package:meals/screen/categories_screen.dart';
import 'package:meals/screen/category_meals_screen.dart';
import 'package:meals/screen/filters_screen.dart';
import 'package:meals/screen/meal_detail_screen.dart';
import 'package:meals/screen/tabs_screen.dart';

import 'models/meal.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "glutenFree": false,
    "vegetarian": false,
    "vegan": false,
    "lactoseFree": false,
  };

  List<Meal> _availableMeals = dummyMeals;
  List<Meal>? _favoriteMeals;

  void _toggleFavoriteMeal(String mealId) {
    print(mealId);
    final existingIndex =
        _favoriteMeals?.indexWhere((meal) => meal.id == mealId);
    if (existingIndex != null && existingIndex! > 0) {
      setState(() {
        _favoriteMeals?.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals
            ?.add(dummyMeals.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool isFavorite(String id) {
    if (_favoriteMeals == null) {
      return false;
    }
    return _favoriteMeals?.any((element) => element.id == id) as bool;
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = dummyMeals.where((meal) {
        if (_filters['glutenFree']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['lactoseFree']! && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
            secondary: Colors.amber,
          ),
          fontFamily: 'RaleWay',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge:
                    const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyMedium:
                    const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                titleMedium: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      // home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (_) => TabScreen(favoriteMeals: _favoriteMeals),
        CategoryMealsScreen.routeName: (_) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (_) => MealDetailScreen(
              toggleFavoriteMeal: _toggleFavoriteMeal,
              isFavorite: isFavorite,
            ),
        FilterScreen.routeName: (_) => FilterScreen(
              saveFilters: _setFilters,
              currentFilters: _filters,
            ),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => const CategoryMealsScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
