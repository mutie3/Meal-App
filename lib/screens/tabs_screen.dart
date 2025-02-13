import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categrois_secreen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_secreen.dart';
import 'package:meals/widgets/main_drawer.dart';
import '../models/meal.dart';
import '../providers/fav_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIdx = 0;

  void _setScreen(String identifier) {
    if (identifier == 'meals') {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const TabsScreen()));
    } else {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final seletedMeal = ref.watch(filterdMealProvider);

    Widget activePage = CategroisSecreen(
      avilableMeals: seletedMeal,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIdx == 1) {
      final List<Meal> _favoritMeal = ref.watch(favProviderNotifier);
      activePage = MealsSecreen(
        meals: _favoritMeal,
      );
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIdx,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'categores'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
