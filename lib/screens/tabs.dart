import 'package:flutter/material.dart';
import 'package:foodhiz/providers/favorites_provider.dart';
import 'package:foodhiz/screens/categories.dart';
import 'package:foodhiz/screens/filters.dart';
import 'package:foodhiz/screens/meals.dart';
import 'package:foodhiz/widgets/main_drawer.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodhiz/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeals = [];

  // void _toggleMealFavouriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);
  //   setState(() {
  //     if (isExisting) {
  //       _favoriteMeals.remove(meal);
  //       _showInfoMessage('Meal is no longer a favorite');
  //     } else {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('Marked as a favorite');
  //     }
  //   });
  // }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filter') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availalbeMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availalbeMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
