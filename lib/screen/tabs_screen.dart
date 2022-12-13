import 'package:flutter/material.dart';
import 'package:meals/screen/categories_screen.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import 'favorites_screen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal>? favoriteMeals;
  const TabScreen({Key? key, required this.favoriteMeals}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // Widget buildDefaultTab() {
  //   return DefaultTabController(
  //     length: 2,
  //     initialIndex: 0,
  //     child: Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Meals'),
  //         bottom: const TabBar(
  //           tabs: [
  //             Tab(icon: Icon(Icons.category), text: 'Categories'),
  //             Tab(icon: Icon(Icons.star), text: 'Favorites'),
  //           ],
  //         ),
  //       ),
  //       body: const TabBarView(
  //         children: [
  //           CategoriesScreen(),
  //           FavoritesScreen(
  //             favoriteMeals: widget.favoriteMeals,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(
          favoriteMeals: widget.favoriteMeals,
        ),
        'title': 'Your Favorite',
      },
    ];
    super.initState();
  }

  int _selectPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectPageIndex]['title'].toString()),
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.orange,
        currentIndex: _selectPageIndex,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
